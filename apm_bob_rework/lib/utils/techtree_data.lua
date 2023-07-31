local t = require "lib.entities.tech"
local data = {
    tiers = {}
}

local logistics = {
    gray = t.logistics.basic,
    yellow = t.logistics.yellow,
    red = t.logistics.red,
    blue = t.logistics.blue,
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
    logistics,
    t.ore.mining,
    t.energy.substation,
    t.logistics.inserters,
    t.fluid.pumpjack,
    t.energy.distribution,
    t.logistics.bots.frame,
    t.effect.transmitter,
    t.effect.heat.pipe,
    t.energy.steam.engine,
    t.energy.solar,
}

data.recalculate = {}
-- change cost for technology
data.recalculate.tech_cost = {
    ["long-inserters-1"] = {count = 10, time = 10},
    ["near-inserters-1"] = {count = 10, time = 10},
    ["more-inserters-1"] = {count = 10, time = 10},
}

return data