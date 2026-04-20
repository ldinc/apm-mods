local icons = require "lib.icons"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

apm.bob_rework.lib.entities.enriched = {}
apm.bob_rework.lib.entities.enriched.ore = {}

local crushed = function(ore)
    return 'crushed-' .. ore
end

local enriched = function(ore)
    return 'enriched-' .. ore
end

local enrichedAdvanced = function(ore)
    return 'advanced-enriched-' .. ore
end

apm.bob_rework.lib.entities.enriched.ore.copper = enriched(apm.bob_rework.lib.entities.ore.copper)
apm.bob_rework.lib.entities.enriched.ore.iron = enriched(apm.bob_rework.lib.entities.ore.iron)
apm.bob_rework.lib.entities.enriched.ore.aluminium = enriched(apm.bob_rework.lib.entities.ore.aluminium)
apm.bob_rework.lib.entities.enriched.ore.zinc = enriched(apm.bob_rework.lib.entities.ore.zinc)
apm.bob_rework.lib.entities.enriched.ore.lead = enriched(apm.bob_rework.lib.entities.ore.lead)
apm.bob_rework.lib.entities.enriched.ore.gold = enriched(apm.bob_rework.lib.entities.ore.gold)
apm.bob_rework.lib.entities.enriched.ore.cobalt = enriched(apm.bob_rework.lib.entities.ore.cobalt)
apm.bob_rework.lib.entities.enriched.ore.titanium = enriched(apm.bob_rework.lib.entities.ore.titanium)
apm.bob_rework.lib.entities.enriched.ore.silver = enriched(apm.bob_rework.lib.entities.ore.silver)
apm.bob_rework.lib.entities.enriched.ore.tin = enriched(apm.bob_rework.lib.entities.ore.tin)
apm.bob_rework.lib.entities.enriched.ore.nickel = enriched(apm.bob_rework.lib.entities.ore.nickel)
apm.bob_rework.lib.entities.enriched.ore.tungsten = enriched(apm.bob_rework.lib.entities.ore.tungsten)

local settings = {
    energyRequired = 10,
    floatationEnergyRequired = 4.5,
    crushedOreAmount = 40,
    enrichedResultAmount = {
        sieve = 25,
        floatation = 15,
    },
    min = 5,
    max = 15,
    k = 10,
    dryMudAmout = 20,
    sieveAmount = 1,
    sieveEnergyRequired = 10,
    sieveProbability = 0.95,
    airAmount = 120,
    waterAmount = 40,
    dirtWaterAmount = 40,
    sulphuricAcidAmount = 20,
    lubricantAmount = 20,
}

local generateCommonEnriched = function(ore, tint)
    local ico = {
        icon = icons.path.ore.enriched,
        icon_size = 64,
        tint = tint,
    }

    local tier = {
        icon = icons.path.tier.I,
        icon_size = 64,
    }
    local target = enriched(ore)
    local crushedName = crushed(ore)
    -- item
    local item = {}
    item.type = 'item'
    item.name = target
    item.icons = { ico }
    item.stack_size = 200
    item.group = "apm_power"
    item.order = 'ab_i'
    data:extend({ item })

    -- recipe
    local recipe                             = {}
    recipe.type                              = "recipe"
    recipe.name                              = target
    recipe.category                          = "apm_sifting_0"
    recipe.icons                             = { ico, tier }
    recipe.subgroup                          = 'bob-resource'
    recipe.normal                            = {}
    recipe.normal.enabled                    = false
    recipe.normal.hide_from_player_crafting  = true
    recipe.normal.energy_required            = settings.sieveEnergyRequired
    recipe.normal.ingredients                = {
        { type = "item", name = crushedName,      amount = settings.crushedOreAmount },
        { type = "item", name = 'apm_sieve_iron', amount = settings.sieveAmount },
    }
    recipe.normal.results                    = {
        { type = 'item', name = target,           amount = settings.enrichedResultAmount.sieve },
        { type = 'item', name = 'apm_dry_mud',    amount = settings.dryMudAmout },
        { type = "item", name = 'apm_sieve_iron', amount = settings.sieveAmount,               probability = settings.sieveProbability },
    }
    recipe.normal.main_product               = target
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products       = true
    recipe.normal.always_show_made_in        = true
    recipe.expensive                         = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients             = {
        { type = "item", name = crushedName,      amount = settings.crushedOreAmount + 2 },
        { type = "item", name = 'apm_sieve_iron', amount = settings.sieveAmount },
    }
    recipe.allow_decomposition               = false
    data:extend({ recipe })
end

local generateAdvancedEnriched = function(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)
    local ico                                = {
        icon = icons.path.ore.enriched,
        icon_size = 64,
        tint = tint,
    }

    local tier                               = {
        icon = icons.path.tier.II,
        icon_size = 64,
    }
    local recipeName                         = enrichedAdvanced(ore)
    local target                             = enriched(ore)
    local crushedName                        = crushed(ore)

    local recipe                             = {}
    recipe.type                              = "recipe"
    recipe.name                              = recipeName
    recipe.category                          = "chemistry"
    recipe.icons                             = {
        ico, tier
    }
    recipe.subgroup                          = 'bob-resource'
    recipe.normal                            = {}
    recipe.normal.enabled                    = false
    recipe.normal.hide_from_player_crafting  = true
    recipe.normal.energy_required            = settings.floatationEnergyRequired
    recipe.normal.ingredients                = {
        { type = "item",  name = crushedName, amount = settings.crushedOreAmount },
        { type = "fluid", name = liquid,      amount = liquidAmount },
        { type = "fluid", name = extraLiquid, amount = extraLiquidAmount },
    }
    recipe.normal.results                    = {
        { type = 'item',  name = target,           amount = settings.enrichedResultAmount.floatation },
        { type = 'item',  name = target,           amount_min = settings.min,                        amount_max = settings.max, probability = 0.5 },
        { type = 'fluid', name = 'apm_dirt_water', amount = settings.dirtWaterAmount },
    }
    recipe.normal.main_product               = target
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products       = true
    recipe.normal.always_show_made_in        = true
    recipe.expensive                         = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients             = {
        { type = "item",  name = crushedName, amount = settings.crushedOreAmount + 2 },
        { type = "fluid", name = liquid,      amount = liquidAmount + 10 },
        { type = "fluid", name = extraLiquid, amount = extraLiquidAmount },
    }
    recipe.allow_decomposition               = true
    data:extend({ recipe })
end

local gen = function(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)
    generateCommonEnriched(ore, tint)
    generateAdvancedEnriched(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)
end

-- generates enriched ores
local tint = { r = 192 / 255, g = 90 / 255, b = 55 / 255 }
local ore = apm.bob_rework.lib.entities.ore.copper
local liquid = 'water'
local extraLiquid = 'liquid-air'
local liquidAmount = settings.waterAmount
local extraLiquidAmount = settings.airAmount
-- TODO: get liquid amount from settings about

-- water + air separater

gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 125 / 255, g = 147 / 255, b = 155 / 255 }
local ore = apm.bob_rework.lib.entities.ore.iron
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 115 / 255, g = 115 / 255, b = 113 / 255 }
local ore = apm.bob_rework.lib.entities.ore.tin
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 97 / 255, g = 66 / 255, b = 83 / 255 }
local ore = apm.bob_rework.lib.entities.ore.titanium
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 182 / 255, g = 137 / 255, b = 0 / 255 }
local ore = apm.bob_rework.lib.entities.ore.gold
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 102 / 255, g = 150 / 255, b = 139 / 255 }
local ore = apm.bob_rework.lib.entities.ore.nickel
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

-- sulfur + lubricant separater

local tint = { r = 48 / 255, g = 126 / 255, b = 112 / 255 }
local ore = apm.bob_rework.lib.entities.ore.zinc
local liquid = 'sulfuric-acid'
local extraLiquid = apm.bob_rework.lib.entities.chem.lubricant
local liquidAmount = 20
local extraLiquidAmount = 20
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 54 / 255, g = 54 / 255, b = 53 / 255 }
local ore = apm.bob_rework.lib.entities.ore.lead
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 140 / 255, g = 126 / 255, b = 59 / 255 }
local ore = apm.bob_rework.lib.entities.ore.aluminium
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 47 / 255, g = 84 / 255, b = 122 / 255 }
local ore = apm.bob_rework.lib.entities.ore.cobalt
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 193 / 255, g = 215 / 255, b = 218 / 255 }
local ore = apm.bob_rework.lib.entities.ore.silver
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

local tint = { r = 150 / 255, g = 101 / 255, b = 59 / 255 }
local ore = apm.bob_rework.lib.entities.ore.tungsten
gen(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)

-- generate new recipe for dry mud
local recipe = 'apm_dry_mud_util'

local r = {
    type                = 'recipe',
    name                = recipe,
    category            = 'apm_sifting_0',
    icons               =
        apm.lib.utils.icon.merge({
            apm.lib.utils.icon.get.from_item('apm_crushed_stone'),
            { apm.lib.icons.dynamics.t2 },
        }),
    normal              = {
        enabled                    = false,
        energy_required            = 4,
        ingredients                = {
            { type = 'item', name = 'apm_dry_mud',    amount = 36 },
            { type = 'item', name = 'apm_sieve_iron', amount = 1 },
        },
        results                    = {
            { type = 'item', name = 'apm_crushed_stone', amount = 5 },
            { type = 'item', name = 'apm_crushed_stone', amount_min = 1, amount_max = 4,    probability = 0.4 },
            { type = 'item', name = 'apm_sieve_iron',    amount = 1,     probability = 0.95 },
        },
        main_product               = 'apm_crushed_stone',
        requester_paste_multiplier = 6,
        always_show_products       = true,
        always_show_made_in        = true,
    },
    allow_decomposition = true,
    expensive           = {},
}
r.expensive = table.deepcopy(r.normal)
r.expensive.ingredients = {
    { type = 'item', name = 'apm_dry_mud',    amount = 42 },
    { type = 'item', name = 'apm_sieve_iron', amount = 1 },
}

data:extend({ r })

-- Alternative recipe for stacked pack of dry mud
local recipe = 'apm_dry_mud_util_stacked'

local r = {
    type                = 'recipe',
    name                = recipe,
    category            = 'apm_sifting_0',
    icons               =
        apm.lib.utils.icon.merge({
            apm.lib.utils.icon.get.from_item('apm_crushed_stone'),
            { apm.lib.icons.dynamics.t3 },
        }),
    normal              = {
        enabled                    = false,
        energy_required            = 8,
        ingredients                = {
            { type = 'item', name = 'apm_dry_mud_stack', amount = 5 },
            { type = 'item', name = 'apm_sieve_iron',    amount = 1 },
        },
        results                    = {
            { type = 'item', name = 'apm_crushed_stone', amount = 14 },
            { type = 'item', name = 'apm_crushed_stone', amount_min = 0, amount_max = 4,   probability = 0.5 },
            { type = 'item', name = 'apm_sieve_iron',    amount = 1,     probability = 0.8 },
        },
        main_product               = 'apm_crushed_stone',
        requester_paste_multiplier = 6,
        always_show_products       = true,
        always_show_made_in        = true,
    },
    allow_decomposition = true,
    expensive           = {},
}
r.expensive = table.deepcopy(r.normal)
r.expensive.ingredients = {
    { type = 'item', name = 'apm_dry_mud',    amount = 42 },
    { type = 'item', name = 'apm_sieve_iron', amount = 1 },
}

data:extend({ r })
