return {
	startup = function(setting_name, default_value)
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
}
