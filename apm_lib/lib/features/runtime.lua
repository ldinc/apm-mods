if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end
if not apm.lib.features.runtime then apm.lib.features.runtime = {} end
if not apm.lib.features.runtime.getters then
	---@type table<string, function>
	apm.lib.features.runtime.getters = {}
end

if not apm.lib.features.runtime.values then apm.lib.features.runtime.values = {} end

--- [register runtime settings]
---@param setting_name string
---@param getter function()
function apm.lib.features.runtime.register(setting_name, getter)
	apm.lib.features.runtime.getters[setting_name] = getter
end

function apm.lib.features.runtime.update()
	for key, getter in pairs(apm.lib.features.runtime.getters) do
		apm.lib.features.runtime.values[key] = getter()
	end
end

--- [get runtime setting]
---@param key string
---@return (string|double|int|boolean)?
function apm.lib.features.runtime.get(key)
	local v = apm.lib.features.runtime.values[key]

	if not v then
		return v
	end

	log(APM_MSG_ERROR("apm.lib.features.runtime.get", "setting \"" .. key .. "\"" .. " not found"))

	return nil
end

--- [get runtime boolean setting]
---@param key string
---@return boolean
function apm.lib.features.runtime.get_boolean(key)
	local v = apm.lib.features.runtime.get(key)

	if not v then
		return false
	end

	if type(v) == "boolean" then
		return v
	end

	log(APM_MSG_ERROR("apm.lib.features.runtime.get_boolean", "not boolean"))

	return false
end

--- [get runtime double setting]
---@param key string
---@return double
function apm.lib.features.runtime.get_double(key)
	local v = apm.lib.features.runtime.get(key)

	if not v then
		return 0.0
	end

	if type(v) == "number" then
		return v
	end

	log(APM_MSG_ERROR("apm.lib.features.runtime.get_boolean", "not boolean"))

	return 0.0
end