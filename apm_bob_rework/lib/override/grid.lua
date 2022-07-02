local combat = require "lib.entities.combat"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.grid == nil then apm.bob_rework.lib.override.grid = {} end

-- TODO

apm.bob_rework.lib.override.grid = function()
    local add = function (name, type)
        local item  = data.raw[type][name]
        apm.bob_rework.lib.utils.grid.toEqip(item, 'vehicle')
    end
    local eq = combat.equip
    local type = 'generator-equipment'
    add(eq.generator.burner.basic, type)
    add(eq.generator.burner.advance, type)
    add(eq.generator.nuclear.basic, type)
    add(eq.generator.nuclear.advance, type)
    add(eq.generator.transmitter.battery, type)
    type = 'solar-panel-equipment'
    add(eq.generator.solar.basic, type)
    add(eq.generator.solar.advance, type)
    type = 'battery-equipment'
    add(eq.generator.transmitter.tesla, type)
    add(eq.battery.I, type)
    add(eq.battery.II, type)
    add(eq.battery.III, type)
    add(eq.battery.IV, type)
    type = 'roboport-equipment'
    add(eq.robo.port.red, type)
    add(eq.robo.port.blue, type)
    type = 'energy-shield-equipment'
    add(combat.armor.shield.I, type)
    add(combat.armor.shield.II, type)
    add(combat.armor.shield.III, type)
    add(combat.armor.shield.IV, type)
    type = 'active-defense-equipment'
    add(combat.armor.turret.basic, type)
    add(combat.armor.turret.advance, type)
end

-- apm.bob_rework.lib.utils.grid.toEqip = function (equipment, gridName)
