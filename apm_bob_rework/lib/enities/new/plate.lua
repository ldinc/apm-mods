if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

apm.bob_rework.lib.entities.monel = 'monel-alloy'

apm.bob_rework.lib.entities.genMonel = function ()
    local tint = {r=205/255, g=205/255, b=156/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/alloy-plate.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.monel
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.monel
    recipe.category = "mixing-furnace"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = 25
    recipe.normal.ingredients = {
        {type="item", name='copper-plate', amount=4},
        {type="item", name='nickel-plate', amount=6},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.monel, amount=10}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.monel
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='copper-plate', amount=4},
        {type="item", name='nickel-plate', amount=6},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genMonel()

--
apm.bob_rework.lib.entities.cobaltAlloy = 'cobalt-alloy'
apm.bob_rework.lib.entities.cobaltPlate = 'cobalt-plate'

-- TODO: check dead code?
apm.bob_rework.lib.entities.genCobaltAlloy = function ()
    local tint = {r=50/255, g=65/255, b=56/255}
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/alloy-plate.png",
        icon_size = 64,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.cobaltAlloy
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = apm.bob_rework.lib.entities.cobaltAlloy
    recipe.category = "mixing-furnace"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = 25
    recipe.normal.ingredients = {
        {type="item", name='tungsten-plate', amount=1},
        {type="item", name='nickel-plate', amount=1},
        {type="item", name='cobalt-plate', amount=2},
    }
    recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.cobaltAlloy, amount=4}
    }
    recipe.normal.main_product = apm.bob_rework.lib.entities.cobaltAlloy
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='tungsten-plate', amount=1},
        {type="item", name='nickel-plate', amount=1},
        {type="item", name='cobalt-plate', amount=2},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genEarlyZinc = function ()
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/zinc-plate.png",
        icon_size = 32,
    }

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = 'apm_zinc'
    recipe.category = "mixing-furnace"
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = 15
    recipe.normal.ingredients = {
        {type="item", name='zinc-ore', amount=5},
        {type="item", name='apm_coke', amount=1},
    }
    recipe.normal.results = { 
        {type='item', name='zinc-plate', amount=5}
    }
    recipe.normal.main_product = 'zinc-plate'
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name='zinc-ore', amount=5},
        {type="item", name='apm_coke', amount=2},
    }
    recipe.allow_decomposition = false
    data:extend({recipe})
end

apm.bob_rework.lib.entities.genEarlyZinc()