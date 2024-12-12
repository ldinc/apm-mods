require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/sifting.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_dry_mud',
	icons = {
		apm.power.icons.mud_dry
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_sifting",
	order = 'aa_a',

	weight = apm.lib.utils.constants.value.weight.product.mud.dry,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_sieve_iron',
	icons = {
		apm.power.icons.sieve_iron,
		apm.power.icons.sieve_handel
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_sifting",
	order = 'ab_a',

	weight = apm.lib.utils.constants.value.weight.product.sieve,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_sieve_copper',
	icons = {
		apm.power.icons.sieve_copper,
		apm.power.icons.sieve_handel
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_sifting",
	order = 'ab_b',

	weight = apm.lib.utils.constants.value.weight.product.sieve,
}

data:extend({ item })
