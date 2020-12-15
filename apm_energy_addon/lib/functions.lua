require('__apm_lib__.lib.log')

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
    car.sound_no_fuel[1].filename = "__apm_resource_pack__/sounds/car/car-no-fuel-1.ogg"
    car.working_sound.sound.filename = "__apm_resource_pack__/sounds/car/car-engine.ogg"
    car.working_sound.sound.volume = 1.0
    car.working_sound.activate_sound = nil
    car.working_sound.deactivate_sound = nil
    data:extend({car})

    apm.energy_addon.overhaul(item.name)
end
