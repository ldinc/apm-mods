if apm == nil then apm = {} end
if apm.power == nil then apm.power = {} end

require('lib.data-interfaces')
require('lib.definitions')
require('lib.functions')

require('lib.features.all')

require('prototypes.main.categories')

require('prototypes.main.entities.air_cleaner')
require('prototypes.main.entities.assembling_machines')
require('prototypes.main.entities.boilers')
require('prototypes.main.entities.burner_inserters')
require('prototypes.main.entities.centrifuges')
require('prototypes.main.entities.coking_plants')
require('prototypes.main.entities.crushers')
require('prototypes.main.entities.furnaces')
require('prototypes.main.entities.greenhouse')
require('prototypes.main.entities.labs')
require('prototypes.main.entities.mining_drills')
require('prototypes.main.entities.offshore_pumps')
require('prototypes.main.entities.presses')
require('prototypes.main.entities.pumps')
require('prototypes.main.entities.sieve')
require('prototypes.main.entities.sinkhole')
require('prototypes.main.entities.small_sinkhole')
require('prototypes.main.entities.steam_engines')
require('prototypes.main.entities.inline_storage_tank')
require('prototypes.main.entities.steam_inserters')
--require('prototypes.main.entities.transport_belts')
-- require('prototypes.main.entities.lamp')

require('prototypes.main.tiles')

require('prototypes.main.items.entities.air_cleaner')
require('prototypes.main.items.entities.assembling_machines')
require('prototypes.main.items.entities.boilers')
require('prototypes.main.items.entities.burner_inserters')
require('prototypes.main.items.entities.centrifuges')
require('prototypes.main.items.entities.coking_plants')
require('prototypes.main.items.entities.crushers')
require('prototypes.main.items.entities.furnaces')
require('prototypes.main.items.entities.greenhouse')
require('prototypes.main.items.entities.labs')
require('prototypes.main.items.entities.mining_drills')
require('prototypes.main.items.entities.offshore_pumps')
require('prototypes.main.items.entities.presses')
require('prototypes.main.items.entities.pumps')
require('prototypes.main.items.entities.sieve')
require('prototypes.main.items.entities.sinkhole')
require('prototypes.main.items.entities.steam_engines')
--require('prototypes.main.items.entities.transport_belts')
require('prototypes.main.items.entities.inline_storage_tank')
require('prototypes.main.items.entities.steam_inserters')

require('prototypes.main.items.intermediates')
require('prototypes.main.items.crusher')
require('prototypes.main.items.press')
require('prototypes.main.items.centrifuge')
require('prototypes.main.items.smelting')
require('prototypes.main.items.science')
require('prototypes.main.items.fuels')
require('prototypes.main.items.ash')
require('prototypes.main.items.air_cleaner')
require('prototypes.main.items.greenhouse')
require('prototypes.main.items.sifting')
require('prototypes.main.items.modules')
require('prototypes.main.items.tools')
require('prototypes.main.items.tiles')

require('prototypes.main.fluids')

require('prototypes.main.recipes.entities.air_cleaner')
require('prototypes.main.recipes.entities.assembling_machines')
require('prototypes.main.recipes.entities.boilers')
require('prototypes.main.recipes.entities.burner_inserters')
require('prototypes.main.recipes.entities.centrifuges')
require('prototypes.main.recipes.entities.coking_plants')
require('prototypes.main.recipes.entities.crushers')
require('prototypes.main.recipes.entities.furnaces')
require('prototypes.main.recipes.entities.greenhouse')
require('prototypes.main.recipes.entities.labs')
require('prototypes.main.recipes.entities.mining_drills')
require('prototypes.main.recipes.entities.offshore_pumps')
require('prototypes.main.recipes.entities.presses')
require('prototypes.main.recipes.entities.pumps')
require('prototypes.main.recipes.entities.sieve')
require('prototypes.main.recipes.entities.sinkhole')
require('prototypes.main.recipes.entities.steam_engines')
require('prototypes.main.recipes.entities.steam_inserters')
--require('prototypes.main.recipes.entities.transport_belts')
require('prototypes.main.recipes.entities.inline_storage_tank')

require('prototypes.main.recipes.intermediates')
require('prototypes.main.recipes.crusher')
require('prototypes.main.recipes.press')
require('prototypes.main.recipes.smelting')
require('prototypes.main.recipes.science')
require('prototypes.main.recipes.fuels')
require('prototypes.main.recipes.ash')
require('prototypes.main.recipes.air_cleaner')
require('prototypes.main.recipes.greenhouse')
require('prototypes.main.recipes.centrifuge')
require('prototypes.main.recipes.chemistry')
require('prototypes.main.recipes.puddling_furnace')
require('prototypes.main.recipes.steelworks')
require('prototypes.main.recipes.sifting')
require('prototypes.main.recipes.modules')
require('prototypes.main.recipes.equipments')
require('prototypes.main.recipes.tools')
require('prototypes.main.recipes.tiles')

require('prototypes.main.technologies')

require('prototypes.main.equipment.equipment_grid_categories')
require('prototypes.main.equipment.equipment_grids')
require('prototypes.main.equipment.armor')
require('prototypes.main.equipment.burner_generators')
require('prototypes.main.equipment.batteries')
require('prototypes.main.equipment.roboport')
require('prototypes.main.equipment.robots')

local apm_power_compat_earendel = settings.startup["apm_power_compat_earendel"].value
if mods['aai-industry'] and apm_power_compat_earendel then
  apm.lib.utils.recipe.ingredient.replace_all("motor", "apm_simple_engine")
end