if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.container == nil then apm.bob_rework.lib.utils.container = {} end

apm.bob_rework.lib.utils.container.changeInventorySize = function (recipe, size)
    local container = data.raw.container[recipe]
    if container then
        container.inventory_size = size
    end
end