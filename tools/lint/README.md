# Lint (Docker)

```powershell
./lint.ps1                        # everything: LuaLS + Factorio data check, all linted mods
./lint.ps1 luals                  # only lua-language-server (no game run)
./lint.ps1 luals apm_nuclear      # one mod (folder name or info.json name)
./lint.ps1 data --profile base    # only the Factorio check, without Space Age
./lint.ps1 -h                     # all lint options
```

The lint runs in a Docker container. The repo is mounted **read-only**. Findings are printed to the console,
one per line:

```
apm_lib/lib/utils/recipe/result.lua:110:38: warning: [luals/undefined-field] Undefined field `normal`.
data.raw: warning: [data/unlock] recipe/apm_phosphorpentachlorid: enabled = false and no technology unlocks it (base,space-age)
lint: 180 warnings
```

It also writes a detailed report to `lint-report\lint-report.md` (see [The report](#the-report)). The exit code is
1 when there is an error (with `--strict`, on warnings too), and 2 when the lint itself could not run.

Only these repo folders are linted: `apm_energy_addon`, `apm_lib`, `apm_nuclear`, `apm_power`,
`apm_resource_pack`. Other folders (old or deprecated mods) are ignored. To change the list, set
`"lint": {"mods": [...]}` in `build.config.json`, or edit `LINT_MODS` in `tools/lint/lint.py`.

## Setup

- Install **Docker Desktop** (Linux containers) and keep it running. Nothing else is needed on Windows.
- The first `./lint.ps1` builds the image `apm-lint:<factorio version>`. This takes a few minutes and downloads:
  - Factorio headless (the free server build), from factorio.com
  - the Factorio API JSON, from lua-api.factorio.com; the Factorio LuaLS types are generated from it with FMTK
  - lua-language-server, from GitHub

  After that the image is reused. Use `--rebuild` to build it again.
- **Factorio version:** the same as your install in `build.config.json` → `factorio.stable`; otherwise 2.1.20.
  Override it with `--factorio-version 2.1.21`.
- Add `lint-report/` to `.gitignore`.
- If script execution is blocked: `powershell -NoProfile -ExecutionPolicy Bypass -File lint.ps1`.

`lint.ps1` options (everything else is passed to the lint):

| option | effect |
|---|---|
| `--rebuild` | rebuild the image |
| `--factorio-version X` | lint against another Factorio version (its own image) |
| `--out <folder>` | report folder (default `lint-report\`) |
| `--mods-dir <folder>` | Factorio mods folder for non-repo dependencies (default: `<factorio>\mods`, then `%APPDATA%\Factorio\mods`) |

Mounts:

| host | container | mode | what |
|---|---|---|---|
| the repo | `/repo` | **read-only** | sources; `tools/lint/*.py` runs from here, so script changes need no rebuild |
| report folder | `/out` | read-write | `lint-report.md` |
| Factorio mods folder | `/mods` | read-only | non-repo dependencies, e.g. `freeplay_starting_equipment` |
| Docker volume `apm-lint-cache` | `/cache` | read-write | vanilla dumps and LuaLS work files (`docker volume rm apm-lint-cache` clears it) |

## Lint options

| option | effect |
|---|---|
| `--min-severity error` | only errors |
| `--strict` | exit 1 on warnings too |
| `--profile base\|space-age` | only one Factorio profile (default both) |
| `--checks fuel,refs,locale` | only these data checks |
| `--no-load-test` | skip the `--create` load test (faster) |
| `--jobs N` | LuaLS check threads (default `min(4, CPUs)`, about 1 GB RAM each; lower it if Docker runs out of memory) |
| `--show-type-noise` | include LuaLS false positives of the Factorio types |
| `--timeout S` | seconds per Factorio run (default 600) |

## What it checks

### `luals`: lua-language-server with the Factorio types

- It runs `lua-language-server --check` on the linted mods with the Factorio API types (runtime **and** data
  stage) of the image's Factorio version. These are the same types the FMTK VS Code extension uses.
- The sources are copied into the cache under their mod names (`apm_lib_ldinc/…`), so that
  `require("__apm_lib_ldinc__.lib.x")` resolves. The repo folders are named `apm_lib`, not `apm_lib_ldinc`. The
  findings point at the repo files.
- `Lua.diagnostics.globals` / `Lua.diagnostics.disable` from `.vscode/settings.json` are applied, plus
  `lint.globals` / `lint.disable` from `build.config.json`.

### `data`: runs Factorio headless with the mods

The mods are symlinked from the read-only repo into a throwaway mod folder, with a generated `mod-list.json` and
default mod settings.

1. **Load test**: `factorio --create`. It loads all prototypes with every check the game does, and runs
   `on_init` of every `control.lua`.
2. **`factorio --dump-data`**. Then `datacheck.py` checks `data.raw`:

   | check | what it reports |
   |---|---|
   | `schema` | keys the game ignores (typos, 1.1 leftovers), per `prototype-api.json` |
   | `fuel` | `fuel_category` (removed in 2.1.20), a fuel value without `fuel_categories` |
   | `refs` | missing technologies, recipes, items, fluids, entities, fuel/crafting categories, `next_upgrade` |
   | `unlock` | disabled recipes that no technology unlocks |
   | `prod-loop` | productivity recipes that return an ingredient without `ignored_by_productivity` |
   | `sprites` | a sprite rectangle outside its PNG, or a missing file (repo files only) |
   | `locale` | prototypes without a name in `locale/en` |

Each profile is also run without the mods (a vanilla run, cached per Factorio version). Findings that vanilla
also has are dropped, so you only see what the mods add.

| profile | mods enabled |
|---|---|
| `base` | base only |
| `space-age` | Space Age and the other built-in DLC mods, plus the optional repo mods of the selected ones |

Selecting a mod (`./lint.ps1 data apm_nuclear`) limits what is **loaded** to that mod and its dependencies. It
does not limit what is reported, so findings from its dependencies show up too.

## The report

Open `lint-report\lint-report.md` in VS Code with *Markdown: Open Preview*. It contains:

- **Header:** run info (versions, profiles, duration) and a summary per mod and per check, with links to the
  sections.
- **Factorio load test:** the result per profile. When something fails, the full game error is shown.
- **Data checks:** one section per check, with an explanation and a fix hint. Each finding lists the prototype,
  the problem, the profiles, and *likely source* links to the Lua lines that define or mention the prototype.
- **LuaLS:**
  - diagnostic codes with their meaning;
  - per mod, the files sorted by number of findings;
  - per file, a table with the line (linked), code, message and the source line.

The links are relative to the report folder, so they work while the report stays in `lint-report\`.

## Limits

- The data check uses default mod settings. Settings-dependent code paths are only covered for the defaults.
- Factorio headless has no graphics, so the game itself does not check sprite sizes there. The `sprites` check
  reads the PNG sizes of the repo files instead; images from other mods are not checked.
- `schema` works from the published API JSON. A key that the docs miss but the game reads would be a false
  positive.
- Some LuaLS warnings come from the Factorio types, not from the code. The lint hides the known ones and prints
  how many it hid; `--show-type-noise` shows them:
  - table literals assigned to `LocalisedString` (`Cannot assign string to LocalisedString...|LuaGuiElement|...`);
  - runtime and prototype types that share a name (`Resistance`, `PipeConnectionDefinition`, `SmokeSource`,
    `AutoplaceControl`). The runtime type makes fields required that prototypes don't need.
