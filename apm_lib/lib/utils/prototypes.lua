require 'util'
require('lib.log')

local self = 'lib.utils.prototypes'

if apm == nil then apm = {} end
if apm.lib == nil then apm.lib = {} end
if apm.lib.utils == nil then apm.lib.utils = {} end
if apm.lib.utils.prototypes == nil then apm.lib.utils.prototypes = {} end

if apm.lib.utils.prototypes.item == nil then apm.lib.utils.prototypes.item = {} end
if apm.lib.utils.prototypes.equipment == nil then apm.lib.utils.prototypes.equipment = {} end

--- [prototypes.item.exists]
---@param name string
---@return boolean
function apm.lib.utils.prototypes.item.exists(name)
	if prototypes.item[name] then
		return true
	end

	return false
end

--- [prototypes.item.all]
---@return LuaCustomTable<string, LuaItemPrototype>
function apm.lib.utils.prototypes.item.all()
	return prototypes.item
end

--- [prototypes.item.get]
---@param name string
---@return LuaItemPrototype
function apm.lib.utils.prototypes.item.get(name)
	return prototypes.item[name]
end

--- [prototypes.equipment.get]
---@param name string
---@return LuaEquipmentPrototype
function apm.lib.utils.prototypes.equipment.get(name)
	return prototypes.equipment[name]
end

--- [prototypes.all]
---@return LuaPrototypes
function apm.lib.utils.prototypes.all()
	return prototypes
end
