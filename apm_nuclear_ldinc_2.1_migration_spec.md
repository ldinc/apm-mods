# Migration Spec: `apm_nuclear_ldinc` → Factorio 2.1.10

**Document type:** Task specification for an LLM coding agent.
**Target repo:** `apm_nuclear_ldinc` (Factorio mod, data-stage + minimal control stage).
**Source state:** v0.32.03, `factorio_version: "2.0"`.
**Target state:** v0.33.00, `factorio_version: "2.1"`, loads and functions on Factorio 2.1.10.
**Audit date:** 2026-07-31. Audit basis: full read of all 66 `.lua` files in the mod, all 123 `.lua` files in `apm_lib_ldinc` 0.32.13, and the official Factorio 2.1.0 changelog (Modding + Scripting sections).

---

## 0. Agent instructions

Read sections 1–3 before editing anything. Section 4 is the ordered work plan. Section 5 lists things that must NOT be changed — these are false positives that a naive find-and-replace will corrupt. Section 6 is verification.

Rules:
- Do not "fix" anything not listed here. This mod has intentional dead code (integrations for mods that have no 2.x release) — leave it alone.
- Preserve CRLF line endings. Most files in this repo use `\r\n`.
- Preserve the existing tab indentation and the column alignment of table literals.
- Every change in section 4 is independently verifiable. Do phases in order; do not batch phases 1 and 2 together.

---

## 1. Critical context: the dependency is ahead of the mod

`apm_lib_ldinc` is a **hard dependency** and is already fully ported:

```json
"factorio_version": "2.1",
"dependencies": ["base >= 2.1.7", ...]
```

Current lib version: **0.32.13** (2026-07-24). Relevant lib history:

| Lib version | Change relevant to this migration |
|---|---|
| 0.32.10 | Factorio 2.1 support. `recipe.category.change` **signature and logic changed**. Internal recipe builder migrated to `categories` array. `always_show_products` removed from internal recipes; `recipe.set.always_show_products` deprecated. `item.mod.overwrite_weight_for_science_packs` rewritten to discover packs via lab inputs. Added `recipe.category.add`, `recipe.category.replace`, `item.get.all_science_packs_names`. |
| 0.32.12 | Fixed `recipe.result.mod` (was checking removed `probability` instead of `independent_probability`). Fixed `recipe.category.add` crash on recipes with no explicit `categories`. Fixed `builder.recipe.item.probability` emitting removed `probability` field. |
| 0.32.13 | Added science pack ordering API: `technology.overwrite.science_pack_order_strings`, `technology.set.science_pack_order(s)`, `technology.remove.science_pack_order(s)`. |

**API compatibility check performed:** all 97 distinct `apm.lib.*` symbols referenced by `apm_nuclear_ldinc` were diffed against the 356 function definitions in lib 0.32.13. **All 97 still exist.** Exactly one has a changed signature (see 2.2). No other lib-side breakage.

---

## 2. Blocking issues

### 2.1 `info.json` — version bump (blocks everything)

A mod declaring `factorio_version: "2.0"` is treated as incompatible by Factorio 2.1 and will not load at all.

```diff
- "factorio_version": "2.0",
+ "factorio_version": "2.1",
```

Also raise the lib floor. The mod currently declares `apm_lib_ldinc >= 0.32.08`, which predates 2.1 support:

```diff
- "apm_lib_ldinc >= 0.32.08",
+ "apm_lib_ldinc >= 0.32.13",
```

`>= 0.32.10` is the functional minimum, but `0.32.13` is required for the science-pack ordering used in 4.3 and includes the 0.32.12 correctness fixes.

Optional: 2.1 added the `+` dependency modifier (optional but enabled by default). Candidate: `"? apm_power_ldinc >= 0.32.00"` → `"+ apm_power_ldinc >= 0.32.00"`. This is a design choice, not a requirement.

### 2.2 `recipe.category.change` — changed signature (latent crash)

Lib 0.32.10 changed the first parameter from a recipe **name string** to a recipe **prototype table**:

```lua
-- apm_lib_ldinc/lib/utils/recipe/actions.lua:109
---@param recipe RecipePrototype
---@param category_name string
function apm.lib.utils.recipe.category.change(recipe, category_name)
    recipe.categories = { category_name }
    ...
end
```

Passing a string produces `attempt to index a string value` at data stage.

Three active call sites, all in `prototypes/integrations/recipes.lua`:

| Line | Call | Gate |
|---|---|---|
| 137 | `category.change("apm_radioactive_wastewater_recyling", "angels-water-treatment")` | `mods.angelsrefining and apm_nuclear_compat_angel` |
| 154 | `category.change("apm_depleted_uranium_metal_mixture", "angels-powder-mixing")` | `mods.angelssmelting and mods.angelspetrochem and mods.bobplates and apm_nuclear_compat_angel` |
| 171 | `category.change("water-cooling", "apm_fluid_cooling_0")` | `mods.RealisticReactors and apm_nuclear_compat_realistic_reactors` |

There is also a commented-out call at line 156 — leave it commented, but update its text so it does not mislead a future reader.

**Severity: latent, not day-one.** All three gates require mods with no Factorio 2.x release (Angel's, RealisticReactors), so these branches do not currently execute. They must still be fixed — they are silent landmines.

**Fix pattern:**

```lua
-- before
apm.lib.utils.recipe.category.change("water-cooling", "apm_fluid_cooling_0")

-- after
local recipe, ok = apm.lib.utils.recipe.get.by_name("water-cooling")
if ok then
    apm.lib.utils.recipe.category.change(recipe, "apm_fluid_cooling_0")
end
```

Prefer `apm.lib.utils.recipe.category.replace(recipe, old, new)` when the intent is to swap one category while preserving others on a multi-category recipe. `category.change` wipes the list down to a single entry.

### 2.3 `RecipePrototype::category` removed (silent functional breakage)

Factorio 2.1 removed `RecipePrototype::category` and `additional_categories`, replaced by `categories` (array).

**Failure mode is silent, not a crash.** Factorio ignores the now-unknown `category` key and `categories` defaults to `{"crafting"}`. Result: a mod that loads cleanly and is completely broken — every chemistry/centrifuging/smelting recipe becomes a "crafting" recipe, and fluid-bearing recipes become uncraftable (hand-crafting cannot accept fluid ingredients).

**59 occurrences across 12 files.** Counts verified by `grep -c "^\s*category\s*=" `:

| Count | File |
|---|---|
| 11 | `prototypes/main/recipes/thorium.lua` |
| 10 | `prototypes/main/recipes/uranium.lua` |
| 9 | `prototypes/main/recipes/intermediates.lua` |
| 7 | `prototypes/main/recipes/hexafluoride.lua` |
| 6 | `prototypes/main/recipes/purex.lua` |
| 4 | `prototypes/main/recipes/neptunium.lua` |
| 4 | `prototypes/main/recipes/mox.lua` |
| 2 | `prototypes/main/recipes/shielded_nuclear_fuel.lua` |
| 2 | `prototypes/main/recipes/pellets.lua` |
| 2 | `prototypes/main/recipes/cooling.lua` |
| 1 | `prototypes/main/recipes/waste.lua` |
| 1 | `prototypes/main/recipes/science.lua` |

Distinct values in use (all 9 survive 2.1 — none were among the removed hybrid categories):

`chemistry` (29), `advanced-crafting` (10), `crafting-with-fluid` (9), `apm_nuclear_cooling_0` (6), `apm_fluid_cooling_0` (2), `smelting` (1), `centrifuging` (1), `apm_electric_smelting` (1).

**Transform:**

```lua
-- before
category = "chemistry",

-- after
categories = { "chemistry" },
```

⚠️ See section 5.1 for the one occurrence that must NOT be transformed.

### 2.4 Science pack is `type = "tool"` (silent lib incompatibility)

`prototypes/main/items/science.lua` defines:

```lua
---@type data.ToolPrototype
local item = {
    type = "tool",
    name = "apm_nuclear_science_pack",
    ...
    group = "apm_nuclear",
    subgroup = "apm_nuclear_science",
    order = "aa_a",
    durability = 1,
    durability_description_key = "description.science-pack-remaining-amount-key",
    durability_description_value = "description.science-pack-remaining-amount-value",
    weight = apm.lib.utils.constants.value.weight.science_pack,
}
```

Factorio 2.1 changed all base science packs from `tool` to plain items, and `TechnologyPrototype`/`LabPrototype` now accept any item type. A tool-typed pack still *loads*, but the lib now assumes plain items in one place:

```lua
-- apm_lib_ldinc/lib/utils/item.lua:532, inside item.mod.overwrite_weight_for_science_packs
local item = data.raw["item"] and data.raw["item"][name]
if item then item.weight = w end
```

The pack IS discovered by `item.get.all_science_packs_names()` (which reads `data.raw.lab[*].inputs`, and the pack is registered there), but the `data.raw["item"]` lookup then misses it, so its weight is silently never applied.

Note the lib is internally inconsistent: `technology.overwrite.science_pack_order_strings` handles both types (`data.raw["item"][pack_name] or data.raw["tool"][pack_name]`), while the weight function does not. Converting the pack sidesteps the inconsistency.

**Fix:**

```lua
---@type data.ItemPrototype
local item = {
    type = "item",
    name = "apm_nuclear_science_pack",
    localised_description = { "item-description.science-pack" },
    icons = { apm.nuclear.icons.sciencepack },
    stack_size = 200,
    subgroup = "apm_nuclear_science",
    order = "aa_a",
    weight = apm.lib.utils.constants.value.weight.science_pack,
}
```

Three changes: `tool` → `item`, drop the three `durability*` fields (meaningless on a plain item), drop `group = "apm_nuclear"`. `group` is **not a valid ItemPrototype property** — item group membership is derived from `subgroup`. It was silently ignored before and remains ignored; removing it is cleanup, not behaviour change.

Also update the `---@type` annotation from `data.ToolPrototype` to `data.ItemPrototype`.

---

## 3. Non-blocking cleanup and improvements

### 3.1 `always_show_products` removed — 63 occurrences

`RecipePrototype::always_show_products` and `show_amount_in_title` were removed in 2.1. Unknown keys are silently ignored, so this is log noise rather than breakage. Delete the lines.

| Count | File |
|---|---|
| 11 | `prototypes/main/recipes/thorium.lua` |
| 10 | `prototypes/main/recipes/uranium.lua` |
| 9 | `prototypes/main/recipes/intermediates.lua` |
| 7 | `prototypes/main/recipes/hexafluoride.lua` |
| 6 | `prototypes/main/recipes/purex.lua` |
| 4 | `prototypes/main/recipes/neptunium.lua` |
| 4 | `prototypes/main/recipes/mox.lua` |
| 3 | `prototypes/main/recipes/entities.lua` |
| 2 | `prototypes/main/recipes/shielded_nuclear_fuel.lua` |
| 2 | `prototypes/main/recipes/pellets.lua` |
| 2 | `prototypes/main/recipes/cooling.lua` |
| 1 | `prototypes/main/recipes/waste.lua` |
| 1 | `prototypes/main/recipes/science.lua` |
| 1 | `prototypes/integrations/recipes.lua` |

`always_show_made_in` was **not** removed — keep every occurrence of it.

There is also one live call to the deprecated lib helper, at `prototypes/integrations/recipes.lua:178`:

```lua
apm.lib.utils.recipe.set.always_show_products("water-cooling", true)
```

It sits inside the `mods.RealisticReactors` gate, so it does not currently execute. The function still exists in lib 0.32.13 (deprecated, not removed), so it will not crash — it just does nothing. Delete the line. Do not call this helper in new code.

### 3.2 `icon_mipmaps` — 8 occurrences

Ignored since 2.0. All 8 are in `lib/definitions.lua`, lines 145–152 (the `fluorite*` and `thorium_ore*` icon tables). Remove the `icon_mipmaps=4` key from each. These lines also carry a redundant `size=64` alongside `icon_size=64`; leave `size` alone unless verified unused.

### 3.3 Adopt the lib's science pack ordering (recommended)

Lib 0.32.13 ships a science pack order map that **already includes this mod's pack**:

```lua
-- apm_lib_ldinc/lib/utils/technology/science.lua:296
apm.lib.utils.technology.science_pack_order = {
    ...
    ["utility-science-pack"]     = "h[utility-science-pack]",
    ["apm_nuclear_science_pack"] = "i[apm_nuclear_science_pack]",
    ["space-science-pack"]       = "j[space-science-pack]",
    ...
}
```

The mod currently sets `order = "aa_a"` and `subgroup = "apm_nuclear_science"` on the pack, which makes it sort incorrectly in the technology and lab GUIs. The game sorts a technology's science packs by item group/subgroup/order string, not by the ingredients array.

Add at the **end** of `data-final-fixes.lua` (the lib's doc comment specifies it must run after all mods have created their packs):

```lua
apm.lib.utils.technology.overwrite.science_pack_order_strings("science-pack")
```

The `subgroup` argument also normalises the pack into the standard `science-pack` subgroup. Omit the argument to keep `apm_nuclear_science`. Note this call also rewrites vanilla packs' order strings to the APM progression order, which affects inventory sorting — that is the intended behaviour of the API but should be confirmed as desired.

### 3.4 Pre-existing bug: wrong mod name in `mods.*` checks

Unrelated to 2.1; present in the 2.0 code. The mod set uses the fork name `apm_power_ldinc`, but three sites check for the upstream name `apm_power`:

| File | Line | Current |
|---|---|---|
| `prototypes/integrations/recipes.lua` | 46 | `if not mods.apm_power then` |
| `prototypes/integrations/recipes.lua` | 142 | `if not mods.apm_power then` |
| `prototypes/integrations/entities.lua` | 34 | `if mods.apm_power then` |

Other files in the same mod correctly check `mods.apm_power_ldinc`. Consequence with the fork installed: the two `not mods.apm_power` fallback branches always fire, and the `mods.apm_power` integration branch never does.

Fix to `mods.apm_power_ldinc`, or to `(mods.apm_power or mods.apm_power_ldinc)` if upstream compatibility is wanted. Confirm intent before changing — this alters which recipes are generated.

---

## 4. Ordered work plan

**Phase 0 — Unblock.** Section 2.1. Verify Factorio 2.1.10 loads `apm_lib_ldinc` + `apm_resource_pack_ldinc` alone, with `apm_nuclear_ldinc` disabled, before proceeding.

**Phase 1 — Mechanical sweep.** Sections 2.3, 3.1, 3.2. Scriptable, low risk, largest diff. Respect section 5 exclusions. Commit separately from phase 2.

**Phase 2 — API contract.** Sections 2.2, 2.4, 3.3.

**Phase 3 — Pre-existing bugs.** Section 3.4.

**Phase 4 — In-game entity validation.** Section 6.2. Cannot be done statically; requires a running game.

**Phase 5 — Hygiene.** Enable `check-unused-prototype-data` (Ctrl+Alt+click "Settings" → "The rest") and read `factorio-current.log` for remaining dead prototype properties.

Bump `version` in `info.json` to `0.33.00` and add a `changelog.txt` entry following the existing format (note the file uses the strict Factorio changelog format: 99 dashes as separator, two-space indent for categories, four-space for entries).

---

## 5. Do NOT change (false positives)

### 5.1 `category = "resource"` on the ResourcePrototype

`prototypes/main/entities/thorium.lua:19` — the `category` key sits at the top level of the ResourcePrototype, not inside the `minable` block.

```lua
-- ResourcePrototype: category is a resource-category, NOT a recipe category.
-- This field was NOT removed in 2.1. Leave as-is.
category = "resource",
```

A regex targeting `^\s*category\s*=` will match this. It must be excluded. This is why the real recipe count is 59, not 60.

### 5.2 Other surviving `category` / `categories` fields

None of these were touched by 2.1. Do not rewrite:
- `crafting_categories` (assembling-machine, furnace, character)
- `resource_categories`
- `fuel_categories` (burner energy sources, reactors, labs)
- `module_categories`
- `equipment_categories` / `categories` on equipment prototypes

### 5.3 `minable.result` (singular)

`prototypes/main/entities/thorium.lua`, inside `minable = { ... result = name ... }`. `MinableProperties::result` is singular and still valid. Only `RecipePrototype` moved from `result` to `results`, and that migration already happened in 2.0.

### 5.4 Dead integration code

Integrations for Angel's, Space Exploration, ScienceCostTweakerM, Bio_Industries, RealisticReactors, Mining-Space-Industries target mods with no Factorio 2.x release. All are correctly gated behind `mods[...]` checks and are harmless. Do not delete them — they are intentional.

### 5.5 `control.lua`

Verified clean. It performs only `remote.call` into `apm_radiation` and `apm_equipment` interfaces on `on_init` / `on_configuration_changed`. None of the 2.1 runtime removals appear anywhere in it:
- `LuaEntity::fluidbox` / `LuaFluidBox` (removed)
- `LuaEntity::active` write (removed → `disabled_by_script`)
- `LuaEntity::minable` write (removed → `minable_flag`)
- `LuaEntity::neighbors` (removed)
- `defines.inventory.assembling_machine_*` / `furnace_*` / `rocket_silo_*` (removed → `crafter_*`)
- `LuaGameScript::create_profiler` (removed → `LuaHelpers::create_profiler`)
- `defines.default_icon_size` (renamed → `defines.constant.default_icon_size`)

No changes required.

---

## 6. Verification

### 6.1 Static checks (post-edit, pre-launch)

```bash
# Must return 0 (excluding the ResourcePrototype in entities/thorium.lua)
grep -rn "^\s*category\s*=" prototypes/main/recipes/

# Must return 0
grep -rn "always_show_products\|show_amount_in_title\|icon_mipmaps" --include="*.lua" .

# Must return 0 — no string-first calls remain
grep -rn "category\.change(\s*[\"']" --include="*.lua" .

# Must return 0
grep -rn "mods\.apm_power[^_]" --include="*.lua" .

# Must return 0 — science pack is no longer a tool
grep -n "type = \"tool\"" prototypes/main/items/science.lua

# Sanity: always_show_made_in was NOT removed in 2.1 — must still print 95
grep -rc "always_show_made_in" --include="*.lua" . | awk -F: '{s+=$2} END {print s}'
```

### 6.2 In-game validation (requires Factorio 2.1.10)

Load order for testing: `apm_lib_ldinc` → `apm_resource_pack_ldinc` → `apm_nuclear_ldinc`. Test with base game first, no Space Age, no quality — 2.1 converted Space Age's quality dependency to a recommendation, so quality can now be disabled while Space Age is enabled; test that combination separately.

**Priority 1 — breeder reactor (`apm_nuclear_breeder`), highest rework risk.**

2.1 added `ReactorPrototype::neighbour_connectable`; reactors no longer connect based on touching edges. `prototypes/main/entities/breeder_reactor.lua:8` does `table.deepcopy(data.raw.reactor["nuclear-reactor"])`, so it inherits 2.1 vanilla's `neighbour_connectable`. Collision box is `{{-2.2,-2.2},{2.2,2.2}}` — same 5×5 footprint as vanilla, so inherited geometry should align. However, lines 92–151 fully replace `heat_buffer` with a custom 12-connection layout at ±2 offsets, and `neighbour_bonus = 0.5` (line 30) now flows through the inherited connectable definition rather than through those heat connections. **The two definitions can disagree.**

Test explicitly:
1. Breeder ↔ breeder adjacency — does the neighbour bonus apply?
2. Breeder ↔ vanilla `nuclear-reactor` adjacency.
3. Heat pipe attachment at all 12 connection points (3 per side).

If the bonus fails, define `neighbour_connectable` explicitly on the breeder to match the heat_buffer connection positions.

Note: `apm.lib.utils.reactor.overhaul()` (called from `prototypes/main/entities-overwrites.lua:22` for every reactor in `data.raw`) was read in full — it only rewrites `fuel_categories` via `entity.set.fuel_category`. It never touches neighbour or heat data, so it neither helps nor hurts here.

**Priority 2 — fluid throughput.**

2.1 removed `UtilityConstants::max_fluid_flow`; max flow is now derived from `FluidBox::volume`. Affects:
- `apm_cooling_pond_0` (`prototypes/main/entities/cooling_pond.lua`) — three boxes at volume 2000, built via `apm.lib.utils.builders.fluid_box.new`
- `apm_hybrid_cooling_tower` (`prototypes/main/entities/hybrid_cooling_tower.lua`) — same builder

The lib's `fluid_box.new` is clean 2.1 style (`flow_direction`, `production_type`, `volume`; no removed `hide_connection_info`), so nothing breaks structurally. But the *rate* of coolant movement is now a function of volume. Benchmark a full cooling loop before/after; retune `volume` rather than recipe `energy_required` if throughput regressed.

**Priority 3 — science pack.** Confirm it appears in the lab GUI, is accepted by all technologies that list it, and sorts correctly in the tech tree after 3.3. Check `item.weight` is actually applied (was silently skipped pre-fix).

**Priority 4 — recipe categories.** For each of the 9 distinct categories, confirm at least one recipe appears in the correct machine. Highest risk: `chemistry` (29 recipes) and the two custom cooling categories.

---

## 7. Upstream note for `apm_lib_ldinc` (not part of this task)

Two lib-side issues observed during the audit, worth filing separately:

1. `lib/utils/item.lua:532` — `item.mod.overwrite_weight_for_science_packs` looks up `data.raw["item"][name]` only, while `technology.overwrite.science_pack_order_strings` (`lib/utils/technology/science.lua:359`) handles `data.raw["item"] or data.raw["tool"]`. Inconsistent handling of tool-typed packs from third-party mods.

2. `lib/utils/builders/fluid_box.lua` — `new_steam_input` defaults `max_t = 550`; `new_steam_input_3way` and `new_steam_input_4way` default `max_t = 1000`. Factorio 2.1 reduced steam's max temperature to 500°, making these ranges partly unreachable. `apm_nuclear_ldinc` uses only `fluid_box.new` and is unaffected, but `apm_power_ldinc` likely calls the steam builders.

---

## 8. Reference: full 2.1 change list relevant to this mod set

Prototype changes that were checked and found **not** to affect `apm_nuclear_ldinc`:

- `RecipePrototype::always_show_products`, `show_amount_in_title` removed → §3.1
- `ProductPrototype` restructured: `probability` → `independent_probability`; `show_details_in_recipe_tooltip` moved to `ProductPrototypeBase` → mod already uses correct 2.1 form
- Recipe category rework (removed `basic-crafting`, `electronics`, `chemistry-or-cryogenics`, `pressing`, `crafting-with-fluid-or-metallurgy`, `metallurgy-or-assembling`, `organic-or-*`, `electronics-or-assembling`, `electronics-with-fluid`, `cryogenics-or-assembling`; added `hand-crafting`) → mod uses none of the removed categories
- `"recycling"` category moved from base to the new recycler mod → mod does not use it
- Science packs converted from `tool` to plain items → §2.4
- `VehiclePrototype::braking_power`, `friction` removed → not used
- `EntityWithHealthPrototype::loot` → array → not used
- `EntityPrototype::build_base_evolution_requirement` removed → not used
- `GeneratorPrototype::horizontal_animation` / `vertical_animation` moved to `pictures` → not used
- `FluidBox::hide_connection_info` removed → not used
- Steam max temperature reduced to 500° → hottest steam in this mod is 165° (`prototypes/main/recipes/hexafluoride.lua:158`); breeder `heat_buffer.max_temperature = 1000` is a heat buffer, not a fluid, and is unaffected
- `MineEntityTechnologyTrigger::entity` → `entities` → mod uses no research triggers
- `defines.default_icon_size` renamed → not referenced in this mod (verified in lib too)

New 2.1 features available but not required:

- `BurnerEnergySource::auto_refuel` — candidate for the burner-based equipment (`prototypes/main/equipment/fission_reactor.lua`, `fussion_reactor.lua`), would let armour pull fuel automatically
- Multiple categories per recipe — could simplify the `apm_electric_smelting` / `smelting` duplication in `prototypes/main/recipes/intermediates.lua`
- `"+"` dependency modifier → §2.1
