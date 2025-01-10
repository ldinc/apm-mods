if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end
if not apm.lib.features.startup then apm.lib.features.startup = {} end

require("getters")

--- [get_int_value_from_startup_setting]
---@param setting_name string
---@param default_value int64?
---@return int64
function apm.lib.features.startup.get_int_value_from_setting(setting_name, default_value)
	return apm.lib.features.getter.int(apm.lib.features.getter.type.startup, setting_name, default_value)
end

--- [get_boolean_value_from_setting]
---@param setting_name string
---@param default_value boolean?
---@return boolean
function apm.lib.features.startup.get_boolean_value_from_setting(setting_name, default_value)
	return apm.lib.features.getter.boolean(apm.lib.features.getter.type.startup, setting_name, default_value)
end