-- Standalone unit test for lib/script/inserter.lua (fuel chaining, leeching, burnt results).
-- Run from the apm_lib folder: lua5.2 lib/script/inserter.test.lua
package.path = "./?.lua;" .. package.path

local real_require = require
require = function(name)
  if name == "lib.features" then return apm.lib.features end
  return real_require(name)
end

apm = { lib = { features = { stack_size = { ash = 100 }, runtime = {} } } }
storage = {}
defines = {
  entity_status = { working = 1, no_fuel = 2 },
  inventory = { chest = 1 },
}
remote = { add_interface = function() end }
commands = { add_command = function() end }
log = function() end

prototypes = {
  item = {
    ["coal"] = { name = "coal", fuel_categories = { "chemical" } },
    ["nutrients"] = { name = "nutrients", fuel_categories = { "nutrients" } },
    ["apm_generic_ash"] = { name = "apm_generic_ash" },
    ["iron-plate"] = { name = "iron-plate" },
  }
}

-- Inventory mock with quality. Methods are closures (called with a dot, like the game API).
local function Inventory(stacks)
  local slots = {}
  for i, s in ipairs(stacks or {}) do
    slots[i] = { name = s[1], quality = s[2] or "normal", count = s[3] }
  end

  local inv = {}
  local function q(def) return def.quality or "normal" end

  inv.remove = function(def)
    local want, removed = def.count or 1, 0
    for i = #slots, 1, -1 do
      local s = slots[i]
      if s.name == def.name and s.quality == q(def) and removed < want then
        local n = math.min(s.count, want - removed)
        s.count = s.count - n
        removed = removed + n
        if s.count == 0 then table.remove(slots, i) end
      end
    end
    return removed
  end
  inv.insert = function(def)
    for _, s in ipairs(slots) do
      if s.name == def.name and s.quality == q(def) then
        s.count = s.count + def.count
        return def.count
      end
    end
    table.insert(slots, { name = def.name, quality = q(def), count = def.count })
    return def.count
  end
  inv.get_contents = function()
    local out = {}
    for _, s in ipairs(slots) do out[#out + 1] = { name = s.name, quality = s.quality, count = s.count } end
    return out
  end
  inv.is_empty = function() return #slots == 0 end
  inv.is_full = function() return false end
  inv.get_item_count = function(name)
    local n = 0
    for _, s in ipairs(slots) do if not name or s.name == name then n = n + s.count end end
    return n
  end
  -- count of one name + quality, for the assertions
  inv.count_of = function(name, quality)
    for _, s in ipairs(slots) do if s.name == name and s.quality == quality then return s.count end end
    return 0
  end

  return setmetatable(inv, {
    __len = function() return math.max(#slots, 1) end,
    __index = function(_, i)
      local s = slots[i]
      if not s then return { valid_for_read = false } end
      return {
        valid_for_read = true,
        name = s.name,
        count = s.count,
        quality = { name = s.quality },
        prototype = prototypes.item[s.name],
      }
    end,
  })
end

local function HeldStack(name, quality, count)
  local h = { valid_for_read = name ~= nil, name = name, quality = quality, count = count }
  h.set_stack = function(def)
    h.valid_for_read, h.name, h.quality, h.count = true, def.name, def.quality or "normal", def.count
    return true
  end
  return h
end

local function Machine(fuel, burnt)
  local fuel_inv, burnt_inv = Inventory(fuel), Inventory(burnt)
  return {
    valid = true,
    type = "furnace",
    position = { x = 0, y = 0 },
    burner = { fuel_categories = { chemical = true }, burnt_result_inventory = burnt_inv },
    get_fuel_inventory = function() return fuel_inv end,
    get_burnt_result_inventory = function() return burnt_inv end,
    get_inventory = function() return fuel_inv end,
    can_insert = function() return true end,
    fuel_inv = fuel_inv,
    burnt_inv = burnt_inv,
  }
end

local force = { index = 1, inserter_stack_size_bonus = 2, bulk_inserter_capacity_bonus = 10 }

local function Inserter(own_fuel, status, pickup, drop, held)
  local fuel_inv = Inventory(own_fuel)
  return {
    valid = true,
    type = "inserter",
    unit_number = 1,
    force = force,
    status = status or defines.entity_status.working,
    pickup_position = { x = 0, y = 0 },
    held_stack_position = { x = 0, y = 0 },
    pickup_target = pickup,
    drop_target = drop,
    held_stack = held or HeldStack(),
    burner = { fuel_categories = { chemical = true } },
    get_fuel_inventory = function() return fuel_inv end,
    filter_slot_count = 0,
    inserter_filter_mode = "whitelist",
    get_filter = function() return nil end,
    inserter_stack_size_override = 0,
    prototype = { bulk = false },
    fuel_inv = fuel_inv,
  }
end

local inserter_script = dofile("lib/script/inserter.lua")
local dllist = real_require("lib.containers.dllist")

local function run(ins)
  storage = {}
  inserter_script.alloc_defenitions()
  local st = storage.inserters.settings
  st.fn_enabled, st.batch_size, st.valid_targets, st.ash_chaining = true, 1, { furnace = true }, false
  dllist.add(storage.inserters.queue, {
    id = 1, entity = ins, fuel_inventory = ins.get_fuel_inventory(), bulk = false, err = 0,
  })
  inserter_script.on_tick(100)
end

local function expect(label, actual, wanted)
  if actual == wanted then
    print("PASS: " .. label)
  else
    print("FAIL: " .. label .. "\n  got:    " .. tostring(actual) .. "\n  wanted: " .. tostring(wanted))
    os.exit(1)
  end
end

-- 1. fuel chaining keeps the quality (it used to put normal coal in the hand and remove nothing)
do
  local pickup, drop = Machine({ { "coal", "uncommon", 10 } }), Machine({})
  local ins = Inserter({ { "coal", "normal", 1 } }, nil, pickup, drop)
  run(ins)
  expect("chain: hand holds uncommon coal", ins.held_stack.quality, "uncommon")
  expect("chain: hand count = 1 + stack bonus", ins.held_stack.count, 3)
  expect("chain: taken from pickup", pickup.fuel_inv.count_of("coal", "uncommon"), 7)
  expect("chain: no normal coal created", pickup.fuel_inv.count_of("coal", "normal"), 0)
end

-- 2. no fuel: steals fuel of its own category, with its quality
do
  local pickup = Machine({ { "coal", "rare", 3 } })
  local ins = Inserter({}, defines.entity_status.no_fuel, pickup, nil)
  run(ins)
  expect("steal: rare coal in the inserter", ins.fuel_inv.count_of("coal", "rare"), 1)
  expect("steal: removed from pickup", pickup.fuel_inv.count_of("coal", "rare"), 2)
end

-- 3. no fuel: nutrients are not taken (wrong fuel category)
do
  local pickup = Machine({ { "nutrients", "normal", 10 } })
  local ins = Inserter({}, defines.entity_status.no_fuel, pickup, nil)
  run(ins)
  expect("leech: nutrients not in hand", ins.held_stack.valid_for_read, false)
  expect("leech: nutrients not in fuel", ins.fuel_inv.get_item_count(), 0)
  expect("leech: nutrients untouched", pickup.fuel_inv.count_of("nutrients", "normal"), 10)
end

-- 4. burnt results keep their quality
do
  local pickup, drop = Machine({ { "coal", "normal", 2 } }, { { "apm_generic_ash", "rare", 4 } }), Machine({})
  local ins = Inserter({ { "coal", "normal", 1 } }, nil, pickup, drop)
  run(ins)
  expect("burnt: rare ash in hand", ins.held_stack.quality, "rare")
  expect("burnt: 3 in hand", ins.held_stack.count, 3)
  expect("burnt: 1 left", pickup.burnt_inv.count_of("apm_generic_ash", "rare"), 1)
end

-- 5. a busy hand is left alone (no merge, no duplication)
do
  local pickup, drop = Machine({ { "coal", "normal", 2 } }, { { "apm_generic_ash", "normal", 4 } }), Machine({})
  local ins = Inserter({ { "coal", "normal", 1 } }, nil, pickup, drop, HeldStack("apm_generic_ash", "normal", 1))
  run(ins)
  expect("busy: hand unchanged", ins.held_stack.count, 1)
  expect("busy: burnt untouched", pickup.burnt_inv.count_of("apm_generic_ash", "normal"), 4)
end

-- 6. a quality-only filter (no item name) does not crash; blacklisted ash stays
do
  local pickup, drop = Machine({ { "coal", "normal", 2 } }, { { "apm_generic_ash", "normal", 4 } }), Machine({})
  local ins = Inserter({ { "coal", "normal", 1 } }, nil, pickup, drop)
  ins.filter_slot_count = 2
  ins.inserter_filter_mode = "blacklist"
  ins.get_filter = function(i)
    if i == 1 then return { quality = "rare", comparator = "=" } end
    return { name = "apm_generic_ash" }
  end
  run(ins)
  expect("filter: blacklisted ash not taken", pickup.burnt_inv.count_of("apm_generic_ash", "normal"), 4)
end

print("inserter.test.lua: ALL TESTS PASSED")
