if not apm.lib.features.power.compat.safthelamb then
	return
end

local recipe, ok = apm.lib.utils.recipe.get.by_name("woodchips")

if ok then
	apm.lib.utils.recipe.category.change(recipe, "apm_crusher")
end

apm.lib.utils.recipe.ingredient.replace_all("charcoal", "apm_charcoal")
apm.lib.utils.recipe.result.replace_all("charcoal", "apm_charcoal")
apm.lib.utils.recipe.remove("charcoal")
apm.lib.utils.recipe.remove("coke-from-charcoal")


local coke_from_charcoal = data.raw.recipe["coke-from-charcoal"]
if coke_from_charcoal and coke_from_charcoal.categories then
	local categories = {}

	for _, category in ipairs(coke_from_charcoal.categories) do
		if data.raw["recipe-category"][category] then categories[#categories + 1] = category end
	end

	coke_from_charcoal.categories = #categories > 0 and categories or { "crafting" }
end

local mined = { charcoal = "apm_charcoal", resin = "apm_resin" }
for _, entity_type in ipairs({ "tree", "simple-entity", "plant" }) do
	for _, entity in pairs(data.raw[entity_type] or {}) do
		local minable = entity.minable

		for _, result in pairs(minable and minable.results or {}) do
			if mined[result.name] and data.raw.item[mined[result.name]] then
				result.name = mined[result.name]
			end
		end

		if minable and mined[minable.result] then
			minable.result = mined[minable.result]
		end
	end
end


if apm.lib.utils.item.exist("resin") then
	apm.lib.utils.recipe.ingredient.replace_all("resin", "apm_resin")
	apm.lib.utils.recipe.result.replace_all("resin", "apm_resin")
	apm.lib.utils.recipe.remove("resin")
end
