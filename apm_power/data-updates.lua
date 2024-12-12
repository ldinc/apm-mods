apm.lib.utils.builder.recipe.update()

require('prototypes.main.water-tiles')

require('prototypes.main.fuel')
require('prototypes.main.overwrites')
require('prototypes.main.recipes-overwrites')
require('prototypes.main.technologies-overwrites')
require('prototypes.integrations.updates')

--- [fix for space-age hard reset categories per character...]
if mods["space-age"] then
	apm.lib.utils.character.crafting_category.add('character', 'apm_handcrafting_only')
end

apm.lib.utils.item.overwrite.weight("burner-inserter", apm.lib.utils.constants.value.weight.building.inserter)