if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.grid == nil then apm.bob_rework.lib.override.grid = {} end

apm.bob_rework.lib.override.grid = function ()
    local equipment = data.raw["generator-equipment"]["apm_equipment_burner_generator_advanced"]
    apm.bob_rework.lib.utils.grid.toEqip(equipment, "vehicle")
    local equipment = data.raw["generator-equipment"]["apm_equipment_burner_generator_basic"]
    apm.bob_rework.lib.utils.grid.toEqip(equipment, "vehicle")
    local equipment = data.raw["generator-equipment"]["apm_equipment_energy_transmitter"]
    apm.bob_rework.lib.utils.grid.toEqip(equipment, "vehicle")

    local equipment = data.raw["battery-equipment"]["energy-absorber"]
    apm.bob_rework.lib.utils.grid.toEqip(equipment, "vehicle")

end

-- apm.bob_rework.lib.utils.grid.toEqip = function (equipment, gridName)