-- Standalone unit test for lib/utils/technology/science.lua (science pack order API)
-- Run from this directory: lua science.test.lua (or run_tests.sh from the repository root)
apm = { lib = { utils = {} } }
data = { raw = { technology = {}, item = {}, lab = {} } }
log = function() end
APM_CAN_LOG_INFO = false APM_CAN_LOG_WARN = false
APM_MSG_INFO = function(...) return "" end APM_MSG_WARNING = function(...) return "" end

apm.lib.utils.technology = { force = {}, set = {}, overwrite = {} }
apm.lib.utils.technology.get = { by_name = function(name)
	local t = data.raw.technology[name]
	if t then return t, true end
	return nil, false
end }

dofile("science.lua")

local M = apm.lib.utils.technology
local function expect(label, actual, wanted)
	if actual == wanted then print("PASS: " .. label)
	else print("FAIL: " .. label .. "\n  got:    " .. tostring(actual) .. "\n  wanted: " .. tostring(wanted)) os.exit(1) end
end

-- default tiers
expect("default tier nuclear", M.science_pack_order["apm_nuclear_science_pack"], 90)
expect("default tier space", M.science_pack_order["space-science-pack"], 100)

-- set single + bulk
M.set.science_pack_order("pack-x", 45)
M.set.science_pack_orders({ ["pack-y"] = 46 })
expect("set", M.science_pack_order["pack-x"], 45)
expect("bulk", M.science_pack_order["pack-y"], 46)

-- set_after
M.set.science_pack_order_after("pack-z", "logistic-science-pack")
expect("set_after = target+1", M.science_pack_order["pack-z"], 41)
M.set.science_pack_order_after("pack-noop", "missing-pack")
expect("set_after missing target is no-op", tostring(M.science_pack_order["pack-noop"]), "nil")

-- remove single + bulk
M.remove.science_pack_order("pack-y")
M.remove.science_pack_orders({ "pack-x" })
expect("remove single", tostring(M.science_pack_order["pack-y"]), "nil")
expect("remove bulk", tostring(M.science_pack_order["pack-x"]), "nil")

-- overwrite order strings (int + fractional tiers) and subgroup normalization
data.raw.item["automation-science-pack"] = { name = "automation-science-pack", order = "a", subgroup = "science-pack" }
data.raw.item["apm_steam_science_pack"] = { name = "apm_steam_science_pack", order = "ab_a", subgroup = "apm_power_science" }
M.set.science_pack_order("frac-pack", 45.5)
data.raw.item["frac-pack"] = { name = "frac-pack", order = "z" }
M.overwrite.science_pack_order_strings("science-pack")
expect("int tier format", data.raw.item["automation-science-pack"].order, "030[automation-science-pack]")
expect("fractional tier format", data.raw.item["frac-pack"].order, "0045.5000[frac-pack]")
expect("subgroup normalized", data.raw.item["apm_steam_science_pack"].subgroup, "science-pack")
expect("sparse tool table ok", tostring(data.raw.tool), "nil")

-- lab inputs sort: tiers, unmapped packs stable at the end
data.raw.lab["lab"] = { inputs = {
	"space-science-pack", "unmapped-b", "apm_nuclear_science_pack", "pack-z",
	"unmapped-a", "apm_industrial_science_pack", "automation-science-pack",
} }
M.overwrite.lab_science_pack_order()
expect(
	"lab sorted by tier",
	table.concat(data.raw.lab["lab"].inputs, ", "),
	"apm_industrial_science_pack, automation-science-pack, pack-z, apm_nuclear_science_pack, space-science-pack, unmapped-b, unmapped-a"
)

print("science.test.lua: ALL TESTS PASSED")
