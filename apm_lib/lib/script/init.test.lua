-- Standalone test for lib/script/init.lua + lib/local/initial.lua. Run from the apm_lib folder: lua5.2 lib/script/init.test.lua
package.path = "./?.lua;" .. package.path
package.preload["util"] = function() return {} end
package.preload["lib.log"] = function() return {} end
log = function() end
local function Tech(name) return { name = name, researched = false, enabled = true, prototype = { enabled = true, effects = {} }, reload = function() end } end
local techs = { ["apm_wood_liquefaction"] = Tech("apm_wood_liquefaction"), ["fluid-handling"] = Tech("fluid-handling") }
local force = {
	name = "player",
	technologies = techs,
	recipes = { apm_refining_wood_1 = { enabled = true } },
	reset_recipes = function() end,
	reset_technologies = function() end
}
game = { forces = { player = force }, surfaces = {} }
script = { active_mods = { apm_power_ldinc = "1", apm_lib_ldinc = "1" } }
storage = {} -- save that already had the mod: on_configuration_changed without on_init
local initial = require("lib.local.initial")
initial.run()
assert(storage.apm.lib.technologies.list["fluid-handling"], "list filled")
assert(techs.apm_wood_liquefaction.researched == true, "conditional recipe tech activated")
local n1 = #storage.apm.lib.technologies.conditional_recipes["apm_wood_liquefaction"]
initial.run(); initial.run()
local n2 = #storage.apm.lib.technologies.conditional_recipes["apm_wood_liquefaction"]
assert(n1 == n2, "no growth: " .. n1 .. " vs " .. n2)
print("init: OK (no crash on empty storage, lists stay at " .. n2 .. " recipes)")
