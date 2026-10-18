require("util")
require("lib.log")

local self = "apm_lib/prototypes/damage-types.lua"

APM_LOG_HEADER(self)

data:extend({
	{
		type = "damage-type",
		name = "apm_radiation",
	},
})
