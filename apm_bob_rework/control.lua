local event = require("__flib__.event")
local on_tick_n = require("__flib__.on-tick-n")
local migrations = require("scripts.migrations")

local energy_absorber = require("scripts.energy-absorber")
local tesla_coil = require("scripts.tesla-coil")

-- BOOTSTRAP

event.on_init(function()
    -- Initialize libraries
    on_tick_n.init()

    -- Initialize `global` table
    tesla_coil.init()
    tesla_coil.get_absorber_buffer_capacity()
    migrations.generic()
end)

-- CUSTOM INPUT

event.register({
    defines.events.on_built_entity,
    defines.events.on_entity_cloned,
    defines.events.on_robot_built_entity,
    defines.events.script_raised_built,
    defines.events.script_raised_revive,
}, function(e)
    local entity = e.entity or e.created_entity or e.destination
    if not entity or not entity.valid then
        return
    end
    local entity_name = entity.name

    if entity_name == "kr-tesla-coil" then
        tesla_coil.build(entity)
    end
end)

event.register({
    defines.events.on_player_mined_entity,
    defines.events.on_robot_mined_entity,
    defines.events.on_entity_died,
    defines.events.script_raised_destroy,
}, function(e)
    local entity = e.entity
    if not entity or not entity.valid then
        return
    end
    local entity_name = entity.name
    if entity_name == "kr-tesla-coil" then
        tesla_coil.destroy(entity)
    end
end)

event.on_entity_destroyed(function(e)
    local beam_data = global.tesla_coil.beams[e.registration_number]
    if beam_data then
        tesla_coil.remove_connection(beam_data.target_data, beam_data.tower_data)
    end
end)

-- EQUIPMENT

event.on_player_placed_equipment(energy_absorber.on_placed)
event.on_equipment_inserted(function(e)
    if e.equipment.valid and e.equipment.name == "energy-absorber" then
        tesla_coil.update_target_grid(e.grid)
    end
end)
event.on_equipment_removed(function(e)
    if e.equipment == "energy-absorber" then
        tesla_coil.update_target_grid(e.grid)
    end
end)

-- PLAYER

event.on_player_armor_inventory_changed(tesla_coil.on_player_armor_inventory_changed)

event.on_script_trigger_effect(function(e)
    if e.effect_id == "kr-tesla-coil-trigger" then
        tesla_coil.process_turret_fire(e.target_entity, e.source_entity)
    end
end)

local evolution = function(event)
    local force = event.research.force

    local evolution = 0.0

    for _, tech in pairs(force.technologies) do
        if tech.researched and tech.effects then
            for _, effect in pairs(tech.effects) do
                if effect.type == "nothing" and effect.effect_description then
                    if effect.effect_description[1] == "research-causes-evolution-effect" then
                        local value = effect.effect_description[2]
                        evolution = evolution + value
                    end
                end
            end
        end
        for _, force in pairs(game.forces) do
            if force.ai_controllable or force == game.forces.enemy then
                -- force.evolution_factor = evolution / 100.0
                local technologies_evolution = evolution / 100.0
                local current_evolution = force.evolution_factor
                force.evolution_factor = math.max(technologies_evolution, current_evolution)
            end
        end
    end
end

script.on_event(
    defines.events.on_research_finished,
    evolution
)
