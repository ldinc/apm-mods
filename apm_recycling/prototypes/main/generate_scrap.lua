require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/main/generate_scrap.lua'

APM_LOG_HEADER(self)

local apm_recycler_integration_bob = settings.startup["apm_recycler_integration_bob"].value
local apm_recycler_integration_angel = settings.startup["apm_recycler_integration_angel"].value
local apm_recycler_integration_earendel = settings.startup["apm_recycler_integration_earendel"].value
local apm_recycler_integration_kingarthur = settings.startup["apm_recycler_integration_kingarthur"].value
local apm_recycler_integration_sctm = settings.startup["apm_recycler_integration_sctm"].value

local apm_recycler_compat_bob = settings.startup["apm_recycler_compat_bob"].value
local apm_recycler_compat_angel = settings.startup["apm_recycler_compat_angel"].value
local apm_recycler_compat_earendel = settings.startup["apm_recycler_compat_earendel"].value
local apm_recycler_compat_kingarthur = settings.startup["apm_recycler_compat_kingarthur"].value
local apm_recycler_compat_sctm = settings.startup["apm_recycler_compat_sctm"].value

APM_LOG_SETTINGS(self, 'apm_recycler_integration_bob', apm_recycler_integration_bob)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_angel', apm_recycler_integration_angel)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_earendel', apm_recycler_integration_earendel)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_kingarthur', apm_recycler_integration_kingarthur)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_sctm', apm_recycler_integration_sctm)

APM_LOG_SETTINGS(self, 'apm_recycler_compat_bob', apm_recycler_compat_bob)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_angel', apm_recycler_compat_angel)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_earendel', apm_recycler_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_kingarthur', apm_recycler_compat_kingarthur)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_sctm', apm_recycler_compat_sctm)

-- ----------------------------------------------------------------------------
-- 
-- ----------------------------------------------------------------------------
apm.lib.utils.recycling.scrap.add({ recipe = 'copper-cable', metal = 'copper' })
apm.lib.utils.recycling.scrap.add({ recipe = 'iron-stick', metal = 'iron' })
apm.lib.utils.recycling.scrap.add({ recipe = 'iron-gear-wheel', metal = 'iron' })
apm.lib.utils.recycling.scrap.add({ recipe = 'electronic-circuit', metal = 'copper' })
apm.lib.utils.recycling.scrap.add({ recipe = 'battery', metal = 'iron' })
apm.lib.utils.recycling.scrap.add({ recipe = 'battery', metal = 'copper' })
apm.lib.utils.recycling.scrap.add({ recipe = 'empty-barrel', metal = 'steel' })

apm.lib.utils.recycling.scrap.add({ recipe = 'firearm-magazine', metal = 'iron' })
apm.lib.utils.recycling.scrap.add({ recipe = 'piercing-rounds-magazine', metal = 'copper' })
apm.lib.utils.recycling.scrap.add({ recipe = 'piercing-rounds-magazine', metal = 'steel' })
apm.lib.utils.recycling.scrap.add({ recipe = 'shotgun-shell', metal = 'iron' })
apm.lib.utils.recycling.scrap.add({ recipe = 'shotgun-shell', metal = 'copper' })

if not mods['aai-industry'] and apm_recycler_compat_earendel then
    apm.lib.utils.recycling.scrap.add({ recipe = 'electronic-circuit', metal = 'iron' })
end

if mods.bobplates and mods.bobores and mods.bobrevamp and apm_recycler_compat_bob then
    apm.lib.utils.recycling.scrap.add({ recipe = 'low-density-structure', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'low-density-structure', metal = 'titanium' })
else
    apm.lib.utils.recycling.scrap.add({ recipe = 'low-density-structure', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'low-density-structure', metal = 'steel' })
end

apm.lib.utils.recycling.scrap.add({ recipe = 'flying-robot-frame', metal = 'steel' })
apm.lib.utils.recycling.scrap.add({ recipe = 'engine-unit', metal = 'iron' })
apm.lib.utils.recycling.scrap.add({ recipe = 'engine-unit', metal = 'steel' })

-- Special none intermediates
apm.lib.utils.recycling.scrap.add({ recipe = 'pipe', metal = 'iron' })
apm.lib.utils.recycling.scrap.add({ recipe = 'pipe-to-ground', metal = 'iron' })

-- Earendel -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['aai-industry'] and apm_recycler_integration_earendel then
    apm.lib.utils.recycling.scrap.add({ recipe = 'motor', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'electronic-circuit-stone', metal = 'copper' })
end

if mods['space-exploration'] and apm_recycler_integration_earendel then
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-heat-shielding', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'rocket-control-unit', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-cargo-rocket-cargo-pod', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-space-platform-scaffold', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-space-platform-plating', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-material-testing-pack', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-material-testing-pack', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-canister', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-canister', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-space-mirror', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-data-storage-substrate', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-space-pipe', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'se-space-pipe', metal = 'copper' })
end

-- bob ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobplates and mods.bobores and apm_recycler_integration_bob then
    apm.lib.utils.recycling.scrap.add({ recipe = 'steel-gear-wheel', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'brass-gear-wheel', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'cobalt-steel-gear-wheel', metal = 'cobalt-steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'titanium-gear-wheel', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'tungsten-gear-wheel', metal = 'tungsten' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'nitinol-gear-wheel', metal = 'nitinol' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'steel-bearing-ball', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'brass-bearing-ball', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'cobalt-steel-bearing-ball', metal = 'cobalt-steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'titanium-bearing-ball', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'nitinol-bearing-ball', metal = 'nitinol' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'steel-bearing', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'brass-bearing', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'cobalt-steel-bearing', metal = 'cobalt-steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'titanium-bearing', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'nitinol-bearing', metal = 'nitinol' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'silver-zinc-battery', metal = 'zinc' })
    apm.lib.utils.recycling.scrap.remove({ recipe = 'battery' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'battery', metal = 'lead' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'grinding-wheel', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'polishing-wheel', metal = 'steel' })
end

if mods.bobplates and mods.bobores and mods.bobelectronics and apm_recycler_integration_bob then
    apm.lib.utils.recycling.scrap.add({ recipe = 'tinned-copper-cable', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'tinned-copper-cable', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'insulated-cable', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'gilded-copper-cable', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'gilded-copper-cable', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'basic-electronic-components', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'electronic-components', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'intergrated-electronics', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'processing-electronics', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'basic-circuit-board', metal = 'copper' })
    apm.lib.utils.recycling.scrap.remove({ recipe = 'electronic-circuit' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'circuit-board', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'circuit-board', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'superior-circuit-board', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'superior-circuit-board', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'multi-layer-circuit-board', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'multi-layer-circuit-board', metal = 'gold' })
end

if mods.bobplates and mods.bobores and mods.boblogistics and apm_recycler_integration_bob then
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-antenna-1', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-antenna-1', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-antenna-2', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-antenna-2', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-antenna-3', metal = 'nickel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-antenna-4', metal = 'nickel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-antenna-4', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-chargepad-1', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-chargepad-2', metal = 'invar' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-chargepad-3', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-chargepad-4', metal = 'nitinol' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-door-1', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-door-2', metal = 'invar' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-door-3', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'roboport-door-4', metal = 'nitinol' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'flying-robot-frame-2', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'flying-robot-frame-3', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-logistic', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-logistic-2', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-logistic-2', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-logistic-3', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-logistic-4', metal = 'nitinol' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-construction', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-construction-2', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-construction-2', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-construction-3', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-construction-4', metal = 'nitinol' })
    -- Special none intermediates
    apm.lib.utils.recycling.scrap.add({ recipe = 'copper-pipe', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'bronze-pipe', metal = 'bronze' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'steel-pipe', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'brass-pipe', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'titanium-pipe', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'tungsten-pipe', metal = 'tungsten' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'copper-pipe-to-ground', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'bronze-pipe-to-ground', metal = 'bronze' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'steel-pipe-to-ground', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'brass-pipe-to-ground', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'titanium-pipe-to-ground', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'tungsten-pipe-to-ground', metal = 'tungsten' })
end

if mods.bobplates and mods.bobores and mods.bobwarfare and apm_recycler_integration_bob then
    apm.lib.utils.recycling.scrap.add({ recipe = 'rocket-engine', metal = 'tungsten' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'rocket-body', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-combat', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-combat-2', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-combat-3', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-tool-combat-4', metal = 'nitinol' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-drone-frame', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'robot-drone-frame-large', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'ap-bullet-projectile', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'ap-bullet-projectile', metal = 'tungsten' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'acid-bullet-projectile', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'electric-bullet-projectile', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'electric-bullet-projectile', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'flame-bullet-projectile', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'he-bullet-projectile', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'poison-bullet-projectile', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'bullet-projectile', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'bullet-projectile', metal = 'lead' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'rocket-warhead', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'piercing-rocket-warhead', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'piercing-rocket-warhead', metal = 'tungsten' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'explosive-rocket-warhead', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'flame-rocket-warhead', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'poison-rocket-warhead', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'acid-rocket-warhead', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'electric-rocket-warhead', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'magazine', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'shot', metal = 'lead' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'bullet-casing', metal = 'gunmetal' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'shotgun-shell-casing', metal = 'gunmetal' })
end

-- angel ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.angelsrefining and apm_recycler_integration_angel then
    apm.lib.utils.recycling.scrap.add({ recipe = 'catalyst-metal-carrier', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'angels-electrode', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'filter-frame', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'filter-frame', metal = 'steel' })
end

-- kingarthur ------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.PyCoalTBaA and apm_recycler_integration_kingarthur then
    apm.lib.utils.recycling.scrap.add({ recipe = 'copper-coating', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'chemical-science-pack', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'empty-gas-canister', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'empty-gas-canister', metal = 'brass' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'drill-head', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'drill-head', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'nas-battery', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'nas-battery', metal = 'lead' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'lead-container', metal = 'lead' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'sc-wire', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'science-coating', metal = 'titanium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'wall-shield', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'inductor1', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'capacitor1', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'capacitor2', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'resistor1', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'electronic-circuit-initial', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'pcb1', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'valcea', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'valcea', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'bose-einstein-superfluid', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'laser-turret-deconstruction', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'laser-turret-deconstruction', metal = 'steel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'nanocrystaline-core', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'nanocrystaline-core', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'nano-wires', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'supercapacitor-shell', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'yag-laser-module', metal = 'aluminium' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'inductor3', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'tinned-cable', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'tinned-cable', metal = 'tin' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'resistor2', metal = 'nickel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'valvea', metal = 'copper' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'valvea', metal = 'iron' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'capacitor-termination', metal = 'nickel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'capacitor-termination', metal = 'silver' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'superconductor', metal = 'gold' })
    apm.lib.utils.recycling.scrap.add({ recipe = 're-magnet', metal = 'nickel' })
    apm.lib.utils.recycling.scrap.add({ recipe = 'paradiamatic-resistor', metal = 'lead' })
end