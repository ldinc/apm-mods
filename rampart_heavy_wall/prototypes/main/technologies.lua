require("lib.const")

local wall = rampant_heavy_wall.lib.const.wall.name
local gate = rampant_heavy_wall.lib.const.gate.name
local tint = rampant_heavy_wall.lib.const.wall.tint

---@type data.TechnologyPrototype
local wall_tech = {
	type = "technology",
	name = wall,
	icons = {
		{
			icon = "__base__/graphics/technology/stone-wall.png",
			icon_size = 256,
			tint = tint,
		},
	},
	effects =
	{
		{
			type = "unlock-recipe",
			recipe = wall,
		},
		{
			type = "unlock-recipe",
			recipe = gate,
		}
	},
	prerequisites = {
		"stone-wall",
		"gate",
		"concrete",
		"processing-unit"
	},
	unit =
	{
		count = 300,
		ingredients =
		{
			{ "automation-science-pack", 1 },
			{ "logistic-science-pack",   1 },
			{ "chemical-science-pack",   1 },
			{ "military-science-pack",  1 },
		},
		time = 30
	}
}

if data.raw["technology"]["rampant-arsenal-technology-stone-walls-2"] then
	table.insert(
		wall_tech.prerequisites,
		"rampant-arsenal-technology-stone-walls-2"
	)
end

data:extend({ wall_tech })
