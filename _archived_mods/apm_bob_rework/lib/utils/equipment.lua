if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.equipment == nil then apm.bob_rework.lib.utils.equipment = {} end

apm.bob_rework.lib.utils.equipment.set = function (eType, eName, equipmentGrid)
	if data.raw[eType] and data.raw[eType][eName] then
        data.raw[eType][eName].equipment_grid = equipmentGrid
    end
end