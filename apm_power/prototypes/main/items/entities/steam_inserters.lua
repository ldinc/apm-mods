require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/steam_inserters.lua'

local icon_path = "__apm_resource_pack_ldinc__/graphics/icons/"


APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_steam_inserter",
	icon = icon_path .. "apm_steam_inserter.png",
	stack_size = 50,
	subgroup = "apm_power_inserter",
	order = 'aa_a',
	place_result = "apm_steam_inserter",

	weight = apm.lib.utils.constants.value.weight.building.inserter,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_steam_inserter_long",
	icon = icon_path .. "apm_steam_inserter_long.png",
	stack_size = 50,
	subgroup = "apm_power_inserter",
	order = 'aa_a',
	place_result = "apm_steam_inserter_long",

	weight = apm.lib.utils.constants.value.weight.building.inserter,
}

data:extend({ item })
