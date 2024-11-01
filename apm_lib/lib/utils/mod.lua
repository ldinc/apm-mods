require 'util'
require('lib.log')

local self = 'lib.utils.mod'

if apm == nil then apm = {} end
if apm.lib == nil then apm.lib = {} end
if apm.lib.utils == nil then apm.lib.utils = {} end
if apm.lib.utils.mod == nil then apm.lib.utils.mod = {} end

function apm.lib.utils.mod.enabled(name)
	if script.active_mods[name] then
		return true
	end

	return false
end
