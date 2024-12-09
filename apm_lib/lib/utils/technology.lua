require 'util'
require('lib.log')

local self = 'lib.utils.technology'

if not apm.lib.utils.technology.find then apm.lib.utils.technology.find = {} end
if not apm.lib.utils.technology.add then apm.lib.utils.technology.add = {} end
if not apm.lib.utils.technology.mod then apm.lib.utils.technology.mod = {} end
if not apm.lib.utils.technology.remove then apm.lib.utils.technology.remove = {} end
if not apm.lib.utils.technology.get then apm.lib.utils.technology.get = {} end
if not apm.lib.utils.technology.has then apm.lib.utils.technology.has = {} end
if not apm.lib.utils.technology.prerequisite then apm.lib.utils.technology.prerequisite = {} end
if not apm.lib.utils.technology.prerequisite.has then apm.lib.utils.technology.prerequisite.has = {} end
if not apm.lib.utils.technology.set then apm.lib.utils.technology.set = {} end
if not apm.lib.utils.technology.force then apm.lib.utils.technology.force = {} end
if not apm.lib.utils.technology.overwrite then apm.lib.utils.technology.overwrite = {} end

require("lib.utils.technology.actions")
require("lib.utils.technology.base")
require("lib.utils.technology.prerequisites")
require("lib.utils.technology.recipe")
require("lib.utils.technology.science")
require("lib.utils.technology.trigger")
require("lib.utils.technology.unit")
