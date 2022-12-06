-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = "kr-tesla-coil"
item.icon = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/krastorio/entities/tesla-coil.png"
item.icon_size = 64
item.subgroup = "energy-pipe-distribution"
item.order = "z-a[energy]-f2[tesla-coil]"
item.place_result = "kr-tesla-coil"
item.stack_size = 50
data:extend({item})