local iconPath = "__apm_bob_rework_ldinc__/graphics/icons/krastorio/entities/"

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = "kr-wind-turbine"
item.icon = "__apm_bob_rework_ldinc__/graphics/icons/krastorio/entities/wind-turbine.png"
item.icon_size = 64
item.icon_mipmaps = 4
item.subgroup = "energy"
item.order = "00[solar-panel]-a[wind-turbine]"
item.place_result = "kr-wind-turbine"
item.stack_size = 50
data:extend({item})