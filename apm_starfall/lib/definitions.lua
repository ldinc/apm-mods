require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/lib/definitions.lua'

APM_LOG_HEADER(self)

if apm.starfall.color == nil then apm.starfall.color = {} end
if apm.starfall.icons == nil then apm.starfall.icons = {} end
if apm.starfall.icons.path == nil then apm.starfall.icons.path = {} end

-- Colors ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
apm.starfall.color.alien_fuel_mixture = {r=0.65, g=0.30, b=0.95}
apm.starfall.color.catalyst_iron = {r=0.669,g=0.744,b=0.819}
apm.starfall.color.catalyst_copper = {r=0.864,g=0.526,b=0.454}

-- Icon path ------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
apm.starfall.icons.path.ore_crushed = "__apm_resource_pack_ldinc__/graphics/icons/apm_meteorite_crushed.png"
apm.starfall.icons.path.meteorite_ore = "__apm_resource_pack_ldinc__/graphics/icons/mip/apm_meteorite_ore.png"
apm.starfall.icons.path.meteorite_ore_1 = "__apm_resource_pack_ldinc__/graphics/icons/mip/apm_meteorite_ore_1.png"
apm.starfall.icons.path.meteorite_ore_2 = "__apm_resource_pack_ldinc__/graphics/icons/mip/apm_meteorite_ore_2.png"
apm.starfall.icons.path.meteorite_ore_3 = "__apm_resource_pack_ldinc__/graphics/icons/mip/apm_meteorite_ore_3.png"
apm.starfall.icons.path.slag = "__apm_resource_pack_ldinc__/graphics/icons/mip/apm_slag.png"
apm.starfall.icons.path.slag_1 = "__apm_resource_pack_ldinc__/graphics/icons/mip/apm_slag_1.png"
apm.starfall.icons.path.slag_2 = "__apm_resource_pack_ldinc__/graphics/icons/mip/apm_slag_2.png"
apm.starfall.icons.path.slag_3 = "__apm_resource_pack_ldinc__/graphics/icons/mip/apm_slag_3.png"
apm.starfall.icons.path.metal_catalyst_frame = "__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_metal_catalyst_frame.png"
apm.starfall.icons.path.metal_catalyst_frame_used = "__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_metal_catalyst_frame_used.png"
apm.starfall.icons.path.metal_catalyst = "__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_metal_catalyst.png"
apm.starfall.icons.path.target_marker = "__apm_resource_pack_ldinc__/graphics/icons/apm_starfall_target_marker.png"
apm.starfall.icons.path.alien_fuel_case = "__apm_resource_pack_ldinc__/graphics/icons/apm_alien_fuel_case.png"
apm.starfall.icons.path.alien_fuel = "__apm_resource_pack_ldinc__/graphics/icons/apm_alien_fuel.png"
apm.starfall.icons.path.alien_fuel_burnted = "__apm_resource_pack_ldinc__/graphics/icons/apm_alien_fuel_burnted.png"

-- Icons ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
apm.starfall.icons.target_marker = {icon=apm.starfall.icons.path.target_marker, icon_size=64}
apm.starfall.icons.meteorite_ore = {size=64, icon=apm.starfall.icons.path.meteorite_ore, filename=apm.starfall.icons.path.meteorite_ore, scale=0.25, icon_mipmaps=4, icon_size=64}
apm.starfall.icons.meteorite_ore_1 = {size=64, icon=apm.starfall.icons.path.meteorite_ore_1, filename=apm.starfall.icons.path.meteorite_ore_1, scale=0.25, icon_mipmaps=4, icon_size=64}
apm.starfall.icons.meteorite_ore_2 = {size=64, icon=apm.starfall.icons.path.meteorite_ore_2, filename=apm.starfall.icons.path.meteorite_ore_2, scale=0.25, icon_mipmaps=4, icon_size=64}
apm.starfall.icons.meteorite_ore_3 = {size=64, icon=apm.starfall.icons.path.meteorite_ore_3, filename=apm.starfall.icons.path.meteorite_ore_3, scale=0.25, icon_mipmaps=4, icon_size=64}
apm.starfall.icons.ore_crushed = {icon=apm.starfall.icons.path.ore_crushed, icon_size=64}
apm.starfall.icons.slag = {size=64, icon=apm.starfall.icons.path.slag, filename=apm.starfall.icons.path.slag, scale=0.25, icon_mipmaps=4, icon_size=64}
apm.starfall.icons.slag_1 = {size=64, icon=apm.starfall.icons.path.slag_1, filename=apm.starfall.icons.path.slag_1, scale=0.25, icon_mipmaps=4, icon_size=64}
apm.starfall.icons.slag_2 = {size=64, icon=apm.starfall.icons.path.slag_2, filename=apm.starfall.icons.path.slag_2, scale=0.25, icon_mipmaps=4, icon_size=64}
apm.starfall.icons.slag_3 = {size=64, icon=apm.starfall.icons.path.slag_3, filename=apm.starfall.icons.path.slag_3, scale=0.25, icon_mipmaps=4, icon_size=64}
apm.starfall.icons.metal_catalyst_frame = {icon=apm.starfall.icons.path.metal_catalyst_frame, icon_size=64}
apm.starfall.icons.metal_catalyst_frame_used = {icon=apm.starfall.icons.path.metal_catalyst_frame_used, icon_size=64}
apm.starfall.icons.metal_catalyst_copper = {icon=apm.starfall.icons.path.metal_catalyst, icon_size=64, tint=apm.starfall.color.catalyst_copper}
apm.starfall.icons.metal_catalyst_iron= {icon=apm.starfall.icons.path.metal_catalyst, icon_size=64, tint=apm.starfall.color.catalyst_iron}
apm.starfall.icons.alien_fuel_mixture = {icon=apm.lib.icons.path.dust, icon_size=64, tint=apm.starfall.color.alien_fuel_mixture}
apm.starfall.icons.alien_fuel_case = {icon=apm.starfall.icons.path.alien_fuel_case, icon_size=64}
apm.starfall.icons.alien_fuel = {icon=apm.starfall.icons.path.alien_fuel, icon_size=64}
apm.starfall.icons.alien_fuel_burnted = {icon=apm.starfall.icons.path.alien_fuel_burnted, icon_size=64}
