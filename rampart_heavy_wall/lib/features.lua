if not rampant_heavy_wall then rampant_heavy_wall = {} end
if not rampant_heavy_wall.lib then rampant_heavy_wall.lib = {} end
if not rampant_heavy_wall.lib.features then rampant_heavy_wall.lib.features = {} end
if not rampant_heavy_wall.lib.features.getter then rampant_heavy_wall.lib.features.getter = {} end


---@enum hw_setting_type
rampant_heavy_wall.lib.features.getter.type = {
	startup = "startup",
	runtime = "global",
	player = "player_default"
}

--- [string]
---@param setting_type hw_setting_type
---@param setting_name string
---@param default_value string?
---@return string
function rampant_heavy_wall.lib.features.getter.string(setting_type, setting_name, default_value)
	if default_value == nil then
		default_value = ""
	end

	local value = default_value

	local setting = settings[setting_type]

	if not setting then
		return default_value
	end

	local v = setting[setting_name].value

	if type(v) == "string" then
		return v
	end

	return value
end

--- [int]
---@param setting_type hw_setting_type
---@param setting_name string
---@param default_value int64?
---@return int64
function rampant_heavy_wall.lib.features.getter.int(setting_type, setting_name, default_value)
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
---@param setting_type hw_setting_type
---@param setting_name string
---@param default_value double?
---@return double
function rampant_heavy_wall.lib.features.getter.double(setting_type, setting_name, default_value)
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
---@param setting_type hw_setting_type
---@param setting_name string
---@param default_value boolean?
---@return boolean
function rampant_heavy_wall.lib.features.getter.boolean(setting_type, setting_name, default_value)
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

---@return int
function rampant_heavy_wall.lib.features.wall_hp()
	return rampant_heavy_wall.lib.features.getter.int(
		rampant_heavy_wall.lib.features.getter.type.startup,
		"rampart-heavy-wall-hp",
		3500
	)
end

---@return int
function rampant_heavy_wall.lib.features.K()
	return rampant_heavy_wall.lib.features.getter.int(
		rampant_heavy_wall.lib.features.getter.type.startup,
		"rampart-heavy-wall-k",
		1
	)
end

---@return boolean
function rampant_heavy_wall.lib.features.is_resipe_overwritten()
	return rampant_heavy_wall.lib.features.getter.bool(
		rampant_heavy_wall.lib.features.getter.type.startup,
		"rampart-heavy-wall-overwrite-recipe",
		false
	)
end

---@return string
function rampant_heavy_wall.lib.features.custom_recipe()
	return rampant_heavy_wall.lib.features.getter.string(
		rampant_heavy_wall.lib.features.getter.type.startup,
		"rampart-heavy-wall-overwrited-recipe",
		""
	)
end

function extract_wall(s)
	return s:match("wall:%s*(.-)%s*;")
end

function extract_gate(s)
	return s:match("gate:%s*(.-)%s*$")
end

---@return data.IngredientPrototype[]?
function rampant_heavy_wall.lib.features.custom_recipe_for_wall()
	if not rampant_heavy_wall.lib.features.is_resipe_overwritten then
		return nil
	end

	local str = extract_wall(rampant_heavy_wall.lib.features.custom_recipe())

	if not str or str == "" then
		return nil
	end

	return rampant_heavy_wall.lib.utils.create_ingredients_from_string(str)
end

---@return data.IngredientPrototype[]?
function rampant_heavy_wall.lib.features.custom_recipe_for_gate()
	if not rampant_heavy_wall.lib.features.is_resipe_overwritten then
		return nil
	end

	local str = extract_gate(rampant_heavy_wall.lib.features.custom_recipe())

	if not str or str == "" then
		return nil
	end

	return rampant_heavy_wall.lib.utils.create_ingredients_from_string(str)
end
