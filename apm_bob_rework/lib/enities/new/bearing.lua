if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

require('lib.enities.gearingAndBearings')

apm.bob_rework.lib.entities.genBearing = function (name, base, ball, tint, handmade)
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/bearing.png",
        icon_size = 32,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = name
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = name
    recipe.category = 'crafting-with-fluid'
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = 0.5
    recipe.normal.ingredients = {
            {type="item", name=base, amount=1},
            {type="item", name=ball, amount=16},
            {type="fluid", name=apm.bob_rework.lib.entities.lubricant, amount=10}
        }
    recipe.normal.results = { 
            {type='item', name=name, amount=2}
        }
    recipe.normal.main_product = name
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
            {type="item", name=base, amount=2}
        }

    data:extend({recipe})

    if handmade then
        local recipe = {}
        recipe.type = "recipe"
        recipe.name = name.."-handmade"
        recipe.category = 'apm_handcrafting_only'
        recipe.normal = {}
        recipe.normal.enabled = true
        recipe.normal.energy_required = 1
        recipe.normal.ingredients = {
                {type="item", name=base, amount=2},
                {type="item", name=apm.bob_rework.lib.entities.wood, amount=2}
            }
        recipe.normal.results = { 
                {type='item', name=name, amount=2},
                {type='item', name='apm_wood_pellets', amount=6}
            }
        recipe.normal.main_product = name
        recipe.normal.requester_paste_multiplier = 4
        recipe.normal.always_show_products = true
        recipe.normal.always_show_made_in = true
        recipe.expensive = table.deepcopy(recipe.normal)
        recipe.expensive.ingredients = {
                {type="item", name=base, amount=2}
            }
    
        data:extend({recipe})
    end
end

-- apm.bob_rework.lib.entities.genBearing(
--     apm.bob_rework.lib.entities.bronzeBearing, apm.bob_rework.lib.entities.bronze,
--     apm.bob_rework.lib.entities.bronzeBearingBall, {r=151/255, g=115/255, b=81/255},
--     true
-- )
apm.bob_rework.lib.entities.genBearing(
    apm.bob_rework.lib.entities.brassBearing, apm.bob_rework.lib.entities.brass,
    apm.bob_rework.lib.entities.brassBearingBall, {r=235/255, g=244/255, b=181/255},
    false
)