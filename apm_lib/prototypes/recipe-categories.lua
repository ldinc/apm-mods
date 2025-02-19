require('util')
require('lib.log')

local self = 'apm_lib/prototypes/recipe-categories.lua'

APM_LOG_HEADER(self)

-- player crafting
apm.lib.utils.recipe.category.create('apm_handcrafting_only')
apm.lib.utils.character.crafting_category.add('character', 'apm_handcrafting_only')

-- general
apm.lib.utils.recipe.category.create('apm_electric_smelting')

-- apm_recycling
apm.lib.utils.recipe.category.create('apm_recycling_1')
apm.lib.utils.recipe.category.create('apm_recycling_2')
apm.lib.utils.recipe.category.create('apm_recycling_3')
apm.lib.utils.recipe.category.create('apm_recycling_4')

-- apm_power
apm.lib.utils.recipe.category.create('apm_fluids_from_the_void')
apm.lib.utils.recipe.category.create('apm_crusher')
apm.lib.utils.recipe.category.create('apm_crusher_2')
apm.lib.utils.recipe.category.create('apm_crusher_3')
apm.lib.utils.recipe.category.create('apm_press')
apm.lib.utils.recipe.category.create('apm_press_2')
apm.lib.utils.recipe.category.create('apm_press_3')
apm.lib.utils.recipe.category.create('apm_coking')
apm.lib.utils.recipe.category.create('apm_coking_2')
apm.lib.utils.recipe.category.create('apm_coking_3')
apm.lib.utils.recipe.category.create('apm_puddling_furnace')
apm.lib.utils.recipe.category.create('apm_steelworks')
apm.lib.utils.recipe.category.create('apm_greenhouse')
apm.lib.utils.recipe.category.create('apm_air_cleaner')
apm.lib.utils.recipe.category.create('apm_centrifuge_0')
apm.lib.utils.recipe.category.create('apm_centrifuge_1')
apm.lib.utils.recipe.category.create('apm_centrifuge_2')
apm.lib.utils.recipe.category.create('apm_sifting_0')
apm.lib.utils.recipe.category.create('apm_sifting_1')
apm.lib.utils.recipe.category.create('apm_sifting_2')
apm.lib.utils.recipe.category.create('apm_sinkhole')

-- apm_nuclear
apm.lib.utils.recipe.category.create('apm_nuclear_breeding')
apm.lib.utils.recipe.category.create('apm_nuclear_cooling_0')
apm.lib.utils.recipe.category.create('apm_fluid_cooling_0')

-- apm_energy_addon
apm.lib.utils.recipe.category.create('apm_electric_charging')