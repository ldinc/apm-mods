require "util"
require("lib.log")

if apm.lib.utils.planet == nil then apm.lib.utils.planet = {} end
if apm.lib.utils.planet.add == nil then apm.lib.utils.planet.add = {} end

---@param planet_name string
---@param resource_name string
function apm.lib.utils.planet.add.resource(planet_name, resource_name)
  local planet = data.raw["planet"][planet_name]

  if not planet then
    APM_LOG_ERR("", "planet.add.resource", "planet '"..planet_name.."' not found")

    return
  end

  if planet.map_gen_settings == nil and planet.map_gen_settings.autoplace_controls then
    return
  end

  planet.map_gen_settings.autoplace_controls[resource_name] = {}
  planet.map_gen_settings.autoplace_settings["entity"].settings[resource_name] = {}
end