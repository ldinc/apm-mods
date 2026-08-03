-- Standalone unit test for lib/features/runtime.lua
-- Run from this directory: lua runtime.test.lua (or run_tests.ps1 from the repository root)
apm = nil -- runtime.lua creates the namespace itself
log = function(...) table.insert(_G.__logs, (...)) end
APM_MSG_ERROR = function(...) return select(2, ...) end

dofile("runtime.lua")

local rt = apm.lib.features.runtime

local function expect(label, actual, wanted)
	if actual == wanted then print("PASS: " .. label)
	else print("FAIL: " .. label .. " got=" .. tostring(actual) .. " wanted=" .. tostring(wanted)) os.exit(1) end
end

_G.__logs = {}

-- registered setting with value false must be readable as false (not "not found")
rt.register("test_false_setting", function() return false end)
rt.register("test_true_setting", function() return true end)
rt.register("test_number_setting", function() return 1.5 end)
rt.update()

expect("false value returned", rt.get("test_false_setting"), false)
expect("true value returned", rt.get("test_true_setting"), true)
expect("get_boolean false", rt.get_boolean("test_false_setting"), false)
expect("get_double", rt.get_double("test_number_setting"), 1.5)
expect("no spurious errors logged", #__logs, 0)

-- genuinely missing key still reports an error
expect("missing key returns nil", tostring(rt.get("missing_key")), "nil")
expect("missing key logs error", #__logs, 1)
expect("missing key get_boolean default", rt.get_boolean("missing_key"), false)

print("runtime.test.lua: ALL TESTS PASSED")
