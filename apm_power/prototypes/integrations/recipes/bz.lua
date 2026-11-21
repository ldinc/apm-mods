if mods["bzlead"] or mods["bzlead2"] then
	local recipe = apm.lib.utils.recipe.clone("stone-brick", "apm_dry_stone_brick")

	if recipe then
		apm.lib.utils.recipe.category.change(recipe, "apm_press")
		apm.lib.utils.recipe.ingredient.remove_all("apm_dry_stone_brick")
		apm.lib.utils.recipe.ingredient.mod("apm_dry_stone_brick", "apm_crushed_stone", 6)

		local base = apm.lib.utils.icon.get.from_item("stone-brick")
		local ico = apm.lib.utils.icon.get.from_item("apm_crushed_stone")
		local subicon = apm.lib.utils.icons.mod(ico, 0.6, { -8, -8 })

		local icons = apm.lib.utils.icon.merge({
			base,
			subicon,
		})

		apm.lib.utils.recipe.set.icons("apm_dry_stone_brick", icons)
	end
end

if mods["bzsilicon"] or mods["bzsilicon2"] then
	apm.lib.utils.recipe.remove("basic-crusher")
end
