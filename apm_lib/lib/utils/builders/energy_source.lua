require 'util'
require('lib.log')
require('lib.utils.builders.fluid_box')

local self = 'lib.utils.builders.energy_source'

function apm.lib.utils.builders.energy_source.new_steam(emmisions_pm, smoke, fluid_box, volume, min_t, max_t)
	if emmisions_pm == nil then
		emmisions_pm = apm.power.constants.emissions.t1
	end

	if not smoke then
		smoke = {apm.lib.utils.builders.smoke.light}
	end

	if volume == nil then
		volume = 1000
	end

	if min_t == nil then
		min_t = 100.0
	end

	if max_t == nil then
		max_t = 550.0
	end

	if not fluid_box then
		fluid_box = apm.lib.utils.builders.fluid_box.new_steam_input(volume, min_t, max_t)
	end

	return {
		type = "fluid",
		fluid_box = fluid_box,
		smoke = smoke,
		burns_fluid = false,
		scale_fluid_usage = true,
		maximum_temperature = max_t,
	}
end

function apm.lib.utils.builders.energy_source.new_electric(emmisions_pm, drain)
	if emmisions_pm == nil then
		emmisions_pm = apm.power.constants.emissions.t2
	end

	return {
		type = 'electric',
		usage_priority = "secondary-input",
		emissions_per_minute = emmisions_pm,
		drain = drain,
	}
end

function apm.lib.utils.builders.energy_source.new_burner(fuel_categories, emmisions_pm, smoke, fuel_inventory_size, eff)
	if not emmisions_pm then
		emmisions_pm = apm.power.constants.emissions.t0
	end

	if not fuel_inventory_size then
		fuel_inventory_size = 1
	end

	if not eff then
		eff = 1
	end

	if not smoke then 
		smoke = {apm.lib.utils.builders.smoke.dark}
	end

	return {
		type = "burner",
		fuel_categories = fuel_categories,
		effectivity = eff,
		fuel_inventory_size = fuel_inventory_size,
		burnt_inventory_size = 1,
		emissions_per_minute = emmisions_pm,
		smoke = smoke,
	}
end
