-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = "kr-antimatter-reactor"
item.icon = "__apm_bob_rework_ldinc__/graphics/icons/krastorio/entities/antimatter-reactor.png"
item.icon_size = 128
item.icon_mipmaps = 4
item.subgroup = "energy"
item.order = "z-h[antimatter-reactor]-c[antimatter-reactor]"
item.place_result = "kr-antimatter-reactor"
item.stack_size = 1
data:extend({item})