require('prototypes.main.generate')
require('prototypes.main.overwrites')
require('prototypes.main.technologies-overwrites')
require('prototypes.integrations.generate')
require('prototypes.integrations.entities_updates')
require('prototypes.integrations.updates')

apm.lib.utils.builder.recipe.update()