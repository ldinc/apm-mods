require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/science.lua'

APM_LOG_HEADER(self)

---@type data.ToolPrototype
local item = {
	type = 'tool',
	name = 'apm_industrial_science_pack',
	localised_description = { "item-description.science-pack" },
	icons = {
		apm.power.icons.sciencepack_1
	},
	stack_size = 200,
	subgroup = "apm_power_science",
	order = 'aa_a',
	durability = 1,
	durability_description_key = "description.science-pack-remaining-amount-key",
	durability_description_value = "description.science-pack-remaining-amount-value",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ToolPrototype
local item = {
	type = 'tool',
	name = 'apm_steam_science_pack',
	localised_description = { "item-description.science-pack" },
	icons = {
		apm.power.icons.sciencepack_2
	},
	stack_size = 200,
	subgroup = "apm_power_science",
	order = 'ab_a',
	durability = 1,
	durability_description_key = "description.science-pack-remaining-amount-key",
	durability_description_value = "description.science-pack-remaining-amount-value",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })
