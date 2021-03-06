require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/labs.lua'

APM_LOG_HEADER(self)

local smoke_burner = {}
--local smoke_position = {-0.77, -1.95}
local smoke_position = {-0.65, -2.15}
smoke_burner[1] = {}
smoke_burner[1].name = "apm_dark_smoke"
smoke_burner[1].deviation = {0.1, 0.1}
smoke_burner[1].frequency = 10
smoke_burner[1].position = nil
smoke_burner[1].north_position = smoke_position
smoke_burner[1].south_position = smoke_position
smoke_burner[1].east_position = smoke_position
smoke_burner[1].west_position = smoke_position
smoke_burner[1].starting_vertical_speed = 0.08
smoke_burner[1].starting_frame_deviation = 60
smoke_burner[1].slow_down_factor = 1

local smoke_steam = table.deepcopy(smoke_burner)
smoke_steam[1].name = "light-smoke"
smoke_steam[1].frequency = 8

local lab = {}
lab.type = "lab"
lab.name = "apm_lab_0"
lab.icons = {
    apm.lib.icons.dynamics.machine.t0,
    apm.lib.icons.dynamics.lable_l
}
lab.localised_description = {"entity-description.apm_lab_0"}
--lab.icon_size = 32
lab.flags = {"placeable-player", "player-creation"}
lab.minable = {mining_time = 0.2, result = "apm_lab_0"}
lab.max_health = 250
lab.corpse = "big-remnants"
lab.dying_explosion = "medium-explosion"
lab.resistances = {{type = "fire", percent = 90}}
lab.collision_box = {{-1.2, -1.2}, {1.2, 1.2}}
lab.selection_box = {{-1.5, -1.5}, {1.5, 1.5}}
lab.light = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.5, b = 0.0}}
lab.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
lab.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
lab.vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }
lab.working_sound = {}
lab.working_sound.sound = {filename = "__base__/sound/lab.ogg", volume = 0.8}
lab.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
lab.working_sound.apparent_volume = 1.5
lab.energy_usage = apm.power.constants.energy_usage.lab_0
lab.module_specification = apm.power.constants.modules.specification_0
lab.allowed_effects = apm.power.constants.modules.allowed_effects_0
lab.researching_speed = 1
lab.fast_replaceable_group = "lab"
lab.next_upgrade = "apm_lab_1"
lab.inputs = {
      "apm_industrial_science_pack",
      "apm_steam_science_pack",
    }
lab.energy_source = {}
lab.energy_source.type = "burner"
lab.energy_source.fuel_categories = {'chemical','apm_refined_chemical'}
lab.energy_source.effectivity = 1
lab.energy_source.fuel_inventory_size = 1
lab.energy_source.burnt_inventory_size = 1
lab.energy_source.emissions_per_minute = apm.power.constants.emissions.lab_0
lab.energy_source.smoke = smoke_burner
lab.on_animation = {}
lab.on_animation.layers = {}
lab.on_animation.layers[1] = {}
lab.on_animation.layers[1].filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/lab_0.png"
lab.on_animation.layers[1].priority="high"
lab.on_animation.layers[1].width = 160
lab.on_animation.layers[1].height = 128
lab.on_animation.layers[1].frame_count = 64
lab.on_animation.layers[1].line_length = 8
lab.on_animation.layers[1].shift = {0.4375, -0.28125}
lab.on_animation.layers[1].run_mode = 'forward-then-backward'
lab.on_animation.layers[1].animation_speed = 0.5333334
lab.on_animation.layers[1].hr_version = {}
lab.on_animation.layers[1].hr_version.filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/hr_lab_0.png"
lab.on_animation.layers[1].hr_version.priority="high"
lab.on_animation.layers[1].hr_version.width = 320
lab.on_animation.layers[1].hr_version.height = 256
lab.on_animation.layers[1].hr_version.frame_count = 64
lab.on_animation.layers[1].hr_version.line_length = 8
lab.on_animation.layers[1].hr_version.shift = {0.4375, -0.28125}
lab.on_animation.layers[1].hr_version.scale = 0.5
lab.on_animation.layers[1].hr_version.run_mode = 'forward-then-backward'
lab.on_animation.layers[1].hr_version.animation_speed = 0.5333334
lab.on_animation.layers[2] = {}
lab.on_animation.layers[2].filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/lab_shadow.png"
lab.on_animation.layers[2].priority="high"
lab.on_animation.layers[2].draw_as_shadow = true
lab.on_animation.layers[2].width = 160
lab.on_animation.layers[2].height = 128
lab.on_animation.layers[2].frame_count = 64
lab.on_animation.layers[2].line_length = 8
lab.on_animation.layers[2].shift = {0.4375, -0.28125}
lab.on_animation.layers[2].run_mode = 'forward-then-backward'
lab.on_animation.layers[2].animation_speed = 0.5333334
lab.on_animation.layers[2].hr_version = {}
lab.on_animation.layers[2].hr_version.filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/hr_lab_shadow.png"
lab.on_animation.layers[2].hr_version.priority="high"
lab.on_animation.layers[2].hr_version.draw_as_shadow = true
lab.on_animation.layers[2].hr_version.width = 320
lab.on_animation.layers[2].hr_version.height = 256
lab.on_animation.layers[2].hr_version.frame_count = 64
lab.on_animation.layers[2].hr_version.line_length = 8
lab.on_animation.layers[2].hr_version.shift = {0.4375, -0.28125}
lab.on_animation.layers[2].hr_version.scale = 0.5
lab.on_animation.layers[2].hr_version.run_mode = 'forward-then-backward'
lab.on_animation.layers[2].hr_version.animation_speed = 0.5333334
lab.off_animation = table.deepcopy(lab.on_animation)
lab.off_animation.layers[1].frame_count = 1
lab.off_animation.layers[1].hr_version.frame_count = 1
lab.off_animation.layers[2].frame_count = 1
lab.off_animation.layers[2].hr_version.frame_count = 1
data:extend({lab})

local lab = table.deepcopy(lab)
lab.name = "apm_lab_1"
lab.icons = {
    apm.lib.icons.dynamics.machine.t1,
    apm.lib.icons.dynamics.lable_l
}
lab.localised_description = {"entity-description.apm_lab_1"}
--lab.icon_size = 32
lab.minable = {mining_time = 0.2, result = "apm_lab_1"}
lab.light = nil
lab.energy_usage = apm.power.constants.energy_usage.lab_2
lab.module_specification = apm.power.constants.modules.specification_1
lab.allowed_effects = apm.power.constants.modules.allowed_effects_1
lab.fast_replaceable_group = "lab"
lab.next_upgrade = "lab"
lab.inputs = {
      "apm_industrial_science_pack",
      "apm_steam_science_pack",
      "automation-science-pack",
      "logistic-science-pack",
      "chemical-science-pack",
      "military-science-pack",
      "production-science-pack",
      "utility-science-pack",
    }
lab.energy_source = {}
lab.energy_source.type = "fluid"
lab.energy_source.fluid_box = {}
lab.energy_source.fluid_box.production_type = "input-output"
lab.energy_source.fluid_box.pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures()
lab.energy_source.fluid_box.pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
lab.energy_source.fluid_box.base_area = 1
lab.energy_source.fluid_box.pipe_connections = {{ type="input-output", position = {0, -2}},
                                                { type="input-output", position = {2, 0}},
                                                { type="input-output", position = {0, 2}},
                                                { type="input-output", position = {-2, 0}}
                                                }
lab.energy_source.fluid_box.secondary_draw_orders = {north = -1}
lab.energy_source.fluid_box.filter = "steam"
lab.energy_source.minimum_temperature = 100.0
lab.energy_source.maximum_temperature = 1000.0
lab.energy_source.burns_fluid = false
lab.energy_source.scale_fluid_usage = true
lab.energy_source.emissions_per_minute = apm.power.constants.emissions.lab_1
lab.energy_source.smoke = smoke_steam
lab.on_animation.layers[1].filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/lab_1.png"
lab.on_animation.layers[1].hr_version.filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/hr_lab_1.png"
lab.off_animation = table.deepcopy(lab.on_animation)
lab.off_animation.layers[1].frame_count = 1
lab.off_animation.layers[1].hr_version.frame_count = 1
lab.off_animation.layers[2].frame_count = 1
lab.off_animation.layers[2].hr_version.frame_count = 1
data:extend({lab})