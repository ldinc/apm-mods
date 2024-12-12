require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/tiles.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_asphalt',
	icons = {
		{ icon = apm.power.icons.asphalt.filename, icon_size = apm.power.icons.asphalt.icon_size }
	},
	pictures = {
		apm.power.icons.asphalt,
		apm.power.icons.asphalt_1
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_ash",
	order = 'ae_a',
	place_as_tile = {
		result = "apm_asphalt",
		condition_size = 1,
		condition = { layers = { water_tile = true } }
	},

	weight = apm.lib.utils.constants.value.weight.product.asphalt,
}

if mods["space-age"] then
	item.place_as_tile.condition = { layers = { water_tile = true, meltable = true } }
end

data:extend({ item })
