require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/main/generate_metal.lua'

APM_LOG_HEADER(self)

local apm_recycler_integration_bob = settings.startup["apm_recycler_integration_bob"].value
local apm_recycler_integration_angel = settings.startup["apm_recycler_integration_angel"].value
local apm_recycler_integration_earendel = settings.startup["apm_recycler_integration_earendel"].value
local apm_recycler_integration_kingarthur = settings.startup["apm_recycler_integration_kingarthur"].value
local apm_recycler_integration_sctm = settings.startup["apm_recycler_integration_sctm"].value

local apm_recycler_compat_bob = settings.startup["apm_recycler_compat_bob"].value
local apm_recycler_compat_angel = settings.startup["apm_recycler_compat_angel"].value
local apm_recycler_compat_earendel = settings.startup["apm_recycler_compat_earendel"].value
local apm_recycler_compat_kingarthur = settings.startup["apm_recycler_compat_kingarthur"].value
local apm_recycler_compat_sctm = settings.startup["apm_recycler_compat_sctm"].value

APM_LOG_SETTINGS(self, 'apm_recycler_integration_bob', apm_recycler_integration_bob)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_angel', apm_recycler_integration_angel)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_earendel', apm_recycler_integration_earendel)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_kingarthur', apm_recycler_integration_kingarthur)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_sctm', apm_recycler_integration_sctm)

APM_LOG_SETTINGS(self, 'apm_recycler_compat_bob', apm_recycler_compat_bob)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_angel', apm_recycler_compat_angel)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_earendel', apm_recycler_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_kingarthur', apm_recycler_compat_kingarthur)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_sctm', apm_recycler_compat_sctm)

-- ----------------------------------------------------------------------------------------------------------------------
-- apm.lib.utils.recycling.metal.add(name, tint, output, output_category, wight, output_probability, t_catalysts,
--                                   t_output_byproducts, b_own_tech, t_tech_prerequisites, output_amount_overwrite)
-- ----------------------------------------------------------------------------------------------------------------------
local is_angelssmelting = mods.angelssmelting and apm_recycler_compat_angel
local is_bobsplates = mods.bobplates and apm_recycler_compat_bob
local is_bobsores = mods.bobores and apm_recycler_compat_bob
local is_bobwarfare = mods.bobwarfare and apm_recycler_compat_bob
local is_pycoaltba = mods.PyCoalTBaA and apm_recycler_compat_kingarthur
local is_apm_power = mods.apm_power

-- ----------------------------------------------------------------------------------------------------------------------
-- normal or vanilla tier metals
-- ----------------------------------------------------------------------------------------------------------------------
if is_angelssmelting and not is_pycoaltba then
	local steel_wight = 3
	if is_apm_power then steel_wight = 4 end
	apm.lib.utils.recycling.metal.add { name = 'iron', tint = { r = 0.46, g = 0.53, b = 0.59 }, output = 'liquid-molten-iron', output_category = 'induction-smelting', wight = 1, b_own_tech = true, t_tech_prerequisites = { 'angels-iron-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'copper', tint = { r = 0.68, g = 0.47, b = 0.40 }, output = 'liquid-molten-copper', output_category = 'induction-smelting', wight = 1, b_own_tech = true, t_tech_prerequisites = { 'angels-copper-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'steel', tint = { r = 0.68, g = 0.70, b = 0.73 }, output = 'liquid-molten-steel', output_category = 'induction-smelting', wight = steel_wight, b_own_tech = true, t_tech_prerequisites = { 'angels-steel-smelting-1' } }
elseif is_bobsplates and not is_pycoaltba then
	local steel_prerequisites = { 'steel-processing' }
	if is_apm_power then steel_prerequisites = { 'apm_puddling_furnace_0' } end
	apm.lib.utils.recycling.metal.add { name = 'iron', tint = { r = 0.75, g = 0.76, b = 0.77 }, output = 'iron-plate', wight = 1 }
	apm.lib.utils.recycling.metal.add { name = 'copper', tint = { r = 0.83, g = 0.45, b = 0.37 }, output = 'copper-plate', wight = 1 }
	apm.lib.utils.recycling.metal.add { name = 'steel', tint = { r = 0.75, g = 0.76, b = 0.69 }, output = 'steel-plate', wight = 3, b_own_tech = true, t_tech_prerequisites = steel_prerequisites }
elseif is_angelssmelting and is_pycoaltba then
	apm.lib.utils.recycling.metal.add { name = 'iron', tint = { r = 0.46, g = 0.53, b = 0.59 }, output = 'liquid-molten-iron', output_category = 'induction-smelting', wight = 1, b_own_tech = true, t_tech_prerequisites = { 'iron-mk01' } }
	apm.lib.utils.recycling.metal.add { name = 'copper', tint = { r = 0.68, g = 0.47, b = 0.40 }, output = 'liquid-molten-copper', output_category = 'induction-smelting', wight = 1, b_own_tech = true, t_tech_prerequisites = { 'angels-copper-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'steel', tint = { r = 0.68, g = 0.70, b = 0.73 }, output = 'liquid-molten-steel', output_category = 'induction-smelting', wight = 3, b_own_tech = true, t_tech_prerequisites = { 'angels-steel-smelting-1' } }
else
	local steel_prerequisites = { 'steel-processing' }
	if is_apm_power then steel_prerequisites = { 'apm_puddling_furnace_0' } end
	apm.lib.utils.recycling.metal.add { name = 'iron', tint = { r = 0.56, g = 0.63, b = 0.74 }, output = 'iron-plate', wight = 1 }
	apm.lib.utils.recycling.metal.add { name = 'copper', tint = { r = 1.00, g = 0.69, b = 0.46 }, output = 'copper-plate', wight = 1 }
	apm.lib.utils.recycling.metal.add { name = 'steel', tint = { r = 0.80, g = 0.80, b = 0.76 }, output = 'steel-plate', wight = 3, b_own_tech = true, t_tech_prerequisites = steel_prerequisites }
end

-- ----------------------------------------------------------------------------------------------------------------------
-- higher tier metals
-- ----------------------------------------------------------------------------------------------------------------------
if is_bobsplates and is_bobsores and is_angelssmelting and not is_pycoaltba then
	apm.lib.utils.recycling.metal.add { name = 'tin', tint = { r = 0.33, g = 0.49, b = 0.36 }, output = 'liquid-molten-tin', output_category = 'induction-smelting', wight = 2, b_own_tech = true, t_tech_prerequisites = { 'angels-tin-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'lead', tint = { r = 0.29, g = 0.30, b = 0.34 }, output = 'liquid-molten-lead', output_category = 'induction-smelting', wight = 2, b_own_tech = true, t_tech_prerequisites = { 'angels-lead-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'bronze', tint = { r = 0.84, g = 0.58, b = 0.21 }, output = 'liquid-molten-bronze', output_category = 'induction-smelting', wight = 5, b_own_tech = true, t_tech_prerequisites = { 'angels-bronze-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'brass', tint = { r = 0.77, g = 0.58, b = 0.38 }, output = 'liquid-molten-brass', output_category = 'induction-smelting', wight = 5, b_own_tech = true, t_tech_prerequisites = { 'angels-brass-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'cobalt', tint = { r = 0.18, g = 0.27, b = 0.40 }, output = 'liquid-molten-cobalt', output_category = 'induction-smelting', wight = 6, b_own_tech = true, t_tech_prerequisites = { 'angels-cobalt-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'cobalt-steel', tint = { r = 0.61, g = 0.70, b = 0.81 }, output = 'liquid-molten-cobalt-steel', output_category = 'induction-smelting', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'angels-cobalt-steel-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'zinc', tint = { r = 0.45, g = 0.73, b = 0.71 }, output = 'liquid-molten-zinc', output_category = 'induction-smelting', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'angels-zinc-smelting-1' } }
	if is_bobwarfare then
		apm.lib.utils.recycling.metal.add { name = 'gunmetal', { r = 0.835, g = 0.380, b = 0.255 }, output = 'liquid-molten-gunmetal', output_category = 'induction-smelting', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'angels-gunmetal-smelting-1' } }
	end
	apm.lib.utils.recycling.metal.add { name = 'nickel', tint = { r = 0.22, g = 0.46, b = 0.44 }, output = 'liquid-molten-nickel', output_category = 'induction-smelting', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'angels-nickel-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'invar', tint = { r = 0.62, g = 0.65, b = 0.53 }, output = 'liquid-molten-invar', output_category = 'induction-smelting', wight = 8, b_own_tech = true, t_tech_prerequisites = { 'angels-invar-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'aluminium', tint = { r = 0.64, g = 0.59, b = 0.30 }, output = 'liquid-molten-aluminium', output_category = 'induction-smelting', wight = 8, b_own_tech = true, t_tech_prerequisites = { 'angels-aluminium-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'silver', tint = { r = 0.84, g = 0.88, b = 0.90 }, output = 'liquid-molten-silver', output_category = 'induction-smelting', wight = 9, b_own_tech = true, t_tech_prerequisites = { 'angels-silver-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'gold', tint = { r = 0.84, g = 0.64, b = 0.21 }, output = 'liquid-molten-gold', output_category = 'induction-smelting', wight = 9, b_own_tech = true, t_tech_prerequisites = { 'angels-gold-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'titanium', tint = { r = 0.46, g = 0.36, b = 0.45 }, output = 'liquid-molten-titanium', output_category = 'induction-smelting', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'angels-titanium-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'nitinol', tint = { r = 0.37, g = 0.30, b = 0.58 }, output = 'liquid-molten-nitinol', output_category = 'induction-smelting', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'angels-nitinol-smelting-1' } }
	--apm.lib.utils.recycling.metal.add{name='tungsten', tint={r= 0.59, g = 0.49, b = 0.43}, output='liquid-molten-tungsten', output_category='induction-smelting', wight=10, b_own_tech=true, t_tech_prerequisites={'angels-tungsten-smelting-1'}}
	apm.lib.utils.recycling.metal.add { name = 'tungsten', tint = { r = 0.50, g = 0.36, b = 0.23 }, output = 'tungsten-plate', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'angels-tungsten-smelting-1' } }
elseif is_bobsplates and is_bobsores and not is_angelssmelting and not is_pycoaltba then
	apm.lib.utils.recycling.metal.add { name = 'tin', tint = { r = 0.57, g = 0.57, b = 0.57 }, output = 'tin-plate', wight = 2, b_own_tech = true }
	apm.lib.utils.recycling.metal.add { name = 'lead', tint = { r = 0.60, g = 0.75, b = 0.90 }, output = 'lead-plate', wight = 2, b_own_tech = true }
	apm.lib.utils.recycling.metal.add { name = 'bronze', tint = { r = 0.71, g = 0.58, b = 0.45 }, output = 'bronze-alloy', wight = 5, b_own_tech = true, t_tech_prerequisites = { 'alloy-processing-1' } }
	apm.lib.utils.recycling.metal.add { name = 'brass', tint = { r = 0.74, g = 0.72, b = 0.48 }, output = 'brass-alloy', wight = 5, b_own_tech = true, t_tech_prerequisites = { 'zinc-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'cobalt', tint = { r = 0.26, g = 0.36, b = 0.49 }, output = 'cobalt-plate', wight = 6, b_own_tech = true, t_tech_prerequisites = { 'cobalt-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'cobalt-steel', tint = { r = 0.62, g = 0.69, b = 0.77 }, output = 'cobalt-steel-alloy', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'cobalt-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'zinc', tint = { r = 0.58, g = 0.56, b = 0.58 }, output = 'zinc-plate', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'zinc-processing' } }
	if is_bobwarfare then
		apm.lib.utils.recycling.metal.add { name = 'gunmetal', tint = { r = 0.817, g = 0.677, b = 0.221 }, output = 'gunmetal-alloy', wight = 7, b_own_tech = true, { 'zinc-processing' } }
	end
	apm.lib.utils.recycling.metal.add { name = 'nickel', tint = { r = 0.82, g = 0.77, b = 0.68 }, output = 'nickel-plate', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'nickel-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'invar', tint = { r = 0.63, g = 0.60, b = 0.52 }, output = 'invar-alloy', wight = 8, b_own_tech = true, t_tech_prerequisites = { 'invar-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'aluminium', tint = { r = 0.95, g = 0.95, b = 0.95 }, output = 'aluminium-plate', wight = 8, b_own_tech = true, t_tech_prerequisites = { 'aluminium-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'silver', tint = { r = 0.83, g = 0.87, b = 0.91 }, output = 'silver-plate', wight = 9, b_own_tech = true }
	apm.lib.utils.recycling.metal.add { name = 'gold', tint = { r = 0.77, g = 0.55, b = 0.12 }, output = 'gold-plate', wight = 9, b_own_tech = true, t_tech_prerequisites = { 'gold-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'titanium', tint = { r = 0.97, g = 0.90, b = 0.97 }, output = 'titanium-plate', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'titanium-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'nitinol', tint = { r = 0.65, g = 0.66, b = 0.65 }, output = 'nitinol-alloy', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'nitinol-processing' } }
	apm.lib.utils.recycling.metal.add { name = 'tungsten', tint = { r = 0.25, g = 0.25, b = 0.25 }, output = 'tungsten-plate', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'tungsten-processing' } }
elseif is_angelssmelting and is_pycoaltba then
	apm.lib.utils.recycling.metal.add { name = 'tin', tint = { r = 0.33, g = 0.49, b = 0.36 }, output = 'liquid-molten-tin', output_category = 'induction-smelting', wight = 2, b_own_tech = true, t_tech_prerequisites = { 'tin-mk02' }, output_amount_overwrite = 4 }
	apm.lib.utils.recycling.metal.add { name = 'lead', tint = { r = 0.29, g = 0.30, b = 0.34 }, output = 'liquid-molten-lead', output_category = 'induction-smelting', wight = 2, b_own_tech = true, t_tech_prerequisites = { 'lead-mk02' }, output_amount_overwrite = 4 }
	apm.lib.utils.recycling.metal.add { name = 'bronze', tint = { r = 0.84, g = 0.58, b = 0.21 }, output = 'liquid-molten-bronze', output_category = 'induction-smelting', wight = 5, b_own_tech = true, t_tech_prerequisites = { 'angels-bronze-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'brass', tint = { r = 0.77, g = 0.58, b = 0.38 }, output = 'liquid-molten-brass', output_category = 'induction-smelting', wight = 5, b_own_tech = true, t_tech_prerequisites = { 'angels-brass-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'cobalt', tint = { r = 0.18, g = 0.27, b = 0.40 }, output = 'liquid-molten-cobalt', output_category = 'induction-smelting', wight = 6, b_own_tech = true, t_tech_prerequisites = { 'angels-cobalt-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'cobalt-steel', tint = { r = 0.61, g = 0.70, b = 0.81 }, output = 'liquid-molten-cobalt-steel', output_category = 'induction-smelting', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'angels-cobalt-steel-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'zinc', tint = { r = 0.45, g = 0.73, b = 0.71 }, output = 'liquid-molten-zinc', output_category = 'induction-smelting', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'zinc-mk01' }, output_amount_overwrite = 4 }
	if is_bobwarfare then
		apm.lib.utils.recycling.metal.add { name = 'gunmetal', tint = { r = 0.835, g = 0.380, b = 0.255 }, output = 'liquid-molten-gunmetal', output_category = 'induction-smelting', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'angels-gunmetal-smelting-1' } }
	end
	apm.lib.utils.recycling.metal.add { name = 'nickel', tint = { r = 0.22, g = 0.46, b = 0.44 }, output = 'liquid-molten-nickel', output_category = 'induction-smelting', wight = 7, b_own_tech = true, t_tech_prerequisites = { 'nickel-mk01' }, 4 }
	apm.lib.utils.recycling.metal.add { name = 'invar', tint = { r = 0.62, g = 0.65, b = 0.53 }, output = 'liquid-molten-invar', output_category = 'induction-smelting', wight = 8, b_own_tech = true, t_tech_prerequisites = { 'angels-invar-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'aluminium', tint = { r = 0.64, g = 0.59, b = 0.30 }, output = 'liquid-molten-aluminium', output_category = 'induction-smelting', wight = 8, b_own_tech = true, t_tech_prerequisites = { 'aluminium-mk01', 4 } }
	apm.lib.utils.recycling.metal.add { name = 'silver', tint = { r = 0.84, g = 0.88, b = 0.90 }, output = 'liquid-molten-silver', output_category = 'induction-smelting', wight = 9, b_own_tech = true, t_tech_prerequisites = { 'angels-silver-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'gold', tint = { r = 0.84, g = 0.64, b = 0.21 }, output = 'liquid-molten-gold', output_category = 'induction-smelting', wight = 9, b_own_tech = true, t_tech_prerequisites = { 'angels-gold-smelting-1' } }
	apm.lib.utils.recycling.metal.add { name = 'titanium', tint = { r = 0.46, g = 0.36, b = 0.45 }, output = 'liquid-molten-titanium', output_category = 'induction-smelting', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'titanium-mk02' }, 40 }
	apm.lib.utils.recycling.metal.add { name = 'nitinol', tint = { r = 0.37, g = 0.30, b = 0.58 }, output = 'liquid-molten-nitinol', output_category = 'induction-smelting', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'angels-nitinol-smelting-1' } }
	--apm.lib.utils.recycling.metal.add{name='tungsten', tint={r= 0.59, g = 0.49, b = 0.43}, output='liquid-molten-tungsten', output_category='induction-smelting', wight=10, b_own_tech=true, t_tech_prerequisites={'angels-tungsten-smelting-1'}}
	apm.lib.utils.recycling.metal.add { name = 'tungsten', tint = { r = 0.50, g = 0.36, b = 0.23 }, output = 'tungsten-plate', wight = 10, b_own_tech = true, t_tech_prerequisites = { 'angels-tungsten-smelting-1' } }
end
