require('util')
require('lib.log')

local self = 'apm_lib/prototypes/signals.lua'

APM_LOG_HEADER(self)

---@type data.VirtualSignalPrototype
local signal = {
	type = "virtual-signal",
	name = "apm_radioactive",
	icons = {
		apm.lib.icons.signal.radioactive
	},
	icon_size = 32,
	subgroup = "apm_signals",
	order = "aa_a",
}

data:extend({ signal })

---@type data.VirtualSignalPrototype
local signal = {
	type = "virtual-signal",
	name = "apm_burnt_result",
	icons = {
		apm.lib.icons.signal.burnt_result
	},
	icon_size = 32,
	subgroup = "apm_signals",
	order = "ab_a",
}

data:extend({ signal })

---@type data.VirtualSignalPrototype
local signal = {
	type = "virtual-signal",
	name = "apm_info",
	icons = {
		apm.lib.icons.signal.info
	},
	icon_size = 32,
	subgroup = "apm_signals",
	order = "ac_a",
}

data:extend({ signal })

---@type data.VirtualSignalPrototype
local signal = {
	type = "virtual-signal",
	name = "apm_warning",
	icons = {
		apm.lib.icons.signal.warning
	},
	icon_size = 32,
	subgroup = "apm_signals",
	order = "ad_a",
}

data:extend({ signal })

---@type data.VirtualSignalPrototype
local signal = {
	type = "virtual-signal",
	name = "apm_bullet_point",
	icons = {
		apm.lib.icons.signal.bullet_point
	},
	icon_size = 32,
	subgroup = "apm_signals",
	order = "ae_a",
}

data:extend({ signal })

---@type data.VirtualSignalPrototype
local signal = {
	type = "virtual-signal",
	name = "apm_alert_equipment_burner",
	icons = {
		--apm.lib.icons.signal.radioactive
		{ icon = '__core__/graphics/icons/alerts/fuel-icon-red.png', icon_size = 64 }
	},
	icon_size = 64,
	subgroup = "apm_signals",
	order = "af_a",
}

data:extend({ signal })
