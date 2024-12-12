if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end
if not apm.lib.features.startup then apm.lib.features.startup = {} end

--- [get_int_value_from_startup_setting]
---@param setting_name string
---@param default_value int64?
---@return int64
function apm.lib.features.startup.get_int_value_from_setting(setting_name, default_value)
	if default_value == nil then
		default_value = 0
	end

	local value = default_value

	local v = settings.startup[setting_name].value

	if type(v) == "number" then
		return v
	end

	return value
end

--- [get_boolean_value_from_setting]
---@param setting_name string
---@param default_value boolean?
---@return boolean
function apm.lib.features.startup.get_boolean_value_from_setting(setting_name, default_value)
	if default_value == nil then
		default_value = false
	end

	local value = default_value

	local v = settings.startup[setting_name].value

	if type(v) == "boolean" then
		return v
	end

	return value
end