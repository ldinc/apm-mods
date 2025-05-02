require 'util'
require('lib.log')

local self = 'lib.utils.recipe'

if not apm.lib.utils.recipe.result then apm.lib.utils.recipe.result = {} end
if not apm.lib.utils.recipe.set then apm.lib.utils.recipe.set = {} end
if not apm.lib.utils.recipe.has then apm.lib.utils.recipe.has = {} end
if not apm.lib.utils.recipe.get then apm.lib.utils.recipe.get = {} end
if not apm.lib.utils.recipe.ingredient then apm.lib.utils.recipe.ingredient = {} end
if not apm.lib.utils.recipe.category then apm.lib.utils.recipe.category = {} end
if not apm.lib.utils.recipe.energy_required then apm.lib.utils.recipe.energy_required = {} end
if not apm.lib.utils.recipe.overwrite then apm.lib.utils.recipe.overwrite = {} end

require('lib.utils.recipe.actions')
require('lib.utils.recipe.base')
require('lib.utils.recipe.ingredients')
require('lib.utils.recipe.products')
require('lib.utils.recipe.properties')
require('lib.utils.recipe.result')
require('lib.utils.recipe.temperature')
require('lib.utils.recipe.category')