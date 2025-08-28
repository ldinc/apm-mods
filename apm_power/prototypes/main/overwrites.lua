require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/overwrites.lua"

APM_LOG_HEADER(self)

-- ----------------------------------------------------------------------------------------------------------
-- This block should make this mod more compatible with other by setting the basic fuel categories for burners
-- apm.lib.utils.entities.set.fuel_categoriy_to_all_with_condition(entity_type, conditional_category, t_categories)
-- ----------------------------------------------------------------------------------------------------------

local target_category = "chemical"
local change_to = { "chemical", "apm_refined_chemical" }
local entities_type_list = {
	"assembling-machine",
	"inserter",
	"lab",
	"furnace",
	"generator",
	"boiler",
	"car",
	"locomotive",
	"mining-drill",
	"pump",
	"reactor"
}

APM_LOG_INFO(self, "", "BEGIN: basic overwrites of the fuel categories")

for _, entity_type in ipairs(entities_type_list) do
	apm.lib.utils.entities.set.fuel_categoriy_to_all_with_condition(
		entity_type,
		target_category,
		change_to
	)
end

APM_LOG_INFO(self, "", "END: basic overwrites of the fuel categories")
-- ----------------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------

-- tanks
apm.lib.utils.car.set.fuel_category("tank", { "apm_refined_chemical" })

-- Boilers
apm.lib.utils.boiler.overhaul("boiler", 1)
apm.lib.utils.boiler.set.next_upgrade("boiler", "apm_boiler_2")
apm.lib.utils.boiler.overhaul("apm_boiler_2", 2)

-- Generators
apm.lib.utils.generator.overhaul("steam-engine", 1)
apm.lib.utils.generator.set.next_upgrade("steam-engine", "apm_steam_engine_2")
apm.lib.utils.generator.overhaul("apm_steam_engine_2", 2)

-- Furnaces
apm.lib.utils.furnace.overhaul("stone-furnace", false)
apm.lib.utils.furnace.overhaul("steel-furnace", true)

-- Burner inserter
apm.lib.utils.inserter.burner.overhaul("burner-inserter")
apm.lib.utils.item.overwrite.group("burner-inserter", "apm_power_inserter", "ab_a")
apm.lib.utils.inserter.burner.overhaul("apm_burner_long_inserter")

--- [assemblers]
apm.lib.utils.assembler.add.fluid_connections("assembling-machine-1", 1)
apm.lib.utils.assembler.add.crafting_categories("assembling-machine-1", { "crafting-with-fluid" })
apm.lib.utils.assembler.mod.crafting_speed("assembling-machine-1", 0.75)
apm.lib.utils.assembler.mod.crafting_speed("assembling-machine-2", 1)

apm.lib.utils.assembler.mod.module_specification("assembling-machine-1", 2)
apm.lib.utils.assembler.mod.module_specification("assembling-machine-2", 3)
apm.lib.utils.assembler.mod.module_specification("assembling-machine-3", 4)

-- Miner
apm.lib.utils.mining_drill.burner.overhaul("burner-mining-drill", 1)
apm.lib.utils.icon.add_tier_lable("burner-mining-drill", 1)
apm.lib.utils.mining_drill.burner.overhaul("apm_burner_miner_drill_2", 2)

--labs
apm.lib.utils.lab.overhaul("lab")

-- science-packs
apm.lib.utils.recipe.disable("automation-science-pack")

-- miner
apm.lib.utils.item.overwrite.group("burner-mining-drill", "apm_power_machines_miner", "aa_a")

-- bots
apm.lib.utils.bot.logistic.overhaul("logistic-robot", 1)
apm.lib.utils.bot.construction.overhaul("construction-robot", 1)


-- offshore pump
if not mods["space-age"] then
	apm.lib.utils.item.remove("offshore-pump")
else
	local pump = data.raw["offshore-pump"]["offshore-pump"]

	if pump then
		pump.energy_source = apm.lib.utils.builders.energy_source.new_electric(nil, nil)
		pump.energy_usage = "600kW"
	end
end
