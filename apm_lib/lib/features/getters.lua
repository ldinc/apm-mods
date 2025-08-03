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

	local group = settings[setting_type]

	if not group then
		log(APM_MSG_ERROR(
			"apm.lib.features.getter.boolean",
			"there is no such settings group [" .. tostring(setting_type) .. "]"
		))

		return default_value
	end

	local setting = group[setting_name]

	if not setting then
		log(APM_MSG_ERROR(
			"apm.lib.features.getter.boolean",
			"there is no such settings  [" .. setting_name .. "]"
		))

		return default_value
	end

	local v = setting.value

	if type(v) == "boolean" then
		return v
	end

	return default_value
end

--- [string]
---@param setting_type setting_type
---@param setting_name string
---@param default_value string
---@return string
function apm.lib.features.getter.string(setting_type, setting_name, default_value)
	if default_value == nil then
		default_value = ""
	end

	local setting = settings[setting_type]

	if not setting then
		return default_value
	end

	local v = setting[setting_name].value

	if type(v) == "string" then
		return v
	end

	return default_value
end

---@param str string
---@param pat string
---@return string[]
local function split(str, pat)
	str = string.gsub(str, "%s+", "")

	local t = {}
	local fpat = "(.-)" .. pat
	local last_end = 1
	local s, e, cap = str:find(fpat, 1)

	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(t, cap)
		end
		last_end = e + 1
		s, e, cap = str:find(fpat, last_end)
	end

	if last_end <= #str then
		cap = str:sub(last_end)
		table.insert(t, cap)
	end

	return t
end

--- [split string separated by ',' to string list]
---@param str string
---@return string[]
function apm.lib.features.getter.split_string_simple(str)
	return split(str, ",")
end

--- [split string separated by ',' to string list into map[key]=true]
---@param str string
---@return table<string, boolean>
function apm.lib.features.getter.split_string_simple_to_map(str)
	local t = apm.lib.features.getter.split_string_simple(str)

	local dict = {}

	for _, key in ipairs(t) do
		dict[key] = true
	end

	return dict
end
