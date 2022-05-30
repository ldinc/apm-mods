if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.grid == nil then apm.bob_rework.lib.utils.grid = {} end

require('lib.utils.debug')

apm.bob_rework.lib.utils.grid.new = function(attributes)
    local name = attributes.name .. "-grid-apm"

    data:extend({
        {
            type = "equipment-grid",
            name = name,
            width = attributes.width or 5,
            height = attributes.height or 5,
            equipment_categories = attributes.categories or { "armor" }
        }
    })

    return name
end

apm.bob_rework.lib.utils.grid.set = function(name, w, h)
    local grid = data.raw['equipment-grid'][name]
    apm.bob_rework.lib.utils.debug.object("------------------")
    apm.bob_rework.lib.utils.debug.object(grid)
    apm.bob_rework.lib.utils.debug.object("------------------")
    if grid then
        grid.width = w
        grid.height = h
    end
end

apm.bob_rework.lib.utils.grid.toEqip = function (equipment, gridName)
    if equipment and equipment.categories then
        equipment.categories[#equipment.categories+1]=gridName
    end
end