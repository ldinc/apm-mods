if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local names = {
    crude = {
        item = 'crude-oil-barrel',
        from = 'crude-oil',
        fuel_value = '115MJ',
    },
    light = {
        item = 'light-oil-barrel',
        from = 'light-oil',
        fuel_value = '75MJ',
    },
    heavy = {
        item = 'heavy-oil-barrel',
        from = 'heavy-oil',
        fuel_value = '50MJ',
    },
}
local m = 50

local up = function (name)
    local itm = data.raw.item[name.item]
    local from = data.raw.fluid[name.from]
    local fuel_value = name.fuel_value
    local emissions_multiplier = from.emissions_multiplier

    itm.fuel_value = fuel_value
    itm.emissions_multiplier = emissions_multiplier
    itm.burnt_result = 'empty-barrel'
    itm.fuel_category = 'apm_refined_chemical'
end

local update = function ()
    for key, values in pairs(names) do
        up(values)
    end
end

apm.bob_rework.lib.override.barrels = update