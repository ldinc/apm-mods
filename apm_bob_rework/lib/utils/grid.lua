if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.grid == nil then apm.bob_rework.lib.utils.grid = {} end

apm.bob_rework.lib.utils.grid.new = function (attributes)
    local name = attributes.name .. "-grid-apm"
    
    data:extend({
            {
                type = "equipment-grid",
                name = name,
                width = attributes.width or 5,
                height = attributes.height or 5,
                equipment_categories = attributes.categories or {"armor"}
            }
    })

	return name
end
