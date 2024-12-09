require 'util'

if not apm.lib.utils.setting.get then apm.lib.utils.setting.get = {} end

--- [setting.get.starup]
---@param settings_name string
---@return boolean|string|number|Color.0|{ [1]: number, [2]: number, [3]: number, [4]: number }?
function apm.lib.utils.setting.get.starup(settings_name)
	if settings.startup[settings_name] then
		return settings.startup[settings_name].value
	end

	return nil
end
