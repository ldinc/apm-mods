if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end


require('lib.enities.gearingAndBearings')


apm.bob_rework.lib.entities.genGearWheel = function (name, base, tint)
    local ico = {
        icon = "__apm_bob_rework_ldinc__/graphics/icons/gear-wheel.png",
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
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = 0.5
    recipe.normal.ingredients = {
            {type="item", name=base, amount=1}
        }
    recipe.normal.results = {
            {type='item', name=name, amount=1}
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

apm.bob_rework.lib.entities.genGearWheel(apm.bob_rework.lib.entities.bronzeGearWheel, apm.bob_rework.lib.entities.bronze, {r=151/255, g=115/255, b=81/255})