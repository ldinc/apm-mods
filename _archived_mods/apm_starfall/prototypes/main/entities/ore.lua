require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/entities/ore.lua'

APM_LOG_HEADER(self)

-- ----------------------------------------------------------------------------------------------------------------------
-- apm.lib.utils.starfall.add.ore(ore_name, t_tint, probability)
-- ----------------------------------------------------------------------------------------------------------------------
if mods.angelsrefining then
    apm.lib.utils.starfall.add.ore('angels-ore1', {r=0.62, g=0.0, b=0.1}, 0.45, nil)
    apm.lib.utils.starfall.add.ore('angels-ore2', {r=0.62, g=0.0, b=0.1}, 0.45, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('angels-ore3', {r=0.62, g=0.0, b=0.1}, 0.40, nil)
    apm.lib.utils.starfall.add.ore('angels-ore4', {r=0.62, g=0.0, b=0.1}, 0.40, 'sulfuric-acid')
    if mods.bobplates then
        apm.lib.utils.starfall.add.ore('angels-ore5', {r=0.62, g=0.0, b=0.1}, 0.35, 'sulfuric-acid')
        apm.lib.utils.starfall.add.ore('angels-ore6', {r=0.62, g=0.0, b=0.1}, 0.35, 'sulfuric-acid')
    end
elseif not mods.angelsrefining and mods.bobores and mods.bobplates then
    apm.lib.utils.starfall.add.ore('iron-ore', {r=0.62, g=0.0, b=0.1}, 0.45, nil)
    apm.lib.utils.starfall.add.ore('copper-ore', {r=0.62, g=0.0, b=0.1}, 0.45, nil)
    apm.lib.utils.starfall.add.ore('bauxite-ore', {r=0.62, g=0.0, b=0.1}, 0.40, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('cobalt-ore', {r=0.62, g=0.0, b=0.1}, 0.40, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('gem-ore', {r=0.62, g=0.0, b=0.1}, 0.25, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('gold-ore', {r=0.62, g=0.0, b=0.1}, 0.30, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('lead-ore', {r=0.62, g=0.0, b=0.1}, 0.45, nil)
    apm.lib.utils.starfall.add.ore('nickel-ore', {r=0.62, g=0.0, b=0.1}, 0.35, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('quartz', {r=0.62, g=0.0, b=0.1}, 0.75, nil)
    apm.lib.utils.starfall.add.ore('rutile-ore', {r=0.62, g=0.0, b=0.1}, 0.35, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('silver-ore', {r=0.62, g=0.0, b=0.1}, 0.35, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('tin-ore', {r=0.62, g=0.0, b=0.1}, 0.45, nil)
    apm.lib.utils.starfall.add.ore('tungsten-ore', {r=0.62, g=0.0, b=0.1}, 0.30, 'sulfuric-acid')
    apm.lib.utils.starfall.add.ore('zinc-ore', {r=0.62, g=0.0, b=0.1}, 0.35, 'sulfuric-acid')
    --apm.lib.utils.starfall.add.ore('thorium-ore', {r=0.62, g=0.0, b=0.1}, 0.35, 'sulfuric-acid')
else
    apm.lib.utils.starfall.add.ore('iron-ore', {r=0.62, g=0.0, b=0.1}, 0.45, nil)
    apm.lib.utils.starfall.add.ore('copper-ore', {r=0.62, g=0.0, b=0.1}, 0.45, nil)
end

-- ----------------------------------------------------------------------------------------------------------------------
apm.lib.utils.starfall.ore.generate()