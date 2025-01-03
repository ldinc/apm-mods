if not apm.lib.features.power.compat.safthelamb then
	return
end

--- "wood-logistics" w\o AAI and others..
local original_wood_logistics = "wood-logistics"

apm.lib.utils.technology.remove.prerequisites_all(original_wood_logistics)
apm.lib.utils.technology.add.prerequisites(original_wood_logistics, "apm_crusher_machine_0")
-- apm.lib.utils.technology.trigger.set.craft_item(original_wood_logistics, "wood-transport-belt", 50)

local tech = apm.lib.utils.technology.get.by_name(original_wood_logistics)
if tech then
	tech.unit = {
		ingredients = {
			{ "apm_industrial_science_pack", 1 },
		},
		time = 5,
		count = 15,
	}
end

apm.lib.utils.technology.remove.prerequisites_all("logistics")
apm.lib.utils.technology.add.prerequisites("logistics", "apm_power_electricity")
apm.lib.utils.technology.add.prerequisites("logistics", original_wood_logistics)
apm.lib.utils.technology.mod.unit_count("logistics", 100)
apm.lib.utils.technology.mod.unit_time("logistics", 25)
apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("logistics")

local recipies = {
	"apm_treated_wood_planks_1",
	"apm_treated_wood_planks_1b",
	"apm_treated_wood_planks_2",
	"apm_treated_wood_planks_2b",
}

local lumber_mill_tech = "advanced-carpentry"

for _, name in ipairs(recipies) do
	local item_name = name .. "_lumber_mill"

	apm.lib.utils.technology.add.recipe_for_unlock(lumber_mill_tech, item_name)
end

apm.lib.utils.technology.add.prerequisites(lumber_mill_tech, "apm_treated_wood_planks-1")
apm.lib.utils.technology.add.prerequisites(lumber_mill_tech, "apm_treated_wood_planks-2")
apm.lib.utils.technology.add.prerequisites(lumber_mill_tech, "apm_treated_wood_planks-3")

if mods["aai-industry"] and apm.lib.features.power.compat.earendel then
	local wood_logistics = "basic-wood-logistics"
	apm.lib.utils.technology.trigger.set.craft_item(wood_logistics, "apm_treated_wood_planks", 50)

	apm.lib.utils.technology.remove.prerequisites_all(wood_logistics)
	if apm.lib.utils.technology.exist("burner-mechanics") then
		apm.lib.utils.technology.add.prerequisites(wood_logistics, "burner-mechanics")
	else
		apm.lib.utils.technology.add.prerequisites(wood_logistics, "apm_crusher_machine_0")
	end

	apm.lib.utils.technology.add.prerequisites(original_wood_logistics, wood_logistics)
end

if mods["aai-loaders"] and apm.lib.features.power.compat.earendel then
	local loader_tech = "aai-wood-loader"

	apm.lib.utils.technology.force.update_science_packs(loader_tech)

	local lubricant_enabled = settings.startup["aai-loaders-mode"].value == "lubricated"

	if lubricant_enabled then
		apm.lib.utils.technology.add.prerequisites(loader_tech, "apm_press_machine_0")
	end
end
