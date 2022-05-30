-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = "energy-absorber"
item.icon = "__apm_bob_rework_ldinc__/graphics/icons/krastorio/equipments/energy-absorber.png"
item.icon_size = 64
item.icon_mipmaps = 4
item.subgroup = "equipment"
item.order = "a1[energy-source]-a1[energy-absorber]"
item.placed_as_equipment_result = "energy-absorber"
item.stack_size = 10
data:extend({item})