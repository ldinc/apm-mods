local storages = require "lib.entities.buildings.storages"

local chest = data.raw.container[storages.chest.steel]
if chest then
    chest.next_upgrade = storages.chest.titanium
end

-- chest = data.raw.container['brass-chest']
-- if chest then
--     chest.next_upgrade = nil
-- end