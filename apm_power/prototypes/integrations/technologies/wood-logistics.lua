if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.technology.remove.recipe_from_unlock("basic-wood-logistics", "copper-cable")
apm.lib.utils.technology.trigger.set.craft_item("basic-wood-logistics", "apm_treated_wood_planks", 50)

apm.lib.utils.technology.remove.prerequisites_all("logistics")
apm.lib.utils.technology.add.prerequisites("logistics", "apm_power_electricity")
apm.lib.utils.technology.add.prerequisites("logistics", "basic-wood-logistics")
apm.lib.utils.technology.mod.unit_count("logistics", 100)
apm.lib.utils.technology.mod.unit_time("logistics", 25)
apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("logistics")

local recipies = {
	"apm_treated_wood_planks_1",
	"apm_treated_wood_planks_1b",
	"apm_treated_wood_planks_2",
	"apm_treated_wood_planks_2b",
}

for _, name in ipairs(recipies) do
	local item_name = name .. "_lumber_mill"

	apm.lib.utils.technology.add.recipe_for_unlock("advanced-carpentry", item_name)
end
