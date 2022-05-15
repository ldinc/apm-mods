if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

apm.bob_rework.lib.entities.CrushedCopperOre = 'crushed-copper-ore'
apm.bob_rework.lib.entities.CrushedCopperOre2 = 'crushed-copper-ore2'
apm.bob_rework.lib.entities.CrushedIronOre = 'crushed-iron-ore'
apm.bob_rework.lib.entities.CrushedIronOre2 = 'crushed-iron-ore2'
apm.bob_rework.lib.entities.CrushedAluminiumOre = 'crushed-aluminium-ore'
apm.bob_rework.lib.entities.CrushedAluminiumOre2 = 'crushed-aluminium-ore2'
apm.bob_rework.lib.entities.CrushedZincOre = 'crushed-zinc-ore'
apm.bob_rework.lib.entities.CrushedZincOre2 = 'crushed-zinc-ore2'
apm.bob_rework.lib.entities.CrushedLeadOre = 'crushed-lead-ore'
apm.bob_rework.lib.entities.CrushedLeadOre2 = 'crushed-lead-ore2'
apm.bob_rework.lib.entities.CrushedGoldOre = 'crushed-gold-ore'
apm.bob_rework.lib.entities.CrushedGoldOre2 = 'crushed-gold-ore2'
apm.bob_rework.lib.entities.CrushedCobaltOre = 'crushed-cobalt-ore'
apm.bob_rework.lib.entities.CrushedCobaltOre2 = 'crushed-cobalt-ore2'
apm.bob_rework.lib.entities.CrushedTitaniumOre = 'crushed-titanium-ore'
apm.bob_rework.lib.entities.CrushedTitaniumOre2 = 'crushed-titanium-ore2'
apm.bob_rework.lib.entities.CrushedSilverOre = 'crushed-silver-ore'
apm.bob_rework.lib.entities.CrushedSilverOre2 = 'crushed-silver-ore2'
apm.bob_rework.lib.entities.CrushedTinOre = 'crushed-tin-ore'
apm.bob_rework.lib.entities.CrushedTinOre2 = 'crushed-tin-ore2'
apm.bob_rework.lib.entities.CrushedNickelOre = 'crushed-nickel-ore'
apm.bob_rework.lib.entities.CrushedNickelOre2 = 'crushed-nickel-ore2'
apm.bob_rework.lib.entities.CrushedTungstenOre = 'crushed-tungsten-ore'
apm.bob_rework.lib.entities.CrushedTungstenOre2 = 'crushed-tungsten-ore2'

local ore_cost = 4
local crushed_ore_result = 6
local water_cost = 40
local dirt_water_result = 20
local time_cost = 1

--Copper ore

apm.bob_rework.lib.entities.genCrushedCopperOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedCopperOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedCopperOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='copper-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedCopperOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedCopperOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='copper-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedCopperOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedCopperOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedCopperOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='copper-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedCopperOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedCopperOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='copper-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Iron ore

apm.bob_rework.lib.entities.genCrushedIronOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedIronOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedIronOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='iron-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedIronOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedIronOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='iron-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedIronOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedIronOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedIronOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='iron-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedIronOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedIronOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='iron-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Aluminium ore

apm.bob_rework.lib.entities.genCrushedAluminiumOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedAluminiumOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedAluminiumOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='bauxite-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedAluminiumOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedAluminiumOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='bauxite-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedAluminiumOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedAluminiumOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedAluminiumOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='bauxite-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedAluminiumOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedAluminiumOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='bauxite-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Zinc ore

apm.bob_rework.lib.entities.genCrushedZincOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedZincOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedZincOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='zinc-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedZincOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedZincOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='zinc-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedZincOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedZincOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedZincOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='zinc-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedZincOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedZincOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='zinc-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Lead ore

apm.bob_rework.lib.entities.genCrushedLeadOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedLeadOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedLeadOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='lead-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedLeadOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedLeadOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='lead-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedLeadOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedLeadOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedLeadOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='lead-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedLeadOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedLeadOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='lead-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Gold ore

apm.bob_rework.lib.entities.genCrushedGoldOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedGoldOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedGoldOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='gold-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedGoldOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedGoldOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='gold-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedGoldOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedGoldOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedGoldOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='gold-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedGoldOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedGoldOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='gold-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Cobalt ore

apm.bob_rework.lib.entities.genCrushedCobaltOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedCobaltOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedCobaltOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='cobalt-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedCobaltOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedCobaltOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='cobalt-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedCobaltOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedCobaltOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedCobaltOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='cobalt-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedCobaltOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedCobaltOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='cobalt-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Titanium ore

apm.bob_rework.lib.entities.genCrushedTitaniumOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedTitaniumOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedTitaniumOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='rutile-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedTitaniumOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedTitaniumOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='rutile-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedTitaniumOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedTitaniumOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedTitaniumOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='rutile-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedTitaniumOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedTitaniumOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='rutile-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Silver ore

apm.bob_rework.lib.entities.genCrushedSilverOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedSilverOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedSilverOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='silver-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedSilverOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedSilverOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='silver-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedSilverOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedSilverOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedSilverOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='silver-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedSilverOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedSilverOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='silver-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Tin ore

apm.bob_rework.lib.entities.genCrushedTinOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedTinOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedTinOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='tin-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedTinOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedTinOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='tin-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedTinOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedTinOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedTinOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='tin-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedTinOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedTinOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='tin-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Nickel ore

apm.bob_rework.lib.entities.genCrushedNickelOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedNickelOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedNickelOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='nickel-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedNickelOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedNickelOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='nickel-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedNickelOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedNickelOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedNickelOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='nickel-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedNickelOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedNickelOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='nickel-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

-- Tungsten ore

apm.bob_rework.lib.entities.genCrushedTungstenOre1 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedTungstenOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedTungstenOre
    recipe.category = "apm_crusher"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='tungsten-ore', amount=ore_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedTungstenOre, amount=crushed_ore_result}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedTungstenOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='tungsten-ore', amount=ore_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedTungstenOre2 = function ()
    local tint = {r=255/255, g=69/255, b=0/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/apm_crushed.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.CrushedTungstenOre
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.CrushedTungstenOre2
    recipe.category = "apm_crusher_2"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = time_cost
    recipe.normal.ingredients = {
        {type="item", name='tungsten-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.CrushedTungstenOre, amount=crushed_ore_result},
        {type='fluid', name='apm_dirt_water', amount=dirt_water_result},
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.CrushedTungstenOre
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='tungsten-ore', amount=ore_cost},
        {type="fluid", name='water', amount=water_cost},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genCrushedCopperOre1()
apm.bob_rework.lib.entities.genCrushedCopperOre2()
apm.bob_rework.lib.entities.genCrushedIronOre1()
apm.bob_rework.lib.entities.genCrushedIronOre2()
apm.bob_rework.lib.entities.genCrushedAluminiumOre1()
apm.bob_rework.lib.entities.genCrushedAluminiumOre2()
apm.bob_rework.lib.entities.genCrushedZincOre1()
apm.bob_rework.lib.entities.genCrushedZincOre2()
apm.bob_rework.lib.entities.genCrushedLeadOre1()
apm.bob_rework.lib.entities.genCrushedLeadOre2()
apm.bob_rework.lib.entities.genCrushedGoldOre1()
apm.bob_rework.lib.entities.genCrushedGoldOre2()
apm.bob_rework.lib.entities.genCrushedCobaltOre1()
apm.bob_rework.lib.entities.genCrushedCobaltOre2()
apm.bob_rework.lib.entities.genCrushedTitaniumOre1()
apm.bob_rework.lib.entities.genCrushedTitaniumOre2()
apm.bob_rework.lib.entities.genCrushedSilverOre1()
apm.bob_rework.lib.entities.genCrushedSilverOre2()
apm.bob_rework.lib.entities.genCrushedTinOre1()
apm.bob_rework.lib.entities.genCrushedTinOre2()
apm.bob_rework.lib.entities.genCrushedNickelOre1()
apm.bob_rework.lib.entities.genCrushedNickelOre2()
apm.bob_rework.lib.entities.genCrushedTungstenOre1()
apm.bob_rework.lib.entities.genCrushedTungstenOre2()