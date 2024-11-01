require 'util'
require('lib.log')

local self = 'lib.utils.prototypes'

if apm == nil then apm = {} end
if apm.lib == nil then apm.lib = {} end
if apm.lib.utils == nil then apm.lib.utils = {} end
if apm.lib.utils.prototypes == nil then apm.lib.utils.prototypes = {} end

if apm.lib.utils.prototypes.item == nil then apm.lib.utils.prototypes.item = {} end
if apm.lib.utils.prototypes.equipment == nil then apm.lib.utils.prototypes.equipment = {} end


function apm.lib.utils.prototypes.item.exists(name)
	if prototypes.item[name] then
		return true
	end

	return false
end

function apm.lib.utils.prototypes.item.all()
	return prototypes.item
end

function apm.lib.utils.prototypes.item.get(name)
	return prototypes.item[name]
end

function apm.lib.utils.prototypes.equipment.get(name)
	return prototypes.equipment[name]
end

function apm.lib.utils.prototypes.all()
	return prototypes
end
