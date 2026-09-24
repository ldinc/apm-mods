-- Tips and tricks of the APM mods: the shared category, the title entry and the radiation tip.
-- The inserter tips are in apm_power: its burner machines use them, and the inserter
-- functions are on by default only when apm_power is enabled.

data:extend({
	{
		type = "tips-and-tricks-item-category",
		name = "apm",
		order = "z-[apm]",
	},
	{
		type = "tips-and-tricks-item",
		name = "apm-introduction",
		category = "apm",
		order = "a",
		is_title = true,
		trigger = { type = "time-elapsed", ticks = 60 * 60 * 5 },
	},
	{
		type = "tips-and-tricks-item",
		name = "apm-radiation",
		category = "apm",
		order = "z-a",
		indent = 1,
		tag = "[item=uranium-235]",
		dependencies = { "apm-introduction" },
		trigger = { type = "research", technology = "uranium-processing" },
		-- the real radiation script runs in the simulation
		simulation = apm.lib.utils.tips.simulation(
			"__apm_lib_ldinc__/simulations/radiation.lua", { "apm_lib_ldinc" }, { hide_health_bars = false }
		),
	},
})
