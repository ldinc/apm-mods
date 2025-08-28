if mods["bzlead"] then
	local recipe = apm.lib.utils.recipe.clone("stone-brick", "apm_dry_stone_brick")

	if recipe then
		apm.lib.utils.recipe.category.change("apm_dry_stone_brick", "apm_press")
		apm.lib.utils.recipe.ingredient.remove_all("apm_dry_stone_brick")
		apm.lib.utils.recipe.ingredient.mod("apm_dry_stone_brick", "apm_crushed_stone", 6)

		local base = apm.lib.utils.icon.get.from_item("stone-brick")
		local ico = apm.lib.utils.icon.get.from_item("apm_crushed_stone")
		subicon = apm.lib.utils.icons.mod(ico, 0.6, { -8, -8 })

		local icons = apm.lib.utils.icon.merge({
			base,
			subicon,
		})

		apm.lib.utils.recipe.set.icons("apm_dry_stone_brick", icons)
	end
end

if mods["bzsilicon"] then
	apm.lib.utils.recipe.remove("basic-crusher")
end
