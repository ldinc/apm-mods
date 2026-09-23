"""Checks on a Factorio ``data.raw`` dump (``factorio --dump-data``).

Every check compares the mod-set dump with a vanilla dump of the same game
profile and only reports what the mods introduced, so problems that vanilla
itself has (or false positives of these checks) stay out of the report.

Checks
  schema      keys that Factorio does not read (typos, keys removed in 2.x),
              validated against doc-html/prototype-api.json
  fuel        ItemPrototype: fuel_value without fuel_categories (load error since 2.1.20)
  refs        references to prototypes that do not exist (recipes, technologies,
              items, entities, categories, upgrades, tiles)
  unlock      recipes the mod set adds that are disabled and unlocked by nothing
  prod-loop   productivity-enabled recipes that return more of a consumed item
              than they take (ignored_by_productivity lower than the amount)
  sprites     sprite/animation/icon rectangles outside the real image
              (the game refuses to load) - checked for files of the repo mods only
  locale      prototypes the mod set adds without a name in the mods' locale

Each finding is a ``Finding``; the caller decides how to print it.
"""

from __future__ import annotations

import dataclasses
import json
import math
import os
import re
import struct
from typing import Callable, Iterable

ERROR = "error"
WARNING = "warning"
INFO = "info"


@dataclasses.dataclass(frozen=True)
class Finding:
    severity: str
    check: str
    where: str  # prototype path, e.g. "item/apm_coke.icons[1]"
    message: str
    file: str | None = None  # repo file when the finding is about a file

    def key(self) -> str:
        """Stable identity used for baselines (no line numbers)."""
        return f"{self.check}|{_norm_path(self.where)}|{self.message}"


def _norm_path(path: str) -> str:
    return re.sub(r"\[[^\]]*\]", "[]", path)


def _loose_path(rel: str) -> str:
    """rel path without 4-way direction levels: mods often turn a vanilla Animation into an Animation4Way."""
    return re.sub(r"(^|\.)(north|east|south|west)(?=\.|$)", "", rel).lstrip(".")


# --------------------------------------------------------------------------------------
# Prototype API schema
# --------------------------------------------------------------------------------------
class Schema:
    def __init__(self, prototype_api_json: str):
        with open(prototype_api_json, encoding="utf-8") as fh:
            api = json.load(fh)
        self.version = api.get("application_version")
        self.protos = {p["name"]: p for p in api["prototypes"]}
        self.types = {t["name"]: t for t in api["types"]}
        self.by_typename = {p["typename"]: p for p in api["prototypes"] if p.get("typename")}
        self._props_cache: dict[tuple[str, str], dict] = {}

    def _ancestors(self, entry: dict, table: dict) -> Iterable[dict]:
        while entry:
            yield entry
            parent = entry.get("parent")
            entry = table.get(parent) if parent else None

    def props(self, name: str, table_name: str) -> dict:
        key = (table_name, name)
        if key not in self._props_cache:
            table = self.protos if table_name == "protos" else self.types
            out: dict = {}
            for e in self._ancestors(table[name], table):
                for q in e.get("properties") or []:
                    out.setdefault(q["name"], q)
                    if q.get("alt_name"):
                        out.setdefault(q["alt_name"], q)
            self._props_cache[key] = out
        return self._props_cache[key]

    def is_a(self, proto_name: str, base: str) -> bool:
        return any(e["name"] == base for e in self._ancestors(self.protos[proto_name], self.protos))

    def typenames_of(self, base: str) -> set[str]:
        return {p["typename"] for p in self.protos.values() if p.get("typename") and self.is_a(p["name"], base)}


_SCALARS = {"string", "double", "float", "bool", "boolean", "uint8", "uint16", "uint32", "uint64",
            "int8", "int16", "int32", "int64"}


class _Walker:
    """Walks a prototype along its declared type and reports unknown keys.

    ``on_struct(type_name, value, path)`` is called for every named struct type
    that gets resolved, which is how the sprite check learns what a table is.
    """

    def __init__(self, schema: Schema, on_struct: Callable[[str, dict, str], None] | None = None):
        self.s = schema
        self.on_struct = on_struct
        self.unknown: list[tuple[str, str]] = []

    def check_struct(self, val, props: dict, path: str, custom: bool) -> None:
        if not isinstance(val, dict):
            return
        for k, v in val.items():
            if k not in props:
                if not custom:
                    self.unknown.append((path, k))
                continue
            self.check(v, props[k]["type"], f"{path}.{k}")

    def _union_candidates(self, val, options):
        cands = []
        for o in options:
            if isinstance(o, dict) and o.get("complex_type") == "type":
                m = re.search(r'`type` is `"([^"]+)"`', o.get("description", ""))
                if m and isinstance(val, dict) and val.get("type") == m.group(1):
                    return [o["value"]]
                cands.append(o["value"])
            else:
                cands.append(o)
        return [c for c in cands if not (isinstance(c, str) and c in _SCALARS)]

    def _count_unknown(self, val, t) -> int:
        saved, saved_cb = self.unknown, self.on_struct
        self.unknown, self.on_struct = [], None
        self.check(val, t, "")
        n = sum(1 for path, _ in self.unknown if path == "")  # only how well the top level fits
        self.unknown, self.on_struct = saved, saved_cb
        return n

    def check(self, val, t, path: str) -> None:
        if isinstance(t, str):
            entry = self.s.types.get(t)
            if not entry:
                return
            tt = entry["type"]
            if tt == "builtin":
                return
            if isinstance(tt, dict) and tt.get("complex_type") == "struct":
                if self.on_struct and isinstance(val, dict):
                    self.on_struct(t, val, path)
                self.check_struct(val, self.s.props(t, "types"), path, bool(entry.get("custom_properties")))
            elif isinstance(tt, dict) and tt.get("complex_type") == "union":
                # an inline struct option of a named union uses the named type's own properties
                opts = [{"complex_type": "owner", "owner": t} if isinstance(o, dict) and o.get("complex_type") == "struct"
                        and not o.get("properties") else o for o in tt["options"]]
                self.check(val, {"complex_type": "union", "options": opts}, path)
            else:
                self.check(val, tt, path)
            return
        if not isinstance(t, dict):
            return
        ct = t.get("complex_type")
        if ct == "owner":
            owner = t["owner"]
            if self.on_struct and isinstance(val, dict):
                self.on_struct(owner, val, path)
            self.check_struct(val, self.s.props(owner, "types"), path,
                              bool(self.s.types[owner].get("custom_properties")))
            return
        if ct == "type":
            self.check(val, t["value"], path)
        elif ct == "array":
            if isinstance(val, list):
                for i, x in enumerate(val):
                    self.check(x, t["value"], f"{path}[{i + 1}]")
            elif isinstance(val, dict):
                for k, x in val.items():
                    self.check(x, t["value"], f"{path}[{k}]")
        elif ct == "dictionary":
            if isinstance(val, dict):
                for k, x in val.items():
                    self.check(x, t["value"], f"{path}[{k}]")
        elif ct == "union":
            if not isinstance(val, (dict, list)):
                return
            cands = self._union_candidates(val, t["options"])
            if len(cands) == 1:
                self.check(val, cands[0], path)
                return
            best = None
            for c in cands:
                n = self._count_unknown(val, c)
                if n == 0:
                    self.check(val, c, path)
                    return
                if best is None or n < best[0]:
                    best = (n, c)
            if best:
                self.check(val, best[1], path)
        elif ct == "struct":
            props = {q["name"]: q for q in t.get("properties", [])}
            if props:
                self.check_struct(val, props, path, False)


# --------------------------------------------------------------------------------------
# Image sizes (sprite check)
# --------------------------------------------------------------------------------------
class ImageResolver:
    """Maps ``__mod__/path`` to a file of a repo mod (other mods are not checked)."""

    def __init__(self, mod_dirs: dict[str, str]):
        self.mod_dirs = mod_dirs
        self._sizes: dict[str, tuple[int, int] | None] = {}

    def path(self, filename: str) -> str | None:
        m = re.match(r"^__([^/]+)__/(.*)$", filename)
        if not m or m.group(1) not in self.mod_dirs:
            return None
        return os.path.join(self.mod_dirs[m.group(1)], m.group(2))

    def size(self, filename: str):
        """None = not a repo file, False = missing, (w, h) otherwise."""
        if filename in self._sizes:
            return self._sizes[filename]
        p = self.path(filename)
        result = None
        if p is not None:
            if not os.path.isfile(p):
                result = False
            elif p.lower().endswith(".png"):
                with open(p, "rb") as fh:
                    head = fh.read(24)
                result = struct.unpack(">II", head[16:24]) if head[:8] == b"\x89PNG\r\n\x1a\n" else None
            else:
                result = None  # jpg/ogg etc: existence only
                self._sizes[filename] = "exists"  # type: ignore[assignment]
                return "exists"
        self._sizes[filename] = result
        return result


def _num(v, default=0):
    return v if isinstance(v, (int, float)) and not isinstance(v, bool) else default


# --------------------------------------------------------------------------------------
# Locale
# --------------------------------------------------------------------------------------
def load_locale(dirs: Iterable[str], lang: str = "en") -> set[str]:
    keys: set[str] = set()
    for d in dirs:
        ldir = os.path.join(d, "locale", lang)
        if not os.path.isdir(ldir):
            continue
        for fn in sorted(os.listdir(ldir)):
            if not fn.endswith(".cfg"):
                continue
            section = ""
            with open(os.path.join(ldir, fn), encoding="utf-8-sig", errors="replace") as fh:
                for line in fh:
                    line = line.rstrip("\r\n")
                    if not line or line[0] in ";#":
                        continue
                    m = re.match(r"^\[(.*)\]\s*$", line)
                    if m:
                        section = m.group(1)
                    elif "=" in line:
                        keys.add(f"{section}.{line.split('=', 1)[0].strip()}")
    return keys


# --------------------------------------------------------------------------------------
# The checks
# --------------------------------------------------------------------------------------
class DataCheck:
    def __init__(self, schema: Schema, dump: dict, vanilla: dict, images: ImageResolver,
                 locale_keys: set[str], repo_files: Callable[[str], str | None] | None = None):
        self.s = schema
        self.raw = dump
        self.van = vanilla
        self.images = images
        self.locale = locale_keys
        self.findings: list[Finding] = []
        self.item_types = schema.typenames_of("ItemPrototype")
        self.entity_types = schema.typenames_of("EntityPrototype")
        self.equipment_types = schema.typenames_of("EquipmentPrototype")
        self.items = self._index(self.raw, self.item_types)
        self.entities = self._index(self.raw, self.entity_types)
        self.fluids = self.raw.get("fluid", {})
        self.repo_file = repo_files or (lambda f: None)

    @staticmethod
    def _index(raw: dict, types: set[str]) -> dict:
        out = {}
        for t in types:
            for n, p in (raw.get(t) or {}).items():
                out[n] = p
        return out

    def add(self, sev, check, where, msg, file=None):
        self.findings.append(Finding(sev, check, where, msg, file))

    def is_new(self, typ: str, name: str) -> bool:
        return name not in (self.van.get(typ) or {})

    # -- schema + sprites ---------------------------------------------------------------
    def run_schema_and_sprites(self):
        van_unknown = set()
        walker = _Walker(self.s)
        for typ, lst in self.van.items():
            p = self.s.by_typename.get(typ)
            if not p or not isinstance(lst, dict):
                continue
            props = self.s.props(p["name"], "protos")
            for name, proto in lst.items():
                walker.check_struct(proto, props, f"{typ}/{name}", bool(p.get("custom_properties")))
        for path, k in walker.unknown:
            rel = _norm_path(path.split(".", 1)[1]) if "." in path else ""
            van_unknown.add((path.split("/")[0], rel, k))
            van_unknown.add((path.split("/")[0], "~" + _loose_path(rel), k))

        walker = _Walker(self.s, on_struct=self._sprite_hook)
        for typ, lst in self.raw.items():
            p = self.s.by_typename.get(typ)
            if not p or not isinstance(lst, dict):
                continue
            props = self.s.props(p["name"], "protos")
            for name, proto in lst.items():
                if not isinstance(proto, dict):
                    continue
                if isinstance(proto.get("icon"), str):
                    self._check_icon(proto, f"{typ}/{name}")
                walker.check_struct(proto, props, f"{typ}/{name}", bool(p.get("custom_properties")))
        for path, k in walker.unknown:
            rel = _norm_path(path.split(".", 1)[1]) if "." in path else ""
            if (path.split("/")[0], rel, k) in van_unknown or (path.split("/")[0], "~" + _loose_path(rel), k) in van_unknown:
                continue
            self.add(WARNING, "schema", path, f"unknown key '{k}' (Factorio ignores it: typo or removed in 2.x?)")

    def _sprite_hook(self, type_name: str, val: dict, path: str):
        if "icon" in val and isinstance(val.get("icon"), str) and ("icon_size" in val or type_name == "IconData"):
            self._check_icon(val, path)
        fn = val.get("filename")
        if not isinstance(fn, str):
            return
        size = self.images.size(fn)
        if size is None:
            return
        if size is False:
            self.add(ERROR, "sprites", path, f"file not found: {fn}", self.images.path(fn))
            return
        if size == "exists":
            return
        W, H = size
        w = val.get("width", val.get("size"))
        h = val.get("height", val.get("size"))
        if isinstance(w, list):
            w, h = w[0], w[1]
        if not isinstance(w, (int, float)) or not isinstance(h, (int, float)):
            return
        x, y = _num(val.get("x")), _num(val.get("y"))
        if isinstance(val.get("position"), list):
            x, y = val["position"][0], val["position"][1]
        animated = "Animation" in type_name
        if animated:
            frames = int(_num(val.get("frame_count"), 1)) or 1
            frames *= int(_num(val.get("direction_count"), 1) or 1) if "Rotated" in type_name else 1
            per_row = int(_num(val.get("line_length"), 0)) or frames
            rows_per_var = math.ceil(frames / per_row)
            variations = int(_num(val.get("variation_count"), 1)) or 1
            cols, rows = min(per_row, frames), rows_per_var * variations
        else:
            frames = int(_num(val.get("direction_count"), 0) or _num(val.get("variation_count"), 0) or 1)
            per_row = int(_num(val.get("line_length"), 0)) or frames
            cols, rows = min(per_row, frames), math.ceil(frames / per_row)
        need_w, need_h = x + w * cols, y + h * rows
        short = os.path.basename(fn)
        repo_path = self.images.path(fn)
        if need_w > W or need_h > H:
            self.add(ERROR, "sprites", path,
                     f"{short}: needs {need_w}x{need_h} px ({cols}x{rows} frames of {w}x{h}) but the image is {W}x{H}",
                     repo_path)
        elif x == 0 and y == 0 and cols * rows > 1 and (need_w != W or need_h != H) and W % cols == 0 and H % rows == 0:
            self.add(WARNING, "sprites", path,
                     f"{short}: frame {w}x{h} but the {W}x{H} sheet ({cols}x{rows} frames) suggests {W // cols}x{H // rows}",
                     repo_path)

    def _check_icon(self, val: dict, path: str):
        fn = val["icon"]
        size = self.images.size(fn)
        if size is None or size == "exists":
            return
        if size is False:
            self.add(ERROR, "sprites", path, f"icon file not found: {fn}", self.images.path(fn))
            return
        isz = _num(val.get("icon_size"), 64)
        if size[0] < isz or size[1] < isz:
            self.add(ERROR, "sprites", path,
                     f"{os.path.basename(fn)}: icon_size {isz} is larger than the image {size[0]}x{size[1]}",
                     self.images.path(fn))

    # -- fuel rule (2.1.20) ---------------------------------------------------------------
    def run_fuel(self):
        for n, it in self.items.items():
            if "fuel_category" in it:
                self.add(ERROR, "fuel", f"{it.get('type')}/{n}",
                         "ItemPrototype::fuel_category was removed in 2.1.20, use fuel_categories = { ... }")
            fv = it.get("fuel_value")
            if fv and not re.match(r"^0(\.0*)?[kMGTPEZYRQ]?[JW]?$", str(fv)) and not it.get("fuel_categories"):
                self.add(ERROR, "fuel", f"{it.get('type')}/{n}",
                         "fuel_value without fuel_categories (mandatory since 2.1.20)")

    # -- references ------------------------------------------------------------------------
    def run_refs(self):
        recipes = self.raw.get("recipe", {})
        techs = self.raw.get("technology", {})
        rcats = self.raw.get("recipe-category", {})
        fcats = self.raw.get("fuel-category", {})
        tiles = self.raw.get("tile", {})
        unlocked: dict[str, list[str]] = {}

        for tn, t in techs.items():
            for e in t.get("effects") or []:
                if e.get("type") == "unlock-recipe":
                    unlocked.setdefault(e.get("recipe"), []).append(tn)
                    if e.get("recipe") not in recipes:
                        self.add(ERROR, "refs", f"technology/{tn}", f"unlocks missing recipe '{e.get('recipe')}'")
            for pre in t.get("prerequisites") or []:
                if pre not in techs:
                    self.add(ERROR, "refs", f"technology/{tn}", f"missing prerequisite '{pre}'")
            for ing in (t.get("unit") or {}).get("ingredients") or []:
                name = ing[0] if isinstance(ing, list) else ing.get("name")
                if name not in self.items:
                    self.add(ERROR, "refs", f"technology/{tn}", f"research ingredient '{name}' does not exist")
            trig = t.get("research_trigger") or {}
            item = trig.get("item")
            if isinstance(item, dict):
                item = item.get("name")
            if item and item not in self.items:
                self.add(ERROR, "refs", f"technology/{tn}", f"research trigger item '{item}' does not exist")

        for rn, r in recipes.items():
            for kind in ("ingredients", "results"):
                for x in r.get(kind) or []:
                    name, ty = x.get("name"), x.get("type", "item")
                    ok = name in self.fluids if ty == "fluid" else (ty == "research-progress" or name in self.items)
                    if not ok:
                        self.add(ERROR, "refs", f"recipe/{rn}", f"{kind[:-1]} '{name}' ({ty}) does not exist")
            for c in r.get("categories") or []:
                if c not in rcats:
                    self.add(ERROR, "refs", f"recipe/{rn}", f"recipe category '{c}' does not exist")
            mp = r.get("main_product")
            if isinstance(mp, str) and mp and mp not in [x.get("name") for x in r.get("results") or []]:
                self.add(ERROR, "refs", f"recipe/{rn}", f"main_product '{mp}' is not one of the results")

            # unreachable recipes (only ones the mod set adds)
            if self.is_new("recipe", rn) and r.get("enabled") is False and rn not in unlocked and not r.get("hidden"):
                self.add(WARNING, "unlock", f"recipe/{rn}", "enabled = false and no technology unlocks it")

            # productivity loops
            if r.get("allow_productivity"):
                consumed = {x.get("name"): _num(x.get("amount")) for x in r.get("ingredients") or []}
                for x in r.get("results") or []:
                    name, amount, ign = x.get("name"), _num(x.get("amount")), _num(x.get("ignored_by_productivity"))
                    base = consumed.get(name) or consumed.get(re.sub(r"_used$", "", name or ""))
                    if base and amount and ign < amount and self.is_new("recipe", rn):
                        self.add(WARNING, "prod-loop", f"recipe/{rn}",
                                 f"returns {amount} '{name}' but only {ign} is ignored by productivity: "
                                 f"productivity creates extra '{name}' from nothing")

        for n, it in self.items.items():
            where = f"{it.get('type')}/{n}"
            if it.get("place_result") and it["place_result"] not in self.entities:
                self.add(ERROR, "refs", where, f"place_result '{it['place_result']}' does not exist")
            if it.get("burnt_result") and it["burnt_result"] not in self.items:
                self.add(ERROR, "refs", where, f"burnt_result '{it['burnt_result']}' does not exist")
            for fc in it.get("fuel_categories") or []:
                if fc not in fcats:
                    self.add(ERROR, "refs", where, f"fuel category '{fc}' does not exist")
            pat = it.get("place_as_tile")
            if isinstance(pat, dict) and pat.get("result") not in tiles:
                self.add(ERROR, "refs", where, f"place_as_tile result '{pat.get('result')}' does not exist")

        for n, e in self.entities.items():
            typ = e.get("type")
            where = f"{typ}/{n}"
            mn = e.get("minable") or {}
            if mn.get("result") and mn["result"] not in self.items:
                self.add(ERROR, "refs", where, f"minable result '{mn['result']}' does not exist")
            for c in e.get("crafting_categories") or []:
                if c not in rcats:
                    self.add(ERROR, "refs", where, f"crafting category '{c}' does not exist")
            for key in ("energy_source", "burner"):
                es = e.get(key)
                if isinstance(es, dict) and es.get("type", "burner") == "burner":
                    for fc in es.get("fuel_categories") or []:
                        if fc not in fcats:
                            self.add(ERROR, "refs", where, f"{key} fuel category '{fc}' does not exist")
            nu = e.get("next_upgrade")
            if nu:
                target = (self.raw.get(typ) or {}).get(nu) or self.entities.get(nu)
                if not target:
                    self.add(ERROR, "refs", where, f"next_upgrade '{nu}' does not exist")
                elif self.is_new(typ, n) or self.is_new(target.get("type"), nu) or \
                        (self.van.get(typ, {}).get(n, {}).get("next_upgrade") != nu):
                    if e.get("collision_box") != target.get("collision_box"):
                        self.add(ERROR, "refs", where, f"next_upgrade '{nu}' has a different collision_box")
                    if e.get("fast_replaceable_group") != target.get("fast_replaceable_group"):
                        self.add(ERROR, "refs", where, f"next_upgrade '{nu}' has a different fast_replaceable_group")
        for n, t in tiles.items():
            if t.get("fluid") and t["fluid"] not in self.fluids:
                self.add(ERROR, "refs", f"tile/{n}", f"fluid '{t['fluid']}' does not exist")

    # -- locale ----------------------------------------------------------------------------
    def _named(self, p: dict) -> bool:
        if p is None:
            return False
        if p.get("localised_name") is not None:
            return True
        typ, n = p.get("type"), p.get("name")
        if typ == "fluid":
            return f"fluid-name.{n}" in self.locale
        if typ in self.item_types:
            if f"item-name.{n}" in self.locale:
                return True
            if p.get("place_result") and f"entity-name.{p['place_result']}" in self.locale:
                return True
            if p.get("place_as_equipment_result") and f"equipment-name.{p['place_as_equipment_result']}" in self.locale:
                return True
            pat = p.get("place_as_tile")
            return isinstance(pat, dict) and f"tile-name.{pat.get('result')}" in self.locale
        return False

    def run_locale(self):
        def lookup(name):
            return self.items.get(name) or self.fluids.get(name)

        for typ, lst in self.raw.items():
            if not isinstance(lst, dict):
                continue
            for n, p in lst.items():
                if not isinstance(p, dict) or not self.is_new(typ, n) or p.get("localised_name") is not None:
                    continue
                where = f"{typ}/{n}"
                if typ == "recipe":
                    if f"recipe-name.{n}" in self.locale:
                        continue
                    prod = None
                    mp = p.get("main_product")
                    results = p.get("results") or []
                    if isinstance(mp, str) and mp:
                        prod = mp
                    elif mp is None and len(results) == 1:
                        prod = results[0].get("name")
                    if not (prod and self._named(lookup(prod))):
                        self.add(WARNING, "locale", where, f"no name: add recipe-name.{n} or localised_name")
                elif typ in self.item_types or typ == "fluid":
                    if not self._named(p):
                        self.add(WARNING, "locale", where, f"no name: add {'fluid' if typ == 'fluid' else 'item'}-name.{n}")
                elif typ == "technology":
                    base = re.sub(r"-\d+$", "", n)
                    if f"technology-name.{n}" not in self.locale and f"technology-name.{base}" not in self.locale:
                        self.add(WARNING, "locale", where, f"no name: add technology-name.{base}")
                elif typ == "tile":
                    if f"tile-name.{n}" not in self.locale:
                        self.add(WARNING, "locale", where, f"no name: add tile-name.{n}")
                elif typ in self.equipment_types:
                    if f"equipment-name.{n}" not in self.locale:
                        self.add(WARNING, "locale", where, f"no name: add equipment-name.{n}")
                elif typ in self.entity_types and "not-in-made-in" not in (p.get("flags") or []):
                    if p.get("hidden") or "hidden" in (p.get("flags") or []):
                        continue
                    if f"entity-name.{n}" not in self.locale:
                        self.add(WARNING, "locale", where, f"no name: add entity-name.{n}")

    def run(self, checks: set[str]) -> list[Finding]:
        if checks & {"schema", "sprites"}:
            self.run_schema_and_sprites()
            if "schema" not in checks:
                self.findings = [f for f in self.findings if f.check != "schema"]
            if "sprites" not in checks:
                self.findings = [f for f in self.findings if f.check != "sprites"]
        if "fuel" in checks:
            self.run_fuel()
        if checks & {"refs", "unlock", "prod-loop"}:
            self.run_refs()
            self.findings = [f for f in self.findings if f.check not in {"refs", "unlock", "prod-loop"} - checks]
        if "locale" in checks:
            self.run_locale()
        # a vanilla-equivalent finding is not the mod set's problem
        return self.findings


ALL_CHECKS = ["schema", "fuel", "refs", "unlock", "prod-loop", "sprites", "locale"]


def vanilla_findings_filter(mod_findings: list[Finding], vanilla_findings: list[Finding]) -> list[Finding]:
    known = {f.key() for f in vanilla_findings}
    return [f for f in mod_findings if f.key() not in known]


def load_dump(path: str) -> dict:
    with open(path, encoding="utf-8") as fh:
        return json.load(fh)
