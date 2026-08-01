require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/science_pack_order.lua"

APM_LOG_HEADER(self)

-- Science pack order -----------------------------------------------------------
--
-- Default order map for [apm.lib.utils.technology.overwrite.science_pack_order_strings].
-- The map itself lives in apm_lib (apm.lib.utils.technology.science_pack_order)
-- and can be adjusted by other mods, e.g. overhaul mods that replace the vanilla
-- science packs can drop them via [apm.lib.utils.technology.remove.science_pack_order].
-- ------------------------------------------------------------------------------

---@type table<string, string>
local order = {
	["apm_industrial_science_pack"] = "a[apm_industrial_science_pack]",
	["apm_steam_science_pack"] = "b[apm_steam_science_pack]",
	["automation-science-pack"] = "c[automation-science-pack]",
	["logistic-science-pack"] = "d[logistic-science-pack]",
	["military-science-pack"] = "e[military-science-pack]",
	["chemical-science-pack"] = "f[chemical-science-pack]",
	["production-science-pack"] = "g[production-science-pack]",
	["utility-science-pack"] = "h[utility-science-pack]",
	["space-science-pack"] = "i[space-science-pack]",
}

if mods["space-age"] then
	order["electromagnetic-science-pack"] = "j[electromagnetic-science-pack]"
	order["metallurgic-science-pack"] = "k[metallurgic-science-pack]"
	order["agricultural-science-pack"] = "l[agricultural-science-pack]"
	order["cryogenic-science-pack"] = "m[cryogenic-science-pack]"
	order["promethium-science-pack"] = "n[promethium-science-pack]"
end

apm.lib.utils.technology.set.science_pack_orders(order)
