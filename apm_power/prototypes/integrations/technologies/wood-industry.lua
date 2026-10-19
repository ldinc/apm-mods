if not apm.lib.features.power.compat.safthelamb then
	return
end

---@type string
local crusher = apm.lib.utils.technology.find.technology_by_recipe("apm_wood_pellets_1") --[[@as string]]

if crusher then
	apm.lib.utils.technology.remove.recipe_from_unlock("kiln-smelting", "woodchips")
	apm.lib.utils.technology.add.recipe_for_unlock(crusher, "woodchips")
end

apm.lib.utils.technology.delete("resin-processing")
