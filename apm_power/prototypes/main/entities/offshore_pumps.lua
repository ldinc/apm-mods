require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/offshore_pumps.lua'

APM_LOG_HEADER(self)

local smoke_burner = {
	apm.lib.utils.builders.smoke.new(
		"apm_dark_smoke",
		{ 0.1, 0.1 },
		10,
		{ 0, 0 },
		nil,
		0.08,
		60,
		1
	)
}

local smoke_steam = {
	apm.lib.utils.builders.smoke.new(
		"apm_light_smoke",
		{ 0.1, 0.1 },
		8,
		{ 0, 0 },
		nil,
		0.08,
		60,
		1
	)
}

local item_icon_a = apm.lib.utils.icon.get.from_item('offshore-pump')

local offshore_pump_base = table.deepcopy(data.raw['offshore-pump']['offshore-pump'])

offshore_pump_base.name = "apm_offshore_pump_0"
offshore_pump_base.minable = { mining_time = 0.1, result = "apm_offshore_pump_0" }
offshore_pump_base.localised_description = { "entity-description.apm_offshore_pump" }

offshore_pump_base.fluid_box = apm.lib.utils.builders.fluid_box.new(
	"output",
	100,
	nil,
	defines.direction.south,
	{ 0, 0 },
	nil
)


-- offshore_pump_base.module = { module_slots = 1 }
-- offshore_pump_base.allowed_effects = { "pollution" }
-- offshore_pump_base.fluid = "apm_sea_water"

-- offshore_pump_base.fluid_box = apm.lib.utils.builders.fluid_box.new(
-- 	"output",
-- 	100,
-- 	nil,
-- 	defines.direction.west,
-- 	{ 0, -0.6 },
-- 	nil,
-- 	nil
-- 	-- "apm_sea_water"
-- )

-- offshore_pump_base.fluid_box.filter = "apm_sea_water"

offshore_pump_base.pumping_speed = 2.5
offshore_pump_base.fast_replaceable_group = "apm_offshore_pump"
offshore_pump_base.next_upgrade = "apm_offshore_pump_1"
offshore_pump_base.energy_usage = apm.power.constants.energy_usage.burner

offshore_pump_base.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'chemical', 'apm_refined_chemical' },
	apm.power.constants.emissions.offpump_0,
	smoke_burner
)

data:extend({ offshore_pump_base })

local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
local offshore_pump = table.deepcopy(offshore_pump_base)
offshore_pump.name = "apm_offshore_pump_1"
offshore_pump.icons = icons
offshore_pump.localised_description = { "entity-description.apm_offshore_pump" }
offshore_pump.energy_usage = apm.power.constants.energy_usage.electric

offshore_pump.energy_source = apm.lib.utils.builders.energy_source.new_electric(apm.power.constants.emissions.offpump_1)

offshore_pump.collision_box = offshore_pump_base.collision_box
offshore_pump.selection_box = offshore_pump_base.selection_box
offshore_pump.minable = { mining_time = 0.1, result = "apm_offshore_pump_1" }
offshore_pump.fast_replaceable_group = "apm_offshore_pump"
offshore_pump.next_upgrade = nil
-- offshore_pump.max_health = 100
offshore_pump.pumping_speed = 6.66666668
-- offshore_pump.fluid = "apm_sea_water"

offshore_pump_base.fluid_box = apm.lib.utils.builders.fluid_box.new(
	"output",
	100,
	nil,
	defines.direction.south,
	{ 0, 0 },
	nil
)


-- offshore_pump.fluid_box.filter = "apm_sea_water"

data:extend({ offshore_pump })

-- Replacements ---------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

-- local item_icon_b = { apm.lib.icons.dynamics.t1 }
-- local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
-- local offshore_pump = {}
-- offshore_pump.type = "assembling-machine"
-- offshore_pump.name = "apm_offshore_pump_burner"
-- offshore_pump.localised_name = { "entity-name.apm_offshore_pump_0" }
-- offshore_pump.localised_description = { "entity-description.apm_offshore_pump" }
-- offshore_pump.icons = icons
-- --offshore_pump.icon_size = 64
-- offshore_pump.group = "apm_power"
-- offshore_pump.subgroup = "apm_power_machines_miner"
-- offshore_pump.order = 'ab_a'
-- offshore_pump.minable = { mining_time = 0.1, result = "apm_offshore_pump_0" }
-- offshore_pump.placeable_by = { item = 'apm_offshore_pump_0', count = 1 }
-- offshore_pump.flags = { "placeable-neutral", "player-creation", "filter-directions" }
-- --offshore_pump.collision_mask = { "ground-tile", "object-layer" }
-- offshore_pump.collision_mask = offshore_pump_base.collision_mask
-- offshore_pump.adjacent_tile_collision_test = { "water-tile" }
-- offshore_pump.minable = { mining_time = 0.1, result = "apm_offshore_pump_0" }
-- offshore_pump.max_health = 100
-- offshore_pump.corpse = "small-remnants"
-- offshore_pump.resistances = { { type = "fire", percent = 70 }, { type = "impact", percent = 30 } }
-- offshore_pump.collision_box = offshore_pump_base.collision_box
-- offshore_pump.selection_box = offshore_pump_base.selection_box
-- offshore_pump.fast_replaceable_group = "apm_offshore_pump"
-- offshore_pump.next_upgrade = "apm_offshore_pump_1"
-- offshore_pump.trigger_created_entity = true
-- offshore_pump.crafting_categories = { "apm_fluids_from_the_void" }
-- offshore_pump.show_recipe_icon = false
-- offshore_pump.crafting_speed = 1
-- offshore_pump.fixed_recipe = "apm_sea_water_from_void_1"
-- offshore_pump.energy_usage = apm.power.constants.energy_usage.burner
-- offshore_pump.module_specification = apm.power.constants.modules.specification_0
-- offshore_pump.allowed_effects = apm.power.constants.modules.allowed_effects_0

-- offshore_pump.energy_source = apm.lib.utils.builders.energy_source.new_burner(
-- 	{ 'chemical', 'apm_refined_chemical' },
-- 	apm.power.constants.emissions.offpump_0,
-- 	smoke_burner
-- )

-- offshore_pump.fluid_box = apm.lib.utils.builders.fluid_box.new(
-- 	"output",
-- 	100,
-- 	nil,
-- 	defines.direction.south,
-- 	{ 0, 1 },
-- 	nil,
-- 	"apm_sea_water"
-- )


-- -- offshore_pump.fluid_boxes[1] = {}
-- -- offshore_pump.fluid_boxes[1].base_area = 1
-- -- offshore_pump.fluid_boxes[1].base_level = 1
-- -- offshore_pump.fluid_boxes[1].pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
-- -- offshore_pump.fluid_boxes[1].production_type = "output"
-- -- offshore_pump.fluid_boxes[1].filter = "apm_sea_water"
-- -- offshore_pump.fluid_boxes[1].pipe_connections = {}
-- -- offshore_pump.fluid_boxes[1].pipe_connections[1] = {}
-- -- offshore_pump.fluid_boxes[1].pipe_connections[1].position = { 0, 1 }
-- -- offshore_pump.fluid_boxes[1].pipe_connections[1].type = "output"

-- offshore_pump.fluid_boxes_off_when_no_fluid_recipe = false
-- offshore_pump.tile_width = 1
-- offshore_pump.tile_height = 1
-- offshore_pump.vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }
-- offshore_pump.graphics_set = offshore_pump_base.graphics_set
-- offshore_pump.placeable_position_visualization = {}
-- offshore_pump.placeable_position_visualization.filename = "__core__/graphics/cursor-boxes-32x32.png"
-- offshore_pump.placeable_position_visualization.priority = "extra-high-no-scale"
-- offshore_pump.placeable_position_visualization.width = 64
-- offshore_pump.placeable_position_visualization.height = 64
-- offshore_pump.placeable_position_visualization.scale = 0.5
-- offshore_pump.placeable_position_visualization.x = 3 * 64
-- offshore_pump.picture = {}
-- offshore_pump.picture.circuit_wire_connection_points = circuit_connector_definitions["offshore-pump"].points
-- offshore_pump.picture.circuit_connector_sprites = circuit_connector_definitions["offshore-pump"].sprites
-- offshore_pump.picture.circuit_wire_max_distance = default_circuit_wire_max_distance
-- data:extend({ offshore_pump })


-- local item_icon_b = { apm.lib.icons.dynamics.t2 }
-- local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
-- local offshore_pump = table.deepcopy(offshore_pump)
-- offshore_pump.name = "apm_offshore_pump_electric"
-- offshore_pump.localised_name = { "entity-name.apm_offshore_pump_1" }
-- offshore_pump.icons = icons
-- offshore_pump.collision_box = offshore_pump_base.collision_box
-- offshore_pump.selection_box = offshore_pump_base.selection_box
-- offshore_pump.minable = { mining_time = 0.1, result = "apm_offshore_pump_1" }
-- offshore_pump.placeable_by = { item = 'apm_offshore_pump_1', count = 1 }
-- offshore_pump.fast_replaceable_group = "apm_offshore_pump"
-- offshore_pump.next_upgrade = nil
-- offshore_pump.module_specification = apm.power.constants.modules.specification_1
-- offshore_pump.allowed_effects = apm.power.constants.modules.allowed_effects_1
-- offshore_pump.group = "apm_power"
-- offshore_pump.subgroup = "apm_power_machines_miner"
-- offshore_pump.order = 'ab_b'
-- offshore_pump.crafting_speed = 1
-- offshore_pump.fixed_recipe = "apm_sea_water_from_void_2"
-- offshore_pump.energy_usage = apm.power.constants.energy_usage.electric

-- offshore_pump.energy_source = apm.lib.utils.builders.energy_source.new_electric(
-- 	apm.power.constants.emissions.offpump_1
-- )

-- data:extend({ offshore_pump })
