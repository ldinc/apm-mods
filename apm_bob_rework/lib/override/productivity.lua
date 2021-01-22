if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.utils.recipe')

local conv = function (array)
    local m = {}
    for _, el in pairs(array) do
        m[el] = true
    end

    return m
end

local update = function ()
    local fluids = apm.bob_rework.lib.utils.recipe.getAllFluids()
    apm.bob_rework.lib.utils.recipe.disableProductivity(conv(fluids))

    fluids = apm.bob_rework.lib.utils.recipe.getWithFluids()
    local v = conv(fluids)
    v['apm_refining_creosote_1'] = true
    v['apm_refining_wood_1'] = true
    v['apm_lubricant_1'] = true
    v['apm_coal_saturated_wastewater'] = true
    apm.bob_rework.lib.utils.recipe.disableProductivity(v)
end

update()
