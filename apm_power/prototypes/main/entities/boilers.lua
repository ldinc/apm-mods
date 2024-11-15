require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/entities/boilers.lua'

APM_LOG_HEADER(self)

-- Smoke ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local original = data.raw.boiler['boiler']
original.energy_source.emissions_per_minute = { pollution = 4 }

local boiler = table.deepcopy(data.raw.boiler['boiler'])

boiler.name = 'apm_boiler_2'
boiler.icons = {
	apm.power.icons.boiler,
	apm.lib.icons.dynamics.t2
}
--boiler.icon_size = apm.power.icons.boiler.icon_size
boiler.minable = { mining_time = 0.2, result = "apm_boiler_2" }
boiler.fast_replaceable_group = 'boiler'
boiler.max_health = 250
boiler.energy_consumption = '3.6MW'
boiler.target_temperature = 240

boiler.energy_source.fuel_inventory_size = 1
boiler.energy_source.burnt_inventory_size = 1
boiler.energy_source.fuel_categories = { 'apm_refined_chemical' }
boiler.energy_source.emissions_per_minute = { pollution = 20 }

local layer = table.deepcopy(boiler.pictures.north.structure.layers[1])
layer.filename = '__apm_resource_pack_ldinc__/graphics/masks/boiler/hr-boiler-N-idle.png'
layer.tint = apm.power.color.boiler_tier_2
table.insert(boiler.pictures.north.structure.layers, layer)

layer = table.deepcopy(boiler.pictures.east.structure.layers[1])
layer.filename = '__apm_resource_pack_ldinc__/graphics/masks/boiler/hr-boiler-E-idle.png'
layer.tint = apm.power.color.boiler_tier_2
table.insert(boiler.pictures.east.structure.layers, layer)

layer = table.deepcopy(boiler.pictures.south.structure.layers[1])
layer.filename = '__apm_resource_pack_ldinc__/graphics/masks/boiler/hr-boiler-S-idle.png'
layer.tint = apm.power.color.boiler_tier_2
table.insert(boiler.pictures.south.structure.layers, layer)

layer = table.deepcopy(boiler.pictures.west.structure.layers[1])
layer.filename = '__apm_resource_pack_ldinc__/graphics/masks/boiler/hr-boiler-W-idle.png'
layer.tint = apm.power.color.boiler_tier_2
table.insert(boiler.pictures.west.structure.layers, layer)

data:extend({ boiler })
