if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

-- apm.lib.utils.technology.remove.recipe_from_unlock('alloy-processing', 'stone-mixing-furnace')
-- setup startup entities & remove some techs
apm.lib.utils.recipe.enable('stone-mixing-furnace')
apm.lib.utils.recipe.enable(apm.bob_rework.lib.entities.bronze)