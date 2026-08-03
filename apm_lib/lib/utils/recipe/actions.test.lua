-- Standalone unit test for lib/utils/recipe/actions.lua (recipe category API)
-- Run from this directory: lua actions.test.lua (or run_tests.sh from the repository root)
apm = { lib = { utils = {} } }
data = { raw = {} }
log = function() end
APM_CAN_LOG_INFO = false APM_CAN_LOG_WARN = false
APM_MSG_INFO = function(...) return "" end APM_MSG_WARNING = function(...) return "" end

apm.lib.utils.recipe = { category = {}, energy_required = {}, overwrite = {} }
dofile("actions.lua")

local has = apm.lib.utils.recipe.category.has
local function expect(label, actual, wanted)
	if actual == wanted then print("PASS: " .. label)
	else print("FAIL: " .. label .. " got=" .. tostring(actual) .. " wanted=" .. tostring(wanted)) os.exit(1) end
end

expect("present", has({ categories = { "crafting", "chemistry" } }, "chemistry"), true)
expect("absent", has({ categories = { "crafting" } }, "chemistry"), false)
expect("no categories field", has({}, "chemistry"), false)

print("actions.test.lua: ALL TESTS PASSED")
