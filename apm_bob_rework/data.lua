if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end

-- require('lib.override.base')
require('lib.entities.new.base')
require('lib.entities.base')

-- apm.bob_rework.lib.override.apply()

require('prototypes.main.categories.item-subgroups')

require('prototypes.main.entities.burner-sieve')
require('prototypes.main.items.entities.burner-sieve')
require('prototypes.main.recipes.entities.burner-sieve')

require('prototypes.main.entities.tesla-coil')
require('prototypes.main.items.entities.tesla-coil')
require('prototypes.main.recipes.entities.tesla-coil')

require('prototypes.main.entities.wind-turbine')
require('prototypes.main.items.entities.wind-turbine')
require('prototypes.main.recipes.entities.wind-turbine')

require('prototypes.main.recipes.equipments')
require('prototypes.main.equipment.energy-absorber')
require('prototypes.main.items.equipments')

require('prototypes.main.entities.sentinel')
require('prototypes.main.items.entities.sentinel')
require('prototypes.main.recipes.entities.sentinel')

require('prototypes.main.entities.antimatter')
require('prototypes.main.items.entities.antimatter')
require('prototypes.main.recipes.entities.antimatter')

require('prototypes.main.entities.mining')
require('prototypes.main.items.entities.mining')
require('prototypes.main.recipes.entities.mining')

require('prototypes.main.entities.se-beacon')
require('prototypes.main.items.entities.se-beacon')
require('prototypes.main.recipes.entities.se-beacon')

require('prototypes.main.entities.se-rails')
require('prototypes.main.items.entities.se-rails')
require('prototypes.main.recipes.entities.se-rails')

require('prototypes.main.entities.crashsite')
require('prototypes.main.items.entities.crashsite')

require('prototypes.main.recipes.electric-engine')
require('prototypes.main.recipes.frame')

require('prototypes.main.technologies')

require('prototypes.main.entities.burner-pumpjack')
require('prototypes.main.items.entities.burner-pumpjack')
require('prototypes.main.recipes.entities.burner-pumpjack')

require('prototypes.main.entities.small-sinkhole')
require('prototypes.main.items.entities.small-sinkhole')
require('prototypes.main.recipes.entities.small-sinkhole')

require('prototypes.main.recipes.mud')