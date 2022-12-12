local t = require "lib.entities.tech"
local data = {
    tiers = {}
}

data.tiers = {
    t.processing.coke,
    t.crusher,
    t.press,
    t.materials.asphalt,
    t.sieve,
    t.ore.enrichment,
    t.processing.oil,
    t.logistics.rail,
    t.processing.planks,
    t.battery,
}

return data