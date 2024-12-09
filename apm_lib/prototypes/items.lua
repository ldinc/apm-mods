require('util')
require('lib.log')

local self = 'apm_lib/prototypes/items.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_dummy',
	hidden = true,
	icons = { apm.lib.icons.dummy },
	stack_size = 2000,
	subgroup = "other",
	order = 'aa_a',
}

data:extend({ item })

---@type data.ItemPrototype
local item         = {
	type          = 'item',
	name          = 'apm_hidden_fuel',
	hidden        = true,
	flags         = { 'hide-from-fuel-tooltip', 'hide-from-bonus-gui' },
	icons         = { apm.lib.icons.dummy },
	stack_size    = 2000,
	subgroup      = "other",
	order         = 'aa_b',
	fuel_category = 'chemical',
	fuel_value    = "1GJ"
}

data:extend({ item })
