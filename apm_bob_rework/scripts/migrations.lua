local freeplay = require("scripts.freeplay")

local migrations = {}

function migrations.generic()
--   freeplay.add_bonus_items()
  freeplay.add_to_crash_site()
  freeplay.add_starting_items()
end

return migrations
