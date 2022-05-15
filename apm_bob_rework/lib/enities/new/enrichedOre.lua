if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

apm.bob_rework.lib.entities.EnrichedCopperOre = 'enriched-copper-ore'
apm.bob_rework.lib.entities.EnrichedCopperOre2 = 'enriched-copper-ore2'
apm.bob_rework.lib.entities.EnrichedIronOre = 'enriched-iron-ore'
apm.bob_rework.lib.entities.EnrichedIronOre2 = 'enriched-iron-ore2'
apm.bob_rework.lib.entities.EnrichedTinOre = 'enriched-tin-ore'
apm.bob_rework.lib.entities.EnrichedTinOre2 = 'enriched-tin-ore2'
apm.bob_rework.lib.entities.EnrichedZincOre = 'enriched-zinc-ore'
apm.bob_rework.lib.entities.EnrichedZincOre2 = 'enriched-zinc-ore2'
apm.bob_rework.lib.entities.EnrichedLeadOre = 'enriched-lead-ore'
apm.bob_rework.lib.entities.EnrichedLeadOre2 = 'enriched-lead-ore2'

apm.bob_rework.lib.entities.EnrichedTitaniumOre = 'enriched-titanium-ore'
apm.bob_rework.lib.entities.EnrichedGoldOre = 'enriched-gold-ore'
apm.bob_rework.lib.entities.EnrichedNickelOre = 'enriched-nickel-ore'

apm.bob_rework.lib.entities.EnrichedAluminiumOre = 'enriched-aluminium-ore'
apm.bob_rework.lib.entities.EnrichedCobaltOre = 'enriched-cobalt-ore'
apm.bob_rework.lib.entities.EnrichedSilverOre = 'enriched-silver-ore'
apm.bob_rework.lib.entities.EnrichedTungstenOre = 'enriched-tungsten-ore'

local time_cost_sieve = 1
local time_cost_floatation = 1
local crushed_ore_cost = 4
local enriched_ore_result_sieve = 2
local enriched_ore_result_floatation = 3
local dry_mud_result = 2
local sieve_cost = 1
local sieve_probability = 0.95
local air_cost = 20
local water_cost = 20
local dirt_water_result = 20
local sulphuric_acid_cost = 20
local lubricant_cost = 20

-- Copper

apm.bob_rework.lib.entities.genEnrichedCopperOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedCopperOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedCopperOre
    recipe.category = "apm_sifting_0"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_sieve
    recipe.normal.ingredients = {
        {type="item", name='crushed-copper-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedCopperOre, amount=enriched_ore_result_sieve},
        {type='item', name='apm_dry_mud', amount=dry_mud_result},
        {type="item", name='apm_sieve_iron', amount=sieve_cost, probability=sieve_probability},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedCopperOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-copper-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genEnrichedCopperOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedCopperOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedCopperOre2
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-copper-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedCopperOre, amount=enriched_ore_result_floatation},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedCopperOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-copper-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Iron

apm.bob_rework.lib.entities.genEnrichedIronOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedIronOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedIronOre
    recipe.category = "apm_sifting_0"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_sieve
    recipe.normal.ingredients = {
        {type="item", name='crushed-iron-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedIronOre, amount=enriched_ore_result_sieve},
        {type='item', name='apm_dry_mud', amount=dry_mud_result},
        {type="item", name='apm_sieve_iron', amount=sieve_cost, probability=sieve_probability},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedIronOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-iron-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genEnrichedIronOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedIronOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedIronOre2
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-iron-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedIronOre, amount=enriched_ore_result_floatation},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedIronOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-iron-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Tin

apm.bob_rework.lib.entities.genEnrichedTinOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedTinOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedTinOre
    recipe.category = "apm_sifting_0"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_sieve
    recipe.normal.ingredients = {
        {type="item", name='crushed-tin-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedTinOre, amount=enriched_ore_result_sieve},
        {type='item', name='apm_dry_mud', amount=dry_mud_result},
        {type="item", name='apm_sieve_iron', amount=sieve_cost, probability=sieve_probability},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedTinOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-tin-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genEnrichedTinOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedTinOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedTinOre2
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-tin-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedTinOre, amount=enriched_ore_result_floatation},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedTinOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-tin-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Zinc

apm.bob_rework.lib.entities.genEnrichedZincOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedZincOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedZincOre
    recipe.category = "apm_sifting_0"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_sieve
    recipe.normal.ingredients = {
        {type="item", name='crushed-zinc-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedZincOre, amount=enriched_ore_result_sieve},
        {type='item', name='apm_dry_mud', amount=dry_mud_result},
        {type="item", name='apm_sieve_iron', amount=sieve_cost, probability=sieve_probability},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedZincOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-zinc-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genEnrichedZincOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedZincOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedZincOre2
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-zinc-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedZincOre, amount=enriched_ore_result_floatation},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedZincOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-zinc-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Lead

apm.bob_rework.lib.entities.genEnrichedLeadOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedLeadOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedLeadOre
    recipe.category = "apm_sifting_0"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_sieve
    recipe.normal.ingredients = {
        {type="item", name='crushed-lead-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedLeadOre, amount=enriched_ore_result_sieve},
        {type='item', name='apm_dry_mud', amount=dry_mud_result},
        {type="item", name='apm_sieve_iron', amount=sieve_cost, probability=sieve_probability},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedLeadOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-lead-ore', amount=crushed_ore_cost},
        {type="item", name='apm_sieve_iron', amount=sieve_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genEnrichedLeadOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedLeadOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedLeadOre2
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-lead-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedLeadOre, amount=enriched_ore_result_floatation},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedLeadOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-lead-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Titanium

apm.bob_rework.lib.entities.genEnrichedTitaniumOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedTitaniumOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedTitaniumOre
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-titanium-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedTitaniumOre, amount=enriched_ore_result_floatation},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedTitaniumOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-titanium-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Gold

apm.bob_rework.lib.entities.genEnrichedGoldOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedGoldOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedGoldOre
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-gold-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedGoldOre, amount=enriched_ore_result_floatation},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedGoldOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-gold-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Nickel

apm.bob_rework.lib.entities.genEnrichedNickelOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedNickelOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedNickelOre
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-nickel-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedNickelOre, amount=enriched_ore_result_floatation},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedNickelOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-nickel-ore', amount=crushed_ore_cost},
        {type="fluid", name='water', amount=water_cost},
        {type="fluid", name='liquid-air', amount=air_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Aluminium

apm.bob_rework.lib.entities.genEnrichedAluminiumOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedAluminiumOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedAluminiumOre
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-aluminium-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedAluminiumOre, amount=enriched_ore_result_floatation},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedAluminiumOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-aluminium-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Cobalt

apm.bob_rework.lib.entities.genEnrichedCobaltOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedCobaltOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedCobaltOre
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-cobalt-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedCobaltOre, amount=enriched_ore_result_floatation},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedCobaltOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-cobalt-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Silver

apm.bob_rework.lib.entities.genEnrichedSilverOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedSilverOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedSilverOre
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-silver-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedSilverOre, amount=enriched_ore_result_floatation},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedSilverOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-silver-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Tungsten

apm.bob_rework.lib.entities.genEnrichedTungstenOre = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_enriched_ore.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.EnrichedTungstenOre
    item.icons = {ico}    
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.EnrichedTungstenOre
    recipe.category = "chemistry"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost_floatation
    recipe.normal.ingredients = {
        {type="item", name='crushed-tungsten-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.EnrichedTungstenOre, amount=enriched_ore_result_floatation},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.EnrichedTungstenOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='crushed-tungsten-ore', amount=crushed_ore_cost},
        {type="fluid", name='sulfuric-acid', amount=sulphuric_acid_cost},
        {type="fluid", name='lubricant', amount=lubricant_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end


apm.bob_rework.lib.entities.genEnrichedCopperOre()
apm.bob_rework.lib.entities.genEnrichedCopperOre2()
apm.bob_rework.lib.entities.genEnrichedIronOre()
apm.bob_rework.lib.entities.genEnrichedIronOre2()
apm.bob_rework.lib.entities.genEnrichedTinOre()
apm.bob_rework.lib.entities.genEnrichedTinOre2()
apm.bob_rework.lib.entities.genEnrichedZincOre()
apm.bob_rework.lib.entities.genEnrichedZincOre2()
apm.bob_rework.lib.entities.genEnrichedLeadOre()
apm.bob_rework.lib.entities.genEnrichedLeadOre2()
apm.bob_rework.lib.entities.genEnrichedTitaniumOre()
apm.bob_rework.lib.entities.genEnrichedGoldOre()
apm.bob_rework.lib.entities.genEnrichedNickelOre()
apm.bob_rework.lib.entities.genEnrichedAluminiumOre()
apm.bob_rework.lib.entities.genEnrichedCobaltOre()
apm.bob_rework.lib.entities.genEnrichedSilverOre()
apm.bob_rework.lib.entities.genEnrichedTungstenOre()
