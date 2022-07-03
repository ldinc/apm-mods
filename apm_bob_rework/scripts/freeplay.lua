local constants = require("scripts.constants")
local product   = require("lib.entities.product")
local science   = require("lib.entities.science")
local energy    = require("lib.entities.buildings.energy")
local miners    = require("lib.entities.buildings.miners")
local storages  = require("lib.entities.buildings.storages")

local freeplay = {}

-- function freeplay.add_bonus_items()
--   if settings.startup["kr-bonus-items"].value and remote.interfaces["freeplay"] then
--     local items = remote.call("freeplay", "get_created_items")
--     for _, item in pairs(constants.bonus_items) do
--       if game.item_prototypes[item.name] then
--         items[item.name] = item.count
--       end
--     end
--     remote.call("freeplay", "set_created_items", items)
--   end
-- end

function freeplay.add_starting_items()
  if remote.interfaces["freeplay"] then
    local items = remote.call("freeplay", "get_created_items")

    -- Shelter
    items[product.bearing.bronze] = 400
    items[science.industrial] = 120

    -- Electric poles
    items[energy.pole.small] = 30
    items[miners.burner.basic] = 30
    items[storages.chest.steel] = 30


    remote.call("freeplay", "set_created_items", items)
  end
end

function freeplay.add_to_crash_site()
  if
    remote.interfaces["freeplay"]
    and remote.interfaces["freeplay"].get_disable_crashsite
    and not remote.call("freeplay", "get_disable_crashsite")
    and not remote.call("freeplay", "get_init_ran")
  then
    local ship_parts = remote.call("freeplay", "get_ship_parts")
    for _, part in pairs(constants.freeplay_crash_site_parts) do
      ship_parts[#ship_parts + 1] = part
    end
    remote.call("freeplay", "set_ship_parts", ship_parts)
  end
end

-- function freeplay.disable_rocket_victory()
--   if remote.interfaces["silo_script"] then
--     remote.call("silo_script", "set_no_victory", true)
--   end
-- end

return freeplay
