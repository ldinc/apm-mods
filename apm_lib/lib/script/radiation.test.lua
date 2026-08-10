-- Standalone unit test for lib/script/radiation.lua
-- Run from this directory: lua radiation.test.lua (or run_tests.sh from the repository root)
local real_require = require
require = function(name)
	if name == "lib.features" then
		apm.lib.features = {
			runtime = {
				update = function() end,
				get_boolean = function(n) return n ~= "apm_lib_radiation_dmg_based_on_stack" end,
				get_double = function() return 1.0 end,
			},
		}
		return apm.lib.features
	end
	if name == "lib.script.core" then
		return {
			get_valid_players = function() return _G.__players end,
			send_dmg_msg_to_player = function(player, msg) table.insert(_G.__msgs, msg) end,
		}
	end
	return real_require(name)
end

apm = { lib = {} }
storage = {}
game = { tick = 0, forces = { neutral = {} } }
remote = { add_interface = function(name, t) _G.__remote = t end }
prototypes = { item = {
	["uranium-235"] = true, ["uranium-fuel-cell"] = true, ["used-up-uranium-fuel-cell"] = true,
	["legacy-item"] = true, ["test-item"] = true,
} }
log = function() end
APM_CAN_LOG_INFO = false APM_CAN_LOG_WARN = false
APM_MSG_INFO = function(...) return "" end APM_MSG_WARNING = function(...) return "" end APM_MSG_ERROR = function(...) return "" end

local radiation = dofile("radiation.lua")

local function expect(label, actual, wanted)
	if actual == wanted then print("PASS: " .. label)
	else print("FAIL: " .. label .. "\n  got:    " .. tostring(actual) .. "\n  wanted: " .. tostring(wanted)) os.exit(1) end
end

-- migration from the legacy storage table on init
storage.items_radioactive_01774 = { ["legacy-item"] = 2, ["uranium-235"] = 2 }
radiation.on_init()
expect("legacy table migrated", storage.radiation.items["legacy-item"], 2)
expect("defaults seeded", storage.radiation.items["uranium-fuel-cell"], 2)
expect("old key removed", tostring(storage.items_radioactive_01774), "nil")
expect("version set", storage.radiation.version, 1)
expect("based_on_stack default false", storage.radiation.radiation_dmg_based_on_stack, false)

-- remote interface + prototype existence gate
expect("add existing", _G.__remote.add_item("test-item", 3), true)
expect("add missing", _G.__remote.add_item("nope-item", 1), false)
expect("missing not in list", tostring(_G.__remote.list_items()["nope-item"]), "nil")

-- damage tick, non-stack mode: only the highest level item damages
local sounds, dmgs = {}, {}
_G.__msgs = {}
local character = {
	valid = true,
	position = { 0, 0 },
	get_main_inventory = function() return {} end,
	get_item_count = function(filter) return ({ ["test-item"] = 5, ["uranium-235"] = 10 })[filter.name] or 0 end,
	damage = function(dmg, force) table.insert(dmgs, { dmg = dmg, force = force }) end,
	surface = { play_sound = function(spec) table.insert(sounds, spec) end },
}
_G.__players = { { player = { print = function() end }, character = character } }

game.tick = 277 -- 277 % 240 == 37
radiation.on_tick()
expect("one damage in non-stack mode", #dmgs, 1)
expect("damage is neutral force", dmgs[1].force, game.forces.neutral)
expect("sound played once", #sounds, 1)
expect("level 3 sound prototype prefix", sounds[1].path:sub(1, 14), "radioactive_c_")
expect("variant is a digit", tostring(tonumber(sounds[1].path:sub(-1)) ~= nil), "true")
expect("no raw file path", tostring(sounds[1].path:find(".ogg", 1, true)), "nil")
expect("damage message sent", #_G.__msgs, 1)

-- stack mode: every radioactive item damages
storage.radiation.radiation_dmg_based_on_stack = true
dmgs, sounds = {}, {}
radiation.on_tick()
expect("two damages in stack mode", #dmgs, 2)

-- on_update is idempotent
local count_before = 0
for _ in pairs(storage.radiation.items) do count_before = count_before + 1 end
radiation.on_update()
local count_after = 0
for _ in pairs(storage.radiation.items) do count_after = count_after + 1 end
expect("on_update keeps version", storage.radiation.version, 1)
expect("on_update keeps items", count_after, count_before)

-- remove_item invalidates the cache
expect("remove", _G.__remote.remove_item("test-item"), true)
expect("removed from list", tostring(_G.__remote.list_items()["test-item"]), "nil")

-- added-mod-to-save scenario: a remote call may arrive before on_init ran
-- (added mod's on_init runs before on_configuration_changed of loaded mods)
storage = {}
expect("add before init works", _G.__remote.add_item("test-item", 3), true)
expect("storage created lazily", storage.radiation.items["test-item"], 3)
expect("version set lazily", storage.radiation.version, 1)
expect("list_items before init", _G.__remote.list_items()["test-item"], 3)
expect("remove before init", _G.__remote.remove_item("test-item"), true)

print("radiation.test.lua: ALL TESTS PASSED")
