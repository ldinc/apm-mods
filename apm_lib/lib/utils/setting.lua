require "util"

if not apm.lib.utils.setting.get then apm.lib.utils.setting.get = {} end

--- [setting.get.startup]
---@param settings_name string
---@return boolean|string|number|Color?
function apm.lib.utils.setting.get.startup(settings_name)
	if settings.startup[settings_name] then
		return settings.startup[settings_name].value
	end

	return nil
end
