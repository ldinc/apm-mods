require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/lib/functions.lua'

APM_LOG_HEADER(self)

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.energy_addon.overhaul(vehicle_name)
    local vehicle

    if apm.lib.utils.car.exist(vehicle_name) then
        vehicle = data.raw.car[vehicle_name]
    elseif apm.lib.utils.locomotive.exist(vehicle_name) then
        vehicle = data.raw.locomotive[vehicle_name]
    else
        return
    end

    vehicle.localised_description = {"entity-description.apm_electric"}
    vehicle.burner.fuel_categories = {'apm_electrical'}

    if not vehicle.burner.fuel_inventory_size then
        vehicle.burner.fuel_inventory_size = 2
    elseif vehicle.burner.fuel_inventory_size > 3 then
        vehicle.burner.fuel_inventory_size = 3
    end

    vehicle.burner.burnt_inventory_size = vehicle.burner.fuel_inventory_size
    vehicle.burner.emissions_per_minute = nil
    vehicle.effectivity = 0.89
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.energy_addon.generate_electric_powered(name)
    local item_icon_a = apm.lib.utils.icon.get.from_item(name)
    local item_icon_b = {apm.energy_addon.icons.electric_symbol}
    local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})
    local item_car = data.raw['item-with-entity-data'][name]
    local item = {}

    item.type = 'item'
    item.name = 'apm_electric_' .. name
    item.localised_name = {"entity-name.apm_electric", {'entity-name.' .. name}}
    item.icons = icons
    --item.icon_mipmaps = 4
    item.stack_size = item_car.stack_size
    item.group = item_car.group
    item.subgroup = item_car.subgroup
    item.order = item_car.order .. 'z'
    item.place_result = item.name
    data:extend({item})

    local car = table.deepcopy(data.raw.car[name])
    car.name = item.name
    car.localised_name = {"entity-name.apm_electric", {'entity-name.' .. name}}
    car.icon = nil
    car.icons = {
        {icon = data.raw.car[name].icon},
        apm.energy_addon.icons.electric_symbol
    }
    car.minable = {mining_time = 0.4, result = item.name}
    car.burner.smoke = nil
    car.sound_no_fuel[1].filename = "__apm_resource_pack_ldinc__/sounds/car/car-no-fuel-1.ogg"
    car.working_sound.sound.filename = "__apm_resource_pack_ldinc__/sounds/car/car-engine.ogg"
    car.working_sound.sound.volume = 1.0
    car.working_sound.activate_sound = nil
    car.working_sound.deactivate_sound = nil
    data:extend({car})

    apm.energy_addon.overhaul(item.name)
end

function apm.energy_addon.generate_electric_powered_locomotive(name)
    local item_icon_a = apm.lib.utils.icon.get.from_item(name)
    local item_icon_b = {apm.energy_addon.icons.electric_symbol}
    local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})
    local item_car = data.raw['item-with-entity-data'][name]
    local item = {}

    item.type = 'item'
    item.name = 'apm_electric_' .. name
    item.localised_name = {"entity-name.apm_electric", {'entity-name.' .. name}}
    item.icons = icons
    --item.icon_mipmaps = 4
    item.stack_size = item_car.stack_size
    item.group = item_car.group
    item.subgroup = item_car.subgroup
    item.order = item_car.order .. 'z'
    item.place_result = item.name
    data:extend({item})

    local locomotive = table.deepcopy(data.raw.locomotive[name])
    locomotive.name = item.name
    locomotive.localised_name = {"entity-name.apm_electric", {'entity-name.' .. name}}
    locomotive.icon = nil
    locomotive.icons = {
        {icon = data.raw.locomotive[name].icon},
        apm.energy_addon.icons.electric_symbol
    }
    locomotive.minable = {mining_time = 0.4, result = item.name}
    locomotive.burner.smoke = nil
    -- locomotive.sound_no_fuel[1].filename = "__apm_resource_pack_ldinc__/sounds/car/car-no-fuel-1.ogg"
    -- locomotive.working_sound.sound.filename = "__apm_resource_pack_ldinc__/sounds/car/car-engine.ogg"
    locomotive.working_sound.sound.volume = 1.0
    locomotive.working_sound.activate_sound = nil
    locomotive.working_sound.deactivate_sound = nil
    data:extend({locomotive})

    apm.energy_addon.overhaul(item.name)
end

function apm.energy_addon.generate_electric_locomotive_new_recipe(name)
    local recipe = {}
    local resultName = "apm_electric_" .. name
    recipe.type = "recipe"
    recipe.name = resultName
    recipe.normal = {}
    recipe.normal.enabled = false
    recipe.normal.energy_required = 0.5
    recipe.normal.ingredients = {
            {type="item", name=name, amount=1},
            {type="item", name="electric-engine-unit", amount=24},
            apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T5', 20)
        }
    recipe.normal.results = {
            {type='item', name=resultName, amount=1}
        }
    recipe.normal.main_product = resultName
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = apm_energy_addon_always_show_made_in
    recipe.expensive = table.deepcopy(recipe.normal)
    data:extend({recipe})
end

function apm.energy_addon.generate_electric_locomotive_new_tech(name, suffix)
    local technology = {}
    local tName = 'apm_electric_' .. suffix
    local itmName = "apm_electric_" .. name
    technology.type = 'technology'
    technology.name = tName
    technology.icon = '__base__/graphics/technology/railway.png'
    technology.icon_size = 256
    technology.icon_mipmaps = 4
    technology.effects = {
        {type = 'unlock-recipe', recipe = itmName},
    }
    technology.prerequisites = {suffix, 'electric-engine', 'battery'}
    technology.unit = {}
    technology.unit.count = 125
    technology.unit.ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"military-science-pack", 1}, {"chemical-science-pack", 1}}
    technology.unit.time = 30
    technology.order = 'aa_a'
    data:extend({technology})
end