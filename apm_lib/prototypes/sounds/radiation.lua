require("util")
require("lib.log")

local self = "apm_lib/prototypes/sounds/radiation.lua"

APM_LOG_HEADER(self)

---@type SoundPrototype[]
local sounds = {}

for _, level in ipairs({ "a", "b", "c" }) do
	for i = 1, 3 do
		local name = "radioactive_" .. level .. "_" .. tostring(i)

		table.insert(sounds, {
			type = "sound",
			name = name,
			filename = "__apm_lib_ldinc__/sounds/radiation/" .. name .. ".ogg",
			volume = 0.9,
		})
	end
end

data:extend(sounds)
