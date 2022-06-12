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

local icoPath = "__apm_bob_rework_ldinc__/graphics/icons/apm_heap.png"
local tier1Ico = "__apm_bob_rework_ldinc__/graphics/icons/apm_tier_1.png"
local tier2Ico = "__apm_bob_rework_ldinc__/graphics/icons/apm_tier_2.png"

local settings = {
    energyRequired = 1,
    floatationEnergyRequired = 1,
    crushedOreAmount = 4,
    enrichedResultAmount = {
        sieve = 2,
        floatation = 3,
    },
    dryMudAmout = 2,
    sieveAmount = 1,
    sieveEnergyRequired = 1,
    sieveProbability = 0.95,
    airAmount = 20,
    waterAmount = 20,
    dirtWaterAmount = 20,
    sulphuricAcidAmount = 20,
    lubricantAmount = 20,
}

local generateCommonEnriched = function(ore, tint)
    local ico = {
        icon = icoPath,
        icon_size = 64,
        tint = tint,
    }

    local tier = {
        icon = tier1Ico,
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
    -- item.group = "apm_power"
    item.subgroup = "bob-material"
    item.order = 'ab_i'
    data:extend({ item })

    -- recipe
    local recipe = {}
    recipe.type = "recipe"
    recipe.name = target
    recipe.category = "apm_sifting_0"
    recipe.icons = { ico, tier }
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = settings.sieveEnergyRequired
    recipe.normal.ingredients = {
        { type = "item", name = crushedName, amount = settings.crushedOreAmount },
        { type = "item", name = 'apm_sieve_iron', amount = settings.sieveAmount },
    }
    recipe.normal.results = {
        { type = 'item', name = target, amount = settings.enrichedResultAmount.sieve },
        { type = 'item', name = 'apm_dry_mud', amount = settings.dryMudAmout },
        { type = "item", name = 'apm_sieve_iron', amount = settings.sieveAmount, probability = settings.sieveProbability },
    }
    recipe.normal.main_product = target
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        { type = "item", name = crushedName, amount = settings.crushedOreAmount + 2 },
        { type = "item", name = 'apm_sieve_iron', amount = settings.sieveAmount },
    }
    recipe.allow_decomposition = false
    data:extend({ recipe })

end

local generateAdvancedEnriched = function(ore, tint, liquid, liquidAmount, extraLiquid, extraLiquidAmount)
    local ico = {
        icon = icoPath,
        icon_size = 64,
        tint = tint,
    }

    local tier = {
        icon = tier2Ico,
        icon_size = 64,
    }
    local recipeName = enrichedAdvanced(ore)
    local target = enriched(ore)
    local crushedName = crushed(ore)

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = recipeName
    recipe.category = "chemistry"
    recipe.icons = {
        ico, tier
    }
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = settings.floatationEnergyRequired
    recipe.normal.ingredients = {
        { type = "item", name = crushedName, amount = settings.crushedOreAmount },
        { type = "fluid", name = liquid, amount = liquidAmount },
        { type = "fluid", name = extraLiquid, amount = extraLiquidAmount },
    }
    recipe.normal.results = {
        { type = 'item', name = target, amount = settings.enrichedResultAmount.floatation },
        { type = 'fluid', name = 'apm_dirt_water', amount = settings.dirtWaterAmount },
    }
    recipe.normal.main_product = target
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        { type = "item", name = crushedName, amount = settings.crushedOreAmount + 2 },
        { type = "fluid", name = liquid, amount = liquidAmount + 10 },
        { type = "fluid", name = extraLiquid, amount = extraLiquidAmount },
    }
    recipe.allow_decomposition = true
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
local liquidAmount = 20
local extraLiquidAmount = 20
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
local extraLiquid = 'lubricant'
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
