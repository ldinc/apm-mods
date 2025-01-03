if not apm.lib.features.power.compat.safthelamb then
	return
end

local crafting_category = { "crafting-or-carpentry" }

apm.lib.utils.assembler.add.crafting_categories("apm_assembling_machine_0", crafting_category)
apm.lib.utils.assembler.add.crafting_categories("apm_assembling_machine_1", crafting_category)


local item_icon = apm.lib.utils.icon.get.from_item('apm_treated_wood_planks')

---@type data.RecipePrototype
local handcrafted_wood_planks = {
	type = "recipe",
	name = "apm_treated_wood_planks_handcraft_only",
	category = 'crafting-or-carpentry',
	subgroup = "apm_power_intermediates",
	order = 'ag_a',
	icons = item_icon,

	enabled = true,
	energy_required = 4,
	ingredients = {
		{ type = "item", name = "wood", amount = 10 },
	},
	results = {
		{ type = 'item', name = 'apm_treated_wood_planks', amount = 10 },
	},
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm.lib.features.show.made_in,
}

data:extend({ handcrafted_wood_planks })

apm.lib.utils.recipe.ingredient.replace_all("lumber", "apm_treated_wood_planks", 2)
apm.lib.utils.recipe.disable("lumber")
apm.lib.utils.recipe.set.hidden("lumber", true)

--- tuning recipies

apm.lib.utils.recipe.ingredient.replace("wood-transport-belt", "copper-cable", "iron-stick")
apm.lib.utils.recipe.ingredient.replace("wood-splitter", "copper-cable", "iron-stick", 0.2)
apm.lib.utils.recipe.ingredient.mod("wood-splitter", "iron-gear-wheel", 2)

apm.lib.utils.recipe.ingredient.remove("inserter", "apm_treated_wood_planks")
apm.lib.utils.recipe.ingredient.remove("long-handed-inserter", "apm_treated_wood_planks")

local recipies = {
	["apm_treated_wood_planks_1"] = "apm_saw_blade_iron",
	["apm_treated_wood_planks_1b"] = "apm_saw_blade_iron",
	["apm_treated_wood_planks_2"] = "apm_saw_blade_steel",
	["apm_treated_wood_planks_2b"] = "apm_saw_blade_steel",
}

for name, saw in pairs(recipies) do
	local new_recipe = apm.lib.utils.recipe.clone(name, name .. "_lumber_mill")

	if new_recipe then
		apm.lib.utils.recipe.category.change(new_recipe.name, "carpentry")

		local item_icon_a = apm.lib.utils.icon.get.from_item('apm_treated_wood_planks')
		local item_icon_b = apm.lib.utils.icon.get.from_item(saw)
		item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
		local item_icon_c = { apm.lib.icons.dynamics.t3 }
		local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

		apm.lib.utils.recipe.set.icons(new_recipe.name, icons)

		data.extend({ new_recipe })
	end
end

if mods["aai-loaders"] and apm.lib.features.power.compat.earendel then
	apm.lib.utils.recipe.ingredient.remove("aai-wood-loader", "apm_simple_engine")
	apm.lib.utils.recipe.ingredient.mod("aai-wood-loader", "apm_mechanical_relay", 25)
end