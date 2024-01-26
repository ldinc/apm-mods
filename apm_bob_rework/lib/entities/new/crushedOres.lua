local ores = require "lib.entities.ores"
local icons= require "lib.icons"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

-- TODO: remove (use ores.lua)
apm.bob_rework.lib.entities.ore = {}

apm.bob_rework.lib.entities.ore.copper = 'copper-ore'
apm.bob_rework.lib.entities.ore.iron = 'iron-ore'
apm.bob_rework.lib.entities.ore.aluminium = 'bauxite-ore'
apm.bob_rework.lib.entities.ore.zinc = 'zinc-ore'
apm.bob_rework.lib.entities.ore.lead = 'lead-ore'
apm.bob_rework.lib.entities.ore.gold = 'gold-ore'
apm.bob_rework.lib.entities.ore.cobalt = 'cobalt-ore'
apm.bob_rework.lib.entities.ore.titanium = 'rutile-ore'
apm.bob_rework.lib.entities.ore.silver = 'silver-ore'
apm.bob_rework.lib.entities.ore.tin = 'tin-ore'
apm.bob_rework.lib.entities.ore.nickel = 'nickel-ore'
apm.bob_rework.lib.entities.ore.tungsten = 'tungsten-ore'
--#endregion

local crushed = function(ore)
    return 'crushed-' .. ore
end

local crushedAdvanced = function(ore)
    return 'advanced-crushed-' .. ore
end

apm.bob_rework.lib.entities.crushed = {}
apm.bob_rework.lib.entities.crushed.ore = {}
apm.bob_rework.lib.entities.crushed.ore.advanced = {}

-- common tier
apm.bob_rework.lib.entities.crushed.ore.copper = crushed(ores.copper)
apm.bob_rework.lib.entities.crushed.ore.iron = crushed(ores.iron)
apm.bob_rework.lib.entities.crushed.ore.aluminium = crushed(ores.aluminium)
apm.bob_rework.lib.entities.crushed.ore.zinc = crushed(ores.zinc)
apm.bob_rework.lib.entities.crushed.ore.lead = crushed(ores.lead)
apm.bob_rework.lib.entities.crushed.ore.gold = crushed(ores.gold)
apm.bob_rework.lib.entities.crushed.ore.cobalt = crushed(ores.cobalt)
apm.bob_rework.lib.entities.crushed.ore.titanium = crushed(ores.titanium)
apm.bob_rework.lib.entities.crushed.ore.silver = crushed(ores.silver)
apm.bob_rework.lib.entities.crushed.ore.tin = crushed(ores.tin)
apm.bob_rework.lib.entities.crushed.ore.nickel = crushed(ores.nickel)
apm.bob_rework.lib.entities.crushed.ore.tungsten = crushed(ores.tungsten)

-- recipe settings for generate functions
local recipeSetting = {
    amountOfOre = 40,
    amountOfWater = 40,
    amountOfResult = 80,
    amountOfDirtWater = 20,
    energyRequired = 6,
    k = 10,
}

apm.bob_rework.lib.entities.crushed.ore.generate = {}

apm.bob_rework.lib.entities.crushed.ore.generate.crushedFrom = function(ore, tint)

    local crushedName = crushed(ore)

    local ico = {
        icon = icons.path.ore.crushed,
        icon_size = 64,
        tint = tint,
    }
    local tier = {
        icon = icons.path.tier.I,
        icon_size = 64,
    }
    -- generate item
    local item = {}
    item.type = 'item'
    item.name = crushedName
    item.icons = { ico }
    item.stack_size = 200
    item.group = "apm_power"
    item.order = 'ab_i'
    data:extend({ item })

    -- generate recipe
    local recipe = {}
    recipe.type = "recipe"
    recipe.name = crushedName
    recipe.subgroup  = 'bob-resource'
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = false
    recipe.normal.hide_from_player_crafting = true
    recipe.normal.energy_required = recipeSetting.energyRequired
    recipe.normal.ingredients = {
        { type = "item", name = ore, amount = recipeSetting.amountOfOre },
    }
    recipe.normal.results = {
        { type = 'item', name = crushedName, amount = recipeSetting.amountOfResult }
    }
    recipe.normal.main_product = crushedName
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        { type = "item", name = ore, amount = recipeSetting.amountOfOre + 2 },
    }
    recipe.allow_decomposition = true
    data:extend({ recipe })
end


apm.bob_rework.lib.entities.crushed.ore.generate.advancedCrushedFrom = function(ore, tint)
    local ico = {
        icon = icons.path.ore.crushed,
        icon_size = 64,
        tint = tint,
    }
    local tier = {
        icon = icons.path.tier.II,
        icon_size = 64,
    }

    local target = crushed(ore)
    local recipeName = crushedAdvanced(ore)

    -- recipe
    local recipe = {}
    recipe.type = "recipe"
    recipe.name = recipeName
    recipe.category = "apm_crusher_2"
    recipe.subgroup  = 'bob-resource'
    recipe.icons = { ico, tier }
    recipe.normal = {}
    recipe.normal.enabled = false
    recipe.normal.hide_from_player_crafting = true
    recipe.normal.energy_required = recipeSetting.energyRequired
    recipe.normal.ingredients = {
        { type = "item", name = ore, amount = recipeSetting.amountOfOre },
        { type = "fluid", name = 'water', amount = recipeSetting.amountOfWater },
    }
    recipe.normal.results = {
        { type = 'item', name = target, amount = recipeSetting.amountOfResult },
        { type = 'item', name = target, amount_min = 1*recipeSetting.k, amount_max = 2*recipeSetting.k, probability = 0.5 },
        { type = 'fluid', name = 'apm_dirt_water', amount = recipeSetting.amountOfDirtWater },
    }
    recipe.normal.main_product = target
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        { type = "item", name = ore, amount = recipeSetting.amountOfOre + 2 },
        { type = "fluid", name = 'water', amount = recipeSetting.amountOfWater + 10 },
    }
    recipe.allow_decomposition = true
    data:extend({ recipe })
end

local gen = function(ore, tint)
    apm.bob_rework.lib.entities.crushed.ore.generate.crushedFrom(ore, tint)
    apm.bob_rework.lib.entities.crushed.ore.generate.advancedCrushedFrom(ore, tint)
end

-- generates crushed ores
local tint = { r = 192 / 255, g = 90 / 255, b = 55 / 255 }
local ore = apm.bob_rework.lib.entities.ore.copper
gen(ore, tint)

local tint = { r = 125 / 255, g = 147 / 255, b = 155 / 255 }
local ore = apm.bob_rework.lib.entities.ore.iron
gen(ore, tint)

local tint = { r = 140 / 255, g = 126 / 255, b = 59 / 255 }
local ore = apm.bob_rework.lib.entities.ore.aluminium
gen(ore, tint)

local tint = { r = 48 / 255, g = 126 / 255, b = 112 / 255 }
local ore = apm.bob_rework.lib.entities.ore.zinc
gen(ore, tint)

local tint = { r = 54 / 255, g = 54 / 255, b = 53 / 255 }
local ore = apm.bob_rework.lib.entities.ore.lead
gen(ore, tint)

local tint = { r = 182 / 255, g = 137 / 255, b = 0 / 255 }
local ore = apm.bob_rework.lib.entities.ore.gold
gen(ore, tint)

local tint = { r = 47 / 255, g = 84 / 255, b = 122 / 255 }
local ore = apm.bob_rework.lib.entities.ore.cobalt
gen(ore, tint)

local tint = { r = 97 / 255, g = 66 / 255, b = 83 / 255 }
local ore = apm.bob_rework.lib.entities.ore.titanium
gen(ore, tint)

local tint = { r = 193 / 255, g = 215 / 255, b = 218 / 255 }
local ore = apm.bob_rework.lib.entities.ore.silver
gen(ore, tint)

local tint = { r = 115 / 255, g = 115 / 255, b = 113 / 255 }
local ore = apm.bob_rework.lib.entities.ore.tin
gen(ore, tint)

local tint = { r = 102 / 255, g = 150 / 255, b = 139 / 255 }
local ore = apm.bob_rework.lib.entities.ore.nickel
gen(ore, tint)

local tint = { r = 150 / 255, g = 101 / 255, b = 59 / 255 }
local ore = apm.bob_rework.lib.entities.ore.tungsten
gen(ore, tint)