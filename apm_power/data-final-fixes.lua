require("prototypes.integrations.fuel")
require("prototypes.integrations.overwrites")
require("prototypes.integrations.recipes")
require("prototypes.integrations.items")
require("prototypes.integrations.entities")
require("prototypes.integrations.bots")
require("prototypes.integrations.recipe-categories")
require("prototypes.integrations.icons")
require("prototypes.integrations.tiles")
require("prototypes.integrations.technologies")
require("prototypes.integrations.final-overwrites")
require("prototypes.integrations.patches")
require("prototypes.main.map-gen-presets")

-- generate recipies for sinkhole

local amount = tonumber(settings.startup["apm_sinkhole_fluid_rate"].value)

if not amount then
	amount = 1
end


local get_icons = function(prototype)
	if prototype.icons then
		return table.deepcopy(prototype.icons)
	else
		return { {
			icon = prototype.icon,
			icon_size = prototype.icon_size,
			icon_mipmaps = prototype.icon_mipmaps
		} }
	end
end

for k, v in pairs(data.raw.fluid) do
	local newicons = get_icons(v)

	---@type data.RecipePrototype
	local recipe =
	{
		type = "recipe",
		name = v.name .. "-sinkhole"
	}
	recipe.categories = { "apm_sinkhole" }
	recipe.subgroup = "fluid-recipes"
	recipe.enabled = true
	recipe.hidden = true
	recipe.energy_required = 20
	recipe.ingredients =
	{
		{ type = "fluid", name = v.name, amount = amount }
	}
	recipe.results = {}
	recipe.icons = newicons
	recipe.icon_size = 32
	recipe.order = "z[sinkhole]"

	data:extend({ recipe })
end
