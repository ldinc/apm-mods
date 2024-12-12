require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/centrifuge.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_wet_mud',
	icons = {
		apm.power.icons.mud_wet
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_fluid",
	order = 'ad_b',

	weight = apm.lib.utils.constants.value.weight.product.mud.wet,
}

data:extend({ item })
