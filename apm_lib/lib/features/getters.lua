if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end
if not apm.lib.features.getter then apm.lib.features.getter = {} end

---@enum setting_type
apm.lib.features.getter.type = {
	startup = "startup",
	runtime = "global",
	player = "player_default"
}

--- [int]
---@param setting_type setting_type
---@param setting_name string
---@param default_value int64?
---@return int64
function apm.lib.features.getter.int(setting_type, setting_name, default_value)
	if default_value == nil then
		default_value = 0
	end

	local value = default_value

	local setting = settings[setting_type]

	if not setting then
		return default_value
	end

	local v = setting[setting_name].value

	if type(v) == "number" then
		return v
	end

	return value
end

--- [double]
---@param setting_type setting_type
---@param setting_name string
---@param default_value double?
---@return double
function apm.lib.features.getter.double(setting_type, setting_name, default_value)
	if default_value == nil then
		default_value = 0.0
	end

	local value = default_value

	local setting = settings[setting_type]

	if not setting then
		return default_value
	end

	local v = setting[setting_name].value

	if type(v) == "number" then
		return v
	end

	return value
end

--- [boolean]
---@param setting_type setting_type
---@param setting_name string
---@param default_value boolean?
---@return boolean
function apm.lib.features.getter.boolean(setting_type, setting_name, default_value)
	if default_value == nil then
		default_value = false
	end

	local setting = settings[setting_type]

	if not setting then
		return default_value
	end

	local v = setting[setting_name].value

	if type(v) == "boolean" then
		return v
	end

	return default_value
end
