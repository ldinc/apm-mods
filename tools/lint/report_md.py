"""Detailed Markdown report for lint.py (--report-md)."""

from __future__ import annotations

import collections
import datetime
import os
import re
import urllib.parse
from pathlib import Path

SEVERITIES = ["error", "warning", "info", "hint"]
ICON = {"error": "🔴", "warning": "🟡", "info": "🔵", "hint": "⚪"}

# check -> (title, what it means, how to fix)
DATA_CHECKS = {
    "deps": ("Missing dependency",
             "A mod that a linted mod requires is neither in the repo nor in the mods folder given to the lint.",
             "Pass your Factorio mods folder with `./lint.ps1 --mods-dir <folder>` (it is mounted read-only as `/mods`)."),
    "load": ("Load test failed",
             "Factorio could not start a new game with the mods (`--create`). This is exactly what a player would see.",
             "Read the error below; it names the prototype and usually the file."),
    "dump": ("`--dump-data` failed",
             "Factorio could not load the mods to dump `data.raw`, so the data checks could not run for this profile.",
             "Fix the load error first."),
    "fuel": ("Fuel definitions",
             "Items with a `fuel_value` must declare `fuel_categories` since Factorio 2.1.20 "
             "(`fuel_category` was removed).",
             "Use `fuel_categories = { \"chemical\" }` instead of `fuel_category = \"chemical\"`."),
    "refs": ("Broken references",
             "The prototype refers to something that does not exist (recipe, item, technology, category, entity, ...). "
             "Factorio either fails to load or silently ignores it, depending on the field.",
             "Fix the name, or only add the reference when the target exists (e.g. behind `if mods[...]`)."),
    "unlock": ("Unreachable recipes",
               "The recipe is disabled (`enabled = false`) and no technology unlocks it, so players can never use it.",
               "Add it to a technology's `effects`, enable it, or hide/remove it."),
    "prod-loop": ("Productivity loops",
                  "The recipe allows productivity and returns one of its ingredients, which lets productivity "
                  "create that ingredient from nothing.",
                  "Set `ignored_by_productivity` on the returned result, or `allow_productivity = false`."),
    "sprites": ("Sprites",
                "A sprite/animation rectangle reaches outside its PNG, or the file does not exist. Factorio refuses "
                "to load these (\"sprite rectangle is outside the actual sprite size\").",
                "Check `width`, `height`, `x`, `y`, `line_length`, `frame_count`, `direction_count` against the image."),
    "locale": ("Missing names",
               "The prototype has neither a `localised_name` nor a locale key, so the game shows "
               "\"Unknown key: ...\".",
               "Add the key to `locale/en/*.cfg`, or set `localised_name`."),
    "schema": ("Ignored keys",
               "Keys that are not part of the prototype in the Factorio API. Factorio ignores them silently: usually a "
               "typo or a Factorio 1.1 leftover whose feature is now configured differently.",
               "Rename to the 2.x key (see the linked API docs) or remove it."),
}

LUALS_CODES = {
    "different-requires": "The same file is required under two names (`require(\"lib.x\")` in one place, "
                          "`require(\"__apm_lib_ldinc__.lib.x\")` in another). Use one spelling everywhere.",
    "need-check-nil": "A value that can be `nil` is indexed or called without a check. Add a guard, or an "
                      "`---@cast x -nil` / `assert` when it cannot be nil.",
    "undefined-field": "The field is not part of the (annotated or inferred) type: typo, removed API field, "
                       "or a missing annotation.",
    "undefined-global": "Reads a global that is never defined. In Factorio this is `nil` at runtime.",
    "param-type-mismatch": "The argument type does not match the function's `---@param` annotation. "
                           "Either the call or the annotation is wrong.",
    "assign-type-mismatch": "The assigned value does not match the declared type of the variable/field.",
    "missing-fields": "A table literal typed as a class lacks required fields of that class.",
    "return-type-mismatch": "The returned value does not match the function's `---@return` annotation.",
    "inject-field": "A field is added to a table whose class does not declare it.",
    "redundant-parameter": "More arguments than the function takes.",
    "missing-parameter": "Fewer arguments than the function requires.",
    "unused-local": "A local variable is never used.",
    "undefined-doc-name": "An annotation refers to a type that does not exist.",
    "cast-local-type": "A local is re-assigned a value of another type than it was declared with.",
    "duplicate-set-field": "The same field/function is defined twice; the second definition wins.",
}

API_TYPES_URL = "https://lua-api.factorio.com/latest/prototypes/"


# --------------------------------------------------------------------------------------
def cell(text) -> str:
    return str(text).replace("\\", "\\\\").replace("|", "\\|").replace("\n", " ").replace("\r", "")


def code(text: str) -> str:
    text = str(text).replace("\n", " ")
    ticks = max((len(m) for m in re.findall(r"`+", text)), default=0) + 1
    pad = " " if text.startswith("`") or text.endswith("`") else ""
    return f"{'`' * ticks}{pad}{text}{pad}{'`' * ticks}"


def code_cell(text: str) -> str:
    return cell(code(text)) if text else ""


def plural(n: int, word: str) -> str:
    return f"{n} {word}{'' if n == 1 else 's'}"


def duration(seconds: float) -> str:
    seconds = int(round(seconds))
    return f"{seconds // 60} min {seconds % 60} s" if seconds >= 60 else f"{seconds} s"


class SourceIndex:
    """Where string literals appear in the linted mods (to point data findings at code)."""

    def __init__(self, repo: Path, mods):
        self.repo = repo
        self.lines: dict[str, list[str]] = {}
        self.literals: dict[str, list[tuple[str, int]]] = collections.defaultdict(list)
        self.mod_of: dict[str, str] = {}
        for m in mods.values():
            for f in sorted(m.folder.rglob("*.lua")):
                rel = f.relative_to(repo).as_posix()
                self.mod_of[rel] = m.folder.name
                try:
                    text = f.read_text(encoding="utf-8", errors="replace")
                except OSError:
                    continue
                lines = text.splitlines()
                self.lines[rel] = lines
                for no, line in enumerate(lines, 1):
                    for lit in re.findall(r"[\"']([A-Za-z0-9_\-.]{3,})[\"']", line):
                        self.literals[lit].append((rel, no))

    def line(self, rel: str, no: int) -> str:
        lines = self.lines.get(rel)
        if lines is None:
            p = self.repo / rel
            try:
                lines = p.read_text(encoding="utf-8", errors="replace").splitlines() if p.is_file() else []
            except OSError:
                lines = []
            self.lines[rel] = lines
        return lines[no - 1].strip() if 0 < no <= len(lines) else ""

    def find(self, name: str) -> list[tuple[str, int]]:
        """Locations of the prototype name; generated names fall back to their longest literal prefix."""
        candidates = [name]
        stripped = re.sub(r"^(empty-|fill-)|(-barrel|-recycling)$", "", name)
        if stripped != name:
            candidates.append(stripped)
        for cand in list(candidates):
            parts = re.split(r"(?<=[_-])", cand)
            for i in range(len(parts) - 1, 1, -1):
                candidates.append("".join(parts[:i]).rstrip("_-"))
        for cand in candidates:
            hits = self.literals.get(cand)
            if hits:
                return sorted(hits, key=lambda h: -self.score(h))
        return []

    def score(self, hit: tuple[str, int]) -> int:
        """2: prototype definition (`name = "x"` with a `type = ...` just above), 1: `name = "x"`, 0: mention"""
        rel, no = hit
        if not re.search(r"\bname\s*=", self.line(rel, no)):
            return 0
        around = [self.line(rel, n) for n in range(max(1, no - 6), no + 1)]
        return 2 if any(re.search(r"\btype\s*=\s*[\"']", t) for t in around) else 1


# --------------------------------------------------------------------------------------
def write(report, out: Path, repo: Path, link_prefix: str | None = None) -> None:
    meta = report.meta
    items = report.visible()
    mods = meta["mods"]
    out.parent.mkdir(parents=True, exist_ok=True)
    if link_prefix is None:
        try:
            link_prefix = Path(os.path.relpath(repo, out.parent)).as_posix() + "/"
        except ValueError:  # other drive on Windows
            link_prefix = repo.resolve().as_uri() + "/"
    idx = SourceIndex(repo, mods)

    def link(rel: str, line: int | None = None, label: str | None = None) -> str:
        target = urllib.parse.quote(link_prefix + rel, safe="/:%#.-_~") + (f"#L{line}" if line else "")
        text = label or (f"{rel}:{line}" if line else rel)
        return f"[{cell(text)}]({target})"

    def hints_for(name: str, limit: int = 2) -> tuple[str, set[str]]:
        hits = idx.find(name)
        best = max((idx.score(h) for h in hits), default=0)
        defs = [h for h in hits if best and idx.score(h) == best]
        mods_hit = {idx.mod_of.get(r, "") for r, _ in (defs or hits)} - {""}
        shown = ", ".join(link(r, n) for r, n in hits[:limit])
        if len(hits) > limit:
            shown += f" (+{len(hits) - limit})"
        return shown, mods_hit

    # attribute findings to a mod folder
    for i in items:
        if i["source"] == "luals":
            i["_mod"] = i.get("mod") or "?"
        elif i["source"] == "data":
            if i.get("file"):
                i["_mod"] = i["file"].split("/")[0]
                i["_hint"] = link(i["file"])
            else:
                names = i.get("prototypes") or [i["where"].split("/", 1)[-1].split(".", 1)[0]]
                hint, hit_mods = hints_for(names[0])
                i["_hint"] = hint
                i["_mod"] = next(iter(hit_mods)) if len(hit_mods) == 1 else ""
        else:
            i["_mod"] = ""

    counts = collections.Counter(i["severity"] for i in items)
    L: list[str] = []
    w = L.append

    # ---- header -------------------------------------------------------------------------
    now = datetime.datetime.now().astimezone()
    offset = os.environ.get("APM_LINT_UTC_OFFSET_MINUTES")  # set by lint.ps1: containers run in UTC
    if offset:
        try:
            now = now.astimezone(datetime.timezone(datetime.timedelta(minutes=float(offset))))
        except ValueError:
            pass
    result = " · ".join(f"{ICON[s]} **{plural(counts[s], s)}**" for s in SEVERITIES if counts[s]) or "✅ **no problems**"
    w("# APM mods: lint report")
    w("")
    w(f"> {result}")
    w("")
    w("| | |")
    w("|---|---|")
    tz = now.strftime("%z")
    tz = f"UTC{tz[:3]}:{tz[3:]}" if tz else "UTC"
    w(f"| Generated | {now:%Y-%m-%d %H:%M} ({tz}) in {duration(meta.get('duration', 0))} |")
    parts = {"all": "LuaLS + Factorio data", "luals": "LuaLS", "data": "Factorio data"}[meta["part"]]
    w(f"| Checks | {parts} |")
    sel = meta["selected"]
    w("| Mods | " + ", ".join(f"`{m.folder.name}` {m.version}" for m in sel) + " |")
    if meta.get("factorio"):
        w(f"| Factorio | {meta['factorio']} |")
    if meta.get("profiles"):
        w(f"| Profiles | {', '.join(meta['profiles'])} |")
    if meta.get("luals_version"):
        w(f"| lua-language-server | {cell(meta['luals_version'])}, {meta.get('luals_files', '?')} files, "
          f"types {cell(meta.get('types_version', '?'))} |")
    if meta.get("luals_noise"):
        w(f"| Type noise | {plural(meta['luals_noise'], 'LuaLS finding')} hidden as known Factorio-types false "
          "positives (`--show-type-noise`) |")
    w("")

    # ---- summary ------------------------------------------------------------------------
    w("## Summary")
    w("")
    w("| Mod | Version | 🔴 Errors | 🟡 Warnings | LuaLS | Factorio data |")
    w("|---|---|--:|--:|--:|--:|")
    rows = [(m.folder.name, m.version) for m in sel] + [("", "")]
    for folder, version in rows:
        mine = [i for i in items if i["_mod"] == folder]
        if not folder and not mine:
            continue
        c = collections.Counter(i["severity"] for i in mine)
        label = f"`{folder}`" if folder else "*(not attributed to a mod)*"
        w(f"| {label} | {version} | {c['error'] or ''} | {c['warning'] or ''} | "
          f"{sum(1 for i in mine if i['source'] == 'luals') or ''} | "
          f"{sum(1 for i in mine if i['source'] != 'luals') or ''} |")
    w("")
    by_check = collections.Counter()
    for i in items:
        key = f"luals/{i['code']}" if i["source"] == "luals" else f"data/{i.get('check') or i.get('stage')}"
        by_check[key] += 1
    if by_check:
        w("| Check | Findings |")
        w("|---|--:|")
        for key, n in sorted(by_check.items(), key=lambda kv: (-kv[1], kv[0])):
            anchor = key.replace("/", "-")
            w(f"| [`{key}`](#{anchor}) | {n} |")
        w("")
    toc = []
    if meta["part"] in ("all", "data"):
        toc.append("[Factorio load test](#factorio-load-test) · [Data checks](#factorio-data-checks)")
    if meta["part"] in ("all", "luals"):
        toc.append("[LuaLS](#luals)")
    w("Sections: " + " · ".join(toc))
    w("")

    # ---- Factorio -----------------------------------------------------------------------
    if meta["part"] in ("all", "data"):
        w("## Factorio load test")
        w("")
        runs = meta["factorio_runs"]
        if runs:
            status = collections.defaultdict(dict)
            for r in runs:
                status[r["profile"]][r["stage"]] = r["ok"]
            w("| Profile | Dependencies | Load (`--create`) | `--dump-data` |")
            w("|---|---|---|---|")

            def st(v):
                return "—" if v is None else ("✅ ok" if v else "❌ failed")
            for profile, s in status.items():
                w(f"| {profile} | {'❌ missing' if s.get('deps') is False else '✅ ok'} | {st(s.get('load'))} | "
                  f"{st(s.get('dump'))} |")
            w("")
        fails = [i for i in items if i["source"] == "factorio"]
        for i in fails:
            title, what, fix = DATA_CHECKS[i["stage"]]
            w(f'<a id="data-{i["stage"]}"></a>')
            w(f"### ❌ {title}: {i['profile']}")
            w("")
            w(f"{what} {fix}")
            w("")
            w("```text")
            w(i.get("detail", "").rstrip())
            w("```")
            w("")

        w("## Factorio data checks")
        w("")
        w("Each profile is compared with a vanilla run of the same profile, so only what the mods add is listed. "
          "*Likely source* points at code that defines or mentions the prototype (a hint, not proof).")
        w("")
        data_items = [i for i in items if i["source"] == "data"]
        if not data_items:
            w("✅ No findings." if meta.get("profiles") else "Not run.")
            w("")
        for check in ["fuel", "refs", "sprites", "locale", "unlock", "prod-loop", "schema"]:
            found = [i for i in data_items if i.get("check") == check]
            if not found:
                continue
            title, what, fix = DATA_CHECKS[check]
            w(f'<a id="data-{check}"></a>')
            w(f"### `{check}`: {title} ({len(found)})")
            w("")
            w(f"{what}")
            w("")
            w(f"**Fix:** {fix}")
            w("")
            if check == "schema":
                w("| Prototype type | Key path | Ignored key | Prototypes | Profiles | Likely source |")
                w("|---|---|---|---|---|---|")
                for i in sorted(found, key=lambda i: (i["proto_type"], i["key_path"], i["message"])):
                    key = re.search(r"unknown key '([^']+)'", i["message"])
                    names = i["prototypes"]
                    shown = ", ".join(f"`{n}`" for n in names[:6]) + (f" +{len(names) - 6} more" if len(names) > 6 else "")
                    typ = i["proto_type"]
                    w(f"| [`{typ}`]({API_TYPES_URL}) | {code_cell(i['key_path']) or '(top level)'} | "
                      f"{code_cell(key.group(1) if key else i['message'])} | {cell(shown)} ({len(names)}) | "
                      f"{', '.join(i['profiles'])} | {i.get('_hint', '')} |")
            else:
                w("| | Prototype | Problem | Profiles | Likely source |")
                w("|---|---|---|---|---|")
                for i in sorted(found, key=lambda i: (SEVERITIES.index(i["severity"]), i["where"])):
                    w(f"| {ICON[i['severity']]} | {code_cell(i['where'])} | {cell(i['message'])} | "
                      f"{', '.join(i['profiles'])} | {i.get('_hint', '')} |")
            w("")

    # ---- LuaLS --------------------------------------------------------------------------
    if meta["part"] in ("all", "luals"):
        w("## LuaLS")
        w("")
        lua = [i for i in items if i["source"] == "luals"]
        if not lua:
            w("✅ No findings.")
            w("")
        else:
            w("### Diagnostics by code")
            w("")
            w("| Code | Findings | Meaning / fix |")
            w("|---|--:|---|")
            for c, n in collections.Counter(i["code"] for i in lua).most_common():
                w(f'| <a id="luals-{c}"></a>`{c}` | {n} | {cell(LUALS_CODES.get(c, ""))} |')
            w("")
            for m in sel:
                mine = [i for i in lua if i["_mod"] == m.folder.name]
                if not mine:
                    continue
                w(f"### `{m.folder.name}` ({plural(len(mine), 'finding')})")
                w("")
                by_file = collections.OrderedDict()
                for i in sorted(mine, key=lambda i: (i["file"], i["line"], i["col"])):
                    by_file.setdefault(i["file"], []).append(i)
                w("| File | Findings | Codes |")
                w("|---|--:|---|")
                for f, lst in sorted(by_file.items(), key=lambda kv: (-len(kv[1]), kv[0])):
                    codes = ", ".join(f"{c} ×{n}" for c, n in collections.Counter(i["code"] for i in lst).most_common())
                    w(f"| {link(f)} | {len(lst)} | {cell(codes)} |")
                w("")
                for f, lst in by_file.items():
                    w(f"#### {cell(f)}")
                    w("")
                    w("| Line | | Code | Message | Source |")
                    w("|--:|---|---|---|---|")
                    for i in lst:
                        src = idx.line(f, i["line"])
                        if len(src) > 110:
                            src = src[:107] + "..."
                        w(f"| {link(f, i['line'], str(i['line']))} | {ICON[i['severity']]} | `{i['code']}` | "
                          f"{cell(i['message'])} | {code_cell(src)} |")
                    w("")

    w("---")
    w("")
    w("Generated by `./lint.ps1` (see `tools/lint/README.md`).")
    out.write_text("\n".join(L) + "\n", encoding="utf-8")
