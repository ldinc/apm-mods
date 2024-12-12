require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/modules.lua'

APM_LOG_HEADER(self)

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function ParticleFilter(i)
	local bonus = 0.075 * i * -1

	---@type data.ModulePrototype
	local item = {
		type = "module",
		name = "apm_particle_filter_" .. i,
		category = "pollution-clean",
		localised_name = { "item-name.apm_particle_filter", tostring(i) },
		localised_description = { "item-description.apm_particle_filter" },
		icons = {
			{ icon = apm.power.icons.path.particle_filter_module .. tostring(i) .. '.png', icon_size = 64 }
		},
		tier = i,
		subgroup = "apm_power_modules",
		order = 'aa_a[' .. i .. ']',
		stack_size = 100,
		effect = { pollution = bonus },

		weight = apm.lib.utils.constants.value.weight.module,
	}

	data:extend({ item })
end

-- Action ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
for i = 1, 3 do
	ParticleFilter(i)
end
