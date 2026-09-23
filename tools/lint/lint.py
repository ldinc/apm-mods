#!/usr/bin/env python3
"""Lint the APM mods. Runs inside the Docker image built from tools/lint/Dockerfile;
start it with ./lint.ps1 in the repo root (see tools/lint/README.md).

Two parts, run together by default:

  luals   lua-language-server --check over the mods, with the Factorio type
          definitions (FMTK "luals-addon") of the image's Factorio version.
  data    runs Factorio headless with the mods (throwaway mod folder, default
          mod settings):
            1. a full load test (`--create`): every prototype check the game
               does, plus on_init of all control.lua files;
            2. `--dump-data`, then checks data.raw against prototype-api.json
               and for broken references, sprites outside their image, missing
               locale, ... (see datacheck.py).
          Everything is compared with a vanilla run of the same profile, so
          only what the mods introduce is reported.

Findings are printed to the console and written to a Markdown report
(/out/lint-report.md). Exit code 1 when an error is found (or any finding
with --strict).
"""

from __future__ import annotations

import argparse
import collections
import json
import os
import re
import shutil
import subprocess
import sys
import time
import urllib.parse
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import datacheck  # noqa: E402
import report_md  # noqa: E402

REPO = Path(__file__).resolve().parents[2]
SEVERITIES = ["error", "warning", "info", "hint"]
LUALS_SEVERITY = {1: "error", 2: "warning", 3: "info", 4: "hint"}

# Repo folders that are linted. Other folders (old / deprecated mods) are ignored.
# Override with "lint": {"mods": [...]} in build.config.json.
LINT_MODS = ["apm_energy_addon", "apm_lib", "apm_nuclear", "apm_power", "apm_resource_pack"]


def env_path(name: str) -> Path:
    value = os.environ.get(name)
    if not value:
        die(f"{name} is not set: run the lint with ./lint.ps1 (Docker), not directly")
    return Path(value)


def log(msg: str) -> None:
    # same stream as the findings: Docker does not keep the order between stdout and stderr
    print(msg, flush=True)


def die(msg: str) -> None:
    log(f"lint: {msg}")
    sys.exit(2)


# --------------------------------------------------------------------------------------
# Repo and config
# --------------------------------------------------------------------------------------
class RepoMod:
    def __init__(self, folder: Path):
        self.folder = folder
        with open(folder / "info.json", encoding="utf-8-sig") as fh:
            self.info = json.load(fh)
        self.name: str = self.info["name"]
        self.version: str = self.info.get("version", "0.0.0")

    def dependencies(self) -> list[tuple[str, str]]:
        """(kind, name): kind is required | optional | hidden | incompatible | noorder."""
        out = []
        for dep in self.info.get("dependencies", []):
            dep = dep.strip()
            kind = "required"
            for prefix, k in (("(?)", "hidden"), ("?", "optional"), ("!", "incompatible"), ("~", "noorder")):
                if dep.startswith(prefix):
                    kind, dep = k, dep[len(prefix):].strip()
                    break
            out.append((kind, re.split(r"\s*[<>=]", dep)[0].strip()))
        return out


def repo_mods(folders: list[str]) -> dict[str, RepoMod]:
    """info.json name -> RepoMod for the listed repo folders."""
    mods = {}
    for folder in folders:
        d = REPO / folder
        if not (d / "info.json").is_file():
            log(f"lint: skipping '{folder}': no {folder}/info.json in the repo")
            continue
        m = RepoMod(d)
        mods[m.name] = m
    return mods


def select_mods(all_mods: dict[str, RepoMod], wanted: list[str]) -> list[RepoMod]:
    if not wanted:
        return list(all_mods.values())
    out = []
    for w in wanted:
        w = w.rstrip("/\\")
        hit = [m for m in all_mods.values() if m.folder.name == w or m.name == w]
        if not hit:
            die(f"no linted mod '{w}' (folders: {', '.join(m.folder.name for m in all_mods.values())})")
        out.extend(hit)
    return out


def lint_config() -> dict:
    """The "lint" section of build.config.json: mods, globals, disable."""
    p = REPO / "build.config.json"
    if not p.is_file():
        return {}
    with open(p, encoding="utf-8-sig") as fh:
        cfg = json.load(fh).get("lint", {})
    return {k: v for k, v in cfg.items() if k in ("mods", "globals", "disable")}


def vscode_lua_settings() -> dict:
    """Lua.* settings from .vscode/settings.json (JSON with comments / trailing commas)."""
    p = REPO / ".vscode" / "settings.json"
    if not p.is_file():
        return {}
    text = p.read_text(encoding="utf-8-sig")
    text = re.sub(r'("(?:\\.|[^"\\])*")|//[^\n]*|/\*.*?\*/', lambda m: m.group(1) or "", text, flags=re.S)
    text = re.sub(r",(\s*[}\]])", r"\1", text)
    try:
        return json.loads(text)
    except json.JSONDecodeError as e:
        log(f"lint: ignoring .vscode/settings.json ({e})")
        return {}


class MissingMod(Exception):
    pass


# --------------------------------------------------------------------------------------
# Factorio (headless, in the image)
# --------------------------------------------------------------------------------------
class Factorio:
    def __init__(self, root: Path):
        self.root = root
        self.exe = root / "bin" / "x64" / "factorio"
        self.data = root / "data"
        self.docs = root / "doc-html"
        self.write_data = root  # config-path.cfg in the image: no system directories
        with open(self.data / "base" / "info.json", encoding="utf-8") as fh:
            self.version = json.load(fh)["version"]

    def builtin_mods(self) -> list[str]:
        return sorted(d.name for d in self.data.iterdir() if (d / "info.json").is_file() and d.name != "core")


# --------------------------------------------------------------------------------------
# Output
# --------------------------------------------------------------------------------------
class Report:
    def __init__(self, args):
        self.args = args
        self.items: list[dict] = []
        self.min_rank = SEVERITIES.index(args.min_severity)
        self.meta: dict = {"factorio_runs": [], "luals_noise": 0}

    def add(self, source: str, severity: str, key: str, text: str, **extra) -> None:
        if SEVERITIES.index(severity) > self.min_rank:
            return
        self.items.append({"source": source, "severity": severity, "key": key, "text": text, **extra})

    def visible(self) -> list[dict]:
        return self.items

    def finish(self) -> int:
        for i in self.items:
            print(i["text"], flush=True)
        counts = collections.Counter(i["severity"] for i in self.items)
        summary = ", ".join(f"{counts[s]} {s}{'s' if counts[s] != 1 else ''}" for s in SEVERITIES if counts[s])
        log(f"lint: {summary or 'no problems'}")
        failing = counts["error"] or (self.args.strict and self.items)
        return 1 if failing else 0


# --------------------------------------------------------------------------------------
# LuaLS
# --------------------------------------------------------------------------------------
# LuaLS findings that come from the Factorio type definitions, not from the code:
#  - LuaLS cannot match table literals against the recursive LocalisedString tuple alias
#    ({"item-name.x", ""} -> "Cannot assign `string` to `LocalisedString...|LuaGuiElement|LuaItemStack`")
#  - runtime and prototype concepts with the same name are merged, and the runtime one makes
#    fields required that are optional in prototypes (Resistance.decrease, PipeConnectionDefinition, ...)
LUALS_TYPE_NOISE = [
    ("assign-type-mismatch", r"^Cannot assign `string` to `(LocalisedString\.\.\.\|)?LuaGuiElement(\|LuaItemStack)?`"),
    ("missing-fields", r"^Missing required fields in type `LuaGuiElement`"),
    ("missing-fields", r"^Missing required fields in type `(Resistance|PipeConnectionDefinition|SmokeSource|AutoplaceControl)`"),
    # prototype types live in the "data" namespace, which LuaLS resolves inconsistently
    ("assign-type-mismatch", r"^Cannot assign `data\.(\w+)` to `\1\??`"),
    ("assign-type-mismatch", r"^Cannot assign `string` to `\(data\.\w+\)\?`"),
    ("param-type-mismatch", r"^Cannot assign `string` to parameter `data\.\w+`"),
    # ID aliases (ItemID, FluidID, TechnologyID, ...) exist in both APIs with the same name: the
    # prototype one is `string`, the runtime one also allows Lua objects, and LuaLS merges them
    ("param-type-mismatch", r"^Cannot assign `string(\|(Lua\w+|Fluid))+(\.\.\.\(\+\d+\))?` to parameter `string\??`"),
    ("assign-type-mismatch", r"^Cannot assign `string(\|(Lua\w+|Fluid))+(\.\.\.\(\+\d+\))?` to `string\??`"),
    ("return-type-mismatch", r"has a type of `string\??`, returning value of type `string(\|(Lua\w+|Fluid))+(\.\.\.\(\+\d+\))?`"),
    # LocalisedString: the runtime alias (numbers, booleans, Lua objects) merged with the prototype one
    ("assign-type-mismatch", r"to `(LocalisedString\.\.\.\|)?(string\|)?LuaGuiElement(\|LuaItemStack)?`\.?$"),
]


def is_type_noise(code: str, msg: str) -> bool:
    return any(code == c and re.search(rx, msg) for c, rx in LUALS_TYPE_NOISE)


def src_mod(path: Path, mods: dict[str, RepoMod]) -> str:
    """repo folder name of the mod that contains path"""
    for m in mods.values():
        if m.folder.resolve() in path.resolve().parents:
            return m.folder.name
    return ""


def run_luals(args, cfg: dict, cache: Path, fac: Factorio, mods: dict[str, RepoMod], selected: list[RepoMod],
              report: Report):
    luals = env_path("APM_LINT_LUALS")
    types = env_path("APM_LINT_TYPES")
    if (types / "factorio" / "plugin.lua").is_file():
        types = types / "factorio"
    ws = cache / "luals" / "workspace"
    if ws.exists():
        shutil.rmtree(ws)
    ws.mkdir(parents=True)

    # Copy the Lua sources under their info.json names so that the FMTK plugin can
    # resolve require("__apm_lib_ldinc__.x") -> apm_lib_ldinc/x.lua (repo folders are apm_lib, ...).
    origin: dict[str, Path] = {}
    for m in mods.values():
        for src in m.folder.rglob("*.lua"):
            rel = src.relative_to(m.folder)
            if rel.parts[0] in ("graphics", "sounds", ".git"):
                continue
            dst = ws / m.name / rel
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)
            origin[str(dst.resolve())] = src

    fmtk_cfg = json.loads((types / "config.json").read_text(encoding="utf-8"))
    settings = {k[4:] if k.startswith("Lua.") else k: v for k, v in fmtk_cfg.get("settings", {}).items()}
    vs = vscode_lua_settings()
    settings.update({
        "runtime.plugin": str(types / "plugin.lua"),
        "runtime.path": ["?.lua", "core/lualib/?.lua"],
        "workspace.library": [str(types / "library"), str(fac.data)],
        "workspace.checkThirdParty": False,
        "workspace.ignoreDir": [".git", "graphics", "sounds"],
        "diagnostics.globals": sorted(set(settings.get("diagnostics.globals", []))
                                      | set(vs.get("Lua.diagnostics.globals", []))
                                      | set(cfg.get("globals", []))),
        "diagnostics.disable": sorted(set(settings.get("diagnostics.disable", []))
                                      | set(vs.get("Lua.diagnostics.disable", []))
                                      | set(cfg.get("disable", []))),
    })
    (ws / ".luarc.json").write_text(json.dumps(settings, indent=1), encoding="utf-8")

    out = cache / "luals" / "check.json"
    if out.exists():
        out.unlink()
    level = {"error": "Error", "warning": "Warning", "info": "Information", "hint": "Hint"}[args.min_severity]
    cmd = [str(luals), f"--check={ws}", f"--checklevel={level}", "--check_format=json",
           f"--check_out_path={out}", f"--logpath={cache / 'luals' / 'log'}",
           f"--num_threads={args.jobs or min(4, os.cpu_count() or 1)}"]  # each check thread needs ~1 GB RAM
    log(f"lint: lua-language-server --check ({len(origin)} files) ...")
    try:
        ver = subprocess.run([str(luals), "--version"], capture_output=True, text=True, timeout=60).stdout.strip()
    except (OSError, subprocess.SubprocessError):
        ver = ""
    report.meta.update(luals_version=ver or "?", luals_files=len(origin),
                       types_version=f"{fmtk_cfg.get('factorioVersion', '?')} (FMTK {fmtk_cfg.get('bundleVersion', '?')})")
    t = time.time()
    r = subprocess.run(cmd, cwd=ws, capture_output=True, text=True, encoding="utf-8", errors="replace")
    if not out.is_file():
        if "no problems" in (r.stdout + r.stderr).lower() or "0 problems" in (r.stdout + r.stderr):
            diags = {}
        else:
            die("lua-language-server produced no result:\n" + (r.stdout + r.stderr)[-3000:])
    else:
        diags = json.loads(out.read_text(encoding="utf-8"))
    log(f"lint: lua-language-server done in {time.time() - t:.0f}s")

    selected_folders = {m.folder.resolve() for m in selected}
    noise = 0
    for uri, items in sorted(diags.items()):
        src = origin.get(str(Path(urllib.parse.unquote(urllib.parse.urlparse(uri).path)).resolve()))
        if src is None or not any(parent in selected_folders for parent in src.resolve().parents):
            continue
        rel = src.relative_to(REPO).as_posix()
        for d in sorted(items, key=lambda d: (d["range"]["start"]["line"], d["range"]["start"]["character"])):
            sev = LUALS_SEVERITY.get(d.get("severity", 2), "warning")
            line = d["range"]["start"]["line"] + 1
            col = d["range"]["start"]["character"] + 1
            msg = d["message"].split("\n")[0]
            code = d.get("code", "")
            if not args.show_type_noise and is_type_noise(code, msg):
                noise += 1
                continue
            report.add("luals", sev, f"luals|{rel}|{code}|{msg}",
                       f"{rel}:{line}:{col}: {sev}: [luals/{code}] {msg}",
                       file=rel, line=line, col=col, code=code, message=msg, mod=src_mod(src, mods))
    report.meta["luals_noise"] = noise
    if noise:
        log(f"lint: {noise} LuaLS findings hidden as known Factorio-types false positives (--show-type-noise shows them)")


# --------------------------------------------------------------------------------------
# Factorio data stage
# --------------------------------------------------------------------------------------
def find_external_mod(name: str, dirs: list[Path]) -> Path | None:
    best = None
    for d in dirs:
        if not d.is_dir():
            continue
        for p in d.iterdir():
            stem = p.stem if p.suffix == ".zip" else p.name
            if stem == name or re.fullmatch(re.escape(name) + r"_\d+\.\d+\.\d+", stem):
                if p.suffix == ".zip" or (p.is_dir() and (p / "info.json").is_file()):
                    if best is None or p.name > best.name:
                        best = p
    return best


def stage_mod_dir(cache: Path, fac: Factorio, profile: str, mods: list[RepoMod], all_repo: dict[str, RepoMod],
                  extra_dirs: list[Path]) -> Path:
    """Mod folder for one run: symlinks to the (read-only) repo mods + mod-list.json."""
    target = cache / "factorio" / f"mods-{profile}-{'vanilla' if not mods else 'apm'}"
    if target.exists():
        for child in target.iterdir():
            if child.is_symlink():
                child.unlink()  # never recurse into the linked mod sources
        shutil.rmtree(target)
    target.mkdir(parents=True)

    builtins = fac.builtin_mods()
    enabled = {"base"} | (set(builtins) if profile == "space-age" else set())
    staged: dict[str, RepoMod] = {}

    def need(name: str):
        if name in staged or name in builtins or name == "core":
            return
        if name in all_repo:
            m = all_repo[name]
            staged[name] = m
            for kind, dep in m.dependencies():
                if kind in ("required", "noorder"):
                    need(dep)
            return
        ext = find_external_mod(name, extra_dirs)
        if not ext:
            raise MissingMod(f"mod '{name}' is required but is neither in the repo nor in the mounted mods folder "
                             f"({', '.join(map(str, extra_dirs)) or 'none mounted'}): pass --mods-dir to ./lint.ps1")
        os.symlink(ext, target / ext.name)
        enabled.add(name)
        if ext.suffix == ".zip":
            import zipfile
            with zipfile.ZipFile(ext) as z:
                inf = next((n for n in z.namelist() if n.count("/") == 1 and n.endswith("/info.json")), None)
                info = json.loads(z.read(inf).decode("utf-8-sig")) if inf else None
        else:
            info = json.loads((ext / "info.json").read_text(encoding="utf-8-sig"))
        for dep in (info or {}).get("dependencies", []):
            dep = dep.strip()
            if dep[:1] in "?!(" or not dep:
                continue
            need(re.split(r"\s*[<>=]", dep.lstrip("~ "))[0].strip())

    for m in mods:
        need(m.name)
        if profile == "space-age":
            for kind, dep in m.dependencies():
                if kind in ("optional", "hidden") and dep in all_repo:
                    need(dep)  # optional repo mods take part in the space-age profile as well
    for name, m in staged.items():
        os.symlink(m.folder.resolve(), target / name, target_is_directory=True)
        enabled.add(name)

    mod_list = [{"name": n, "enabled": n in enabled} for n in ["base"] + [b for b in builtins if b != "base"]]
    mod_list += [{"name": n, "enabled": True} for n in sorted(enabled - set(builtins) - {"base"})]
    (target / "mod-list.json").write_text(json.dumps({"mods": mod_list}, indent=1), encoding="utf-8")
    return target


def run_factorio(fac: Factorio, args_list: list[str], timeout: int) -> tuple[bool, str]:
    try:
        r = subprocess.run([str(fac.exe)] + args_list, capture_output=True, text=True,
                           encoding="utf-8", errors="replace", timeout=timeout)
    except subprocess.TimeoutExpired:
        return False, f"Factorio did not finish in {timeout}s"
    return r.returncode == 0, (r.stdout or "") + (r.stderr or "")


def factorio_error(output: str) -> str:
    lines = output.splitlines()
    for i, line in enumerate(lines):
        if re.search(r"\bError\b|Failed to load mods|is already running|Couldn't acquire", line):
            return "\n".join(lines[i:i + 25])
    return "\n".join(lines[-25:])


def dump_data(fac: Factorio, mod_dir: Path, out: Path, timeout: int) -> tuple[bool, str]:
    produced = fac.write_data / "script-output" / "data-raw-dump.json"
    if produced.exists():
        produced.unlink()
    ok, output = run_factorio(fac, ["--mod-directory", str(mod_dir), "--dump-data"], timeout)
    if not produced.is_file():
        return False, factorio_error(output) if output else "no data-raw-dump.json produced"
    out.parent.mkdir(parents=True, exist_ok=True)
    shutil.move(str(produced), str(out))
    return True, ""


def run_data(args, cache: Path, fac: Factorio, mods: dict[str, RepoMod], selected: list[RepoMod], report: Report):
    checks = set(args.checks.split(",")) if args.checks else set(datacheck.ALL_CHECKS)
    unknown = checks - set(datacheck.ALL_CHECKS)
    if unknown:
        die(f"unknown data checks: {', '.join(sorted(unknown))} (known: {', '.join(datacheck.ALL_CHECKS)})")

    schema = datacheck.Schema(str(fac.docs / "prototype-api.json"))
    mod_dirs = {m.name: str(m.folder) for m in mods.values()}
    locale_dirs = [m.folder for m in mods.values()] + [fac.data / b for b in fac.builtin_mods()] + [fac.data / "core"]
    locale = datacheck.load_locale(map(str, locale_dirs))
    extra = [p for p in [env_path("APM_LINT_EXTRA_MODS")] if p.is_dir() and any(p.iterdir())]

    profiles = ["base", "space-age"] if args.profile == "all" else [args.profile]
    if "space-age" in profiles and "space-age" not in fac.builtin_mods():
        log("lint: no space-age in this Factorio, skipping that profile")
        profiles.remove("space-age")
    runs: list[tuple[str, Path, Path]] = []
    for profile in profiles:
        van_out = cache / "factorio" / f"dump-vanilla-{profile}-{fac.version}.json"
        if not van_out.is_file():
            log(f"lint: [{profile}] vanilla --dump-data (cached per Factorio version) ...")
            ok, err = dump_data(fac, stage_mod_dir(cache, fac, profile, [], mods, extra), van_out, args.timeout)
            if not ok:
                die(f"vanilla --dump-data failed for profile {profile}:\n{err}")
        try:
            mod_dir = stage_mod_dir(cache, fac, profile, selected, mods, extra)
        except MissingMod as e:
            report.add("factorio", "error", f"factorio|{profile}|deps|{e}",
                       f"factorio[{profile}]: error: [deps] {e}", profile=profile, stage="deps", detail=str(e))
            report.meta["factorio_runs"].append({"profile": profile, "stage": "deps", "ok": False})
            continue
        if not args.no_load_test:
            log(f"lint: [{profile}] load test (--create) ...")
            save = cache / "factorio" / f"load-test-{profile}.zip"
            if save.exists():
                save.unlink()
            ok, output = run_factorio(fac, ["--mod-directory", str(mod_dir), "--create", str(save)], args.timeout)
            loaded = ok and save.exists()
            report.meta["factorio_runs"].append({"profile": profile, "stage": "load", "ok": loaded})
            if not loaded:
                err = factorio_error(output)
                report.add("factorio", "error", f"factorio|{profile}|load|{err.splitlines()[0] if err else ''}",
                           f"factorio[{profile}]: error: [load] the game failed to load the mods:\n"
                           + "\n".join("    " + line for line in err.splitlines()),
                           profile=profile, stage="load", detail=err)
        log(f"lint: [{profile}] --dump-data ...")
        out = cache / "factorio" / f"dump-{profile}.json"
        ok, err = dump_data(fac, mod_dir, out, args.timeout)
        report.meta["factorio_runs"].append({"profile": profile, "stage": "dump", "ok": ok})
        if not ok:
            report.add("factorio", "error", f"factorio|{profile}|dump|{err.splitlines()[0] if err else ''}",
                       f"factorio[{profile}]: error: [dump] --dump-data failed:\n"
                       + "\n".join("    " + line for line in err.splitlines()),
                       profile=profile, stage="dump", detail=err)
            continue
        runs.append((profile, out, van_out))

    report.meta["profiles"] = [r[0] for r in runs]
    report.meta["checks"] = sorted(checks, key=datacheck.ALL_CHECKS.index)
    # run the checks, merge findings that show up in several profiles
    merged: dict[str, tuple[datacheck.Finding, list[str]]] = {}
    for profile, dump_path, van_path in runs:
        log(f"lint: [{profile}] checking data.raw ...")
        van = datacheck.load_dump(str(van_path))
        dump = datacheck.load_dump(str(dump_path))
        images = datacheck.ImageResolver(mod_dirs)
        vf = datacheck.DataCheck(schema, van, van, images, locale).run(checks)
        found = datacheck.vanilla_findings_filter(datacheck.DataCheck(schema, dump, van, images, locale).run(checks), vf)
        for f in found:
            merged.setdefault(f.key(), (f, []))[1].append(profile)

    # schema findings are grouped per (prototype type, key path, key) to stay readable
    groups: dict[tuple, list[tuple[datacheck.Finding, list[str]]]] = collections.OrderedDict()
    singles = []
    for f, profiles_hit in merged.values():
        if f.check == "schema":
            typ = f.where.split("/")[0]
            rel = datacheck._norm_path(f.where.split(".", 1)[1]) if "." in f.where else ""
            groups.setdefault((typ, rel, f.message), []).append((f, profiles_hit))
        else:
            singles.append((f, profiles_hit))

    def repo_file(f: datacheck.Finding) -> str | None:
        if not f.file:
            return None
        try:
            return Path(f.file).resolve().relative_to(REPO.resolve()).as_posix()
        except ValueError:
            return f.file

    for f, profiles_hit in sorted(singles, key=lambda x: (SEVERITIES.index(x[0].severity), x[0].check, x[0].where)):
        file = repo_file(f)
        report.add("data", f.severity, "data|" + f.key(),
                   f"{file + ':1:1' if file else 'data.raw'}: {f.severity}: [data/{f.check}] {f.where}: {f.message} "
                   f"({','.join(profiles_hit)})",
                   check=f.check, where=f.where, message=f.message, profiles=profiles_hit, file=file)
    for (typ, rel, msg), items in groups.items():
        names = sorted({f.where.split("/", 1)[1].split(".", 1)[0] for f, _ in items})
        profiles_hit = sorted({p for _, ps in items for p in ps})
        shown = ", ".join(names[:4]) + (f" (+{len(names) - 4} more)" if len(names) > 4 else "")
        path = f"{typ}{'.' + rel if rel else ''}"
        report.add("data", items[0][0].severity, f"data|schema|{typ}|{rel}|{msg}",
                   f"data.raw: {items[0][0].severity}: [data/schema] {path}: {msg} - {len(names)} prototype(s): "
                   f"{shown} ({','.join(profiles_hit)})",
                   check="schema", proto_type=typ, key_path=rel, message=msg, prototypes=names, profiles=profiles_hit)


# --------------------------------------------------------------------------------------
def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0], formatter_class=argparse.RawDescriptionHelpFormatter,
                                 epilog="See tools/lint/README.md")
    ap.add_argument("targets", nargs="*", metavar="[all|luals|data] [mod ...]",
                    help="what to run (default all), then mod folders or names (default: all linted mods)")
    ap.add_argument("--min-severity", choices=SEVERITIES, default="warning")
    ap.add_argument("--strict", action="store_true", help="exit 1 on warnings too")
    g = ap.add_argument_group("luals")
    g.add_argument("--jobs", type=int, help="LuaLS check threads (default min(4, CPUs), ~1 GB RAM each)")
    g.add_argument("--show-type-noise", action="store_true",
                   help="also show LuaLS findings that are known false positives of the Factorio types")
    g = ap.add_argument_group("data")
    g.add_argument("--profile", choices=["all", "base", "space-age"], default="all")
    g.add_argument("--checks", help=f"comma list of {','.join(datacheck.ALL_CHECKS)} (default all)")
    g.add_argument("--no-load-test", action="store_true", help="skip the `--create` load test")
    g.add_argument("--timeout", type=int, default=600, help="seconds per Factorio run")
    args = ap.parse_intermixed_args()
    args.part = "all"
    if args.targets and args.targets[0] in ("all", "luals", "data"):
        args.part = args.targets.pop(0)

    started = time.time()
    cache = env_path("APM_LINT_CACHE")
    fac = Factorio(env_path("APM_LINT_FACTORIO"))
    cfg = lint_config()
    mods = repo_mods(cfg.get("mods") or LINT_MODS)
    selected = select_mods(mods, args.targets)
    report = Report(args)
    report.meta.update(part=args.part, mods=mods, selected=selected, factorio=fac.version, started=started)
    log(f"lint: Factorio {fac.version}, mods: {', '.join(m.folder.name for m in selected)}")
    if args.part in ("all", "luals"):
        run_luals(args, cfg, cache, fac, mods, selected, report)
    if args.part in ("all", "data"):
        run_data(args, cache, fac, mods, selected, report)
    code = report.finish()
    out = env_path("APM_LINT_REPORT")
    report.meta["duration"] = time.time() - started
    report_md.write(report, out, REPO, os.environ.get("APM_LINT_REPORT_LINK_PREFIX"))
    log(f"lint: report written to {out}")
    return code


if __name__ == "__main__":
    sys.exit(main())
