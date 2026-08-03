-- Standalone unit test for lib/utils/item.lua (science pack weight overwrite)
-- Run from this directory: lua item.test.lua (or run_tests.sh from the repository root)
local real_require = require
require = function(name)
	if name == "util" or name == "lib.log" then return {} end
	return real_require(name)
end

apm = { lib = { utils = { item = {} } } }
data = { raw = {
	item = { ["pack-a"] = { name = "pack-a" } },
	tool = { ["pack-b"] = { name = "pack-b" } },
	lab = { ["lab-1"] = { inputs = { "pack-a", "pack-b", "pack-missing" } } },
} }
log = function() end
APM_CAN_LOG_INFO = false APM_CAN_LOG_WARN = false
APM_MSG_INFO = function(...) return "" end APM_MSG_WARNING = function(...) return "" end
APM_LOG_HEADER = function(...) end

dofile("item.lua")

local function expect(label, actual, wanted)
	if actual == wanted then print("PASS: " .. label)
	else print("FAIL: " .. label .. " got=" .. tostring(actual) .. " wanted=" .. tostring(wanted)) os.exit(1) end
end

apm.lib.utils.item.mod.overwrite_weight_for_science_packs(7)
expect("item pack weighted", data.raw.item["pack-a"].weight, 7)
expect("tool pack weighted (tool fallback)", data.raw.tool["pack-b"].weight, 7)
expect("missing pack skipped", data.raw.item["pack-missing"], nil)

print("item.test.lua: ALL TESTS PASSED")
