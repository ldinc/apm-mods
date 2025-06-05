require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/modules.lua'

local item_sounds = require("__base__.prototypes.item_sounds")

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

		inventory_move_sound = item_sounds.module_inventory_move,
    pick_sound = item_sounds.module_inventory_pickup,
    drop_sound = item_sounds.module_inventory_move,

		-- beacon visualization
		beacon_tint =
    {
      primary = {255.0/54.0, 255.0/79.0, 255.0/105.0, 1.000}, -- #364f69ff
      secondary = {255.0/200.0, 255.0/218.0, 255.0/219.0, 1.000}, -- #c8dadbff
    },
		art_style = "vanilla",
		requires_beacon_alt_mode = false,
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
