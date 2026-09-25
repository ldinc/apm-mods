-- Tips and tricks for the apm_lib inserter functions, with simulations. The category and the
-- title entry "apm-introduction" come from apm_lib (prototypes/tips.lua).
-- `mods = { "apm_lib_ldinc" }` runs apm_lib's runtime script in the simulations, so they show
-- the real behaviour instead of a copy of it.

---@param file string
---@return SimulationDefinition
local function simulation(file)
	return apm.lib.utils.tips.simulation("__apm_power_ldinc__/simulations/" .. file, { "apm_lib_ldinc" })
end

data:extend({
	{
		type = "tips-and-tricks-item",
		name = "apm-fuel-chaining",
		category = "apm",
		order = "b",
		indent = 1,
		tag = "[entity=apm_assembling_machine_0][item=coal]",
		dependencies = { "apm-introduction" },
		trigger = { type = "build-entity", entity = "apm_assembling_machine_0", count = 3 },
		simulation = simulation("fuel-chaining.lua"),
	},
	{
		type = "tips-and-tricks-item",
		name = "apm-fuel-leech",
		category = "apm",
		order = "c",
		indent = 1,
		tag = "[entity=burner-inserter]",
		dependencies = { "apm-introduction", "burner-inserter-refueling" },
		trigger = { type = "build-entity", entity = "burner-inserter", count = 10 },
		simulation = simulation("fuel-leech.lua"),
	},
	{
		type = "tips-and-tricks-item",
		name = "apm-ash-chaining",
		category = "apm",
		order = "d",
		indent = 1,
		tag = "[item=apm_generic_ash]",
		dependencies = { "apm-fuel-chaining" },
		trigger = { type = "build-entity", entity = "apm_assembling_machine_0", count = 6 },
		simulation = simulation("ash-chaining.lua"),
	},
})
