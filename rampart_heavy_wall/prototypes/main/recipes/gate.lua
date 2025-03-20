require("lib.const")

local name = rampant_heavy_wall.lib.const.gate.name
local wall = rampant_heavy_wall.lib.const.wall.name

local hp = rampant_heavy_wall.lib.features.wall_hp()

local base_K = rampant_heavy_wall.lib.features.K()

---@type int
local K = math.ceil(hp/100)*base_K

---@type (data.FluidIngredientPrototype|data.ItemIngredientPrototype)[]?
local ingredients = {
  {type = "item", name = wall, amount = 1},
	{type = "item", name = "steel-plate", amount = 2},
	{type = "item", name = "processing-unit", amount = 2},
}

local custom_ingredients = rampant_heavy_wall.lib.features.custom_recipe_for_gate()

if custom_ingredients then
	ingredients = custom_ingredients
end

---@type data.RecipePrototype
local recipe = {
  type = "recipe",
  name = name,
  enabled = false,
  ingredients = ingredients,
  results = {{type="item", name=name, amount=1}}
}

data:extend({recipe})