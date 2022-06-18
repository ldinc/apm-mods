if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.datautil == nil then apm.bob_rework.lib.datautil = {} end

apm.bob_rework.lib.datautil.auto_sr_hr = function(hr_version)
    local sr_version = table.deepcopy(hr_version)
    if not hr_version.scale then
      hr_version.scale = 0.5
    end
    if not hr_version.priority then
      hr_version.priority = "extra-high"
    end
    sr_version.scale = (hr_version.scale or 0.5) * 2
    sr_version.width = math.floor(hr_version.width/2)
    sr_version.height = math.floor(hr_version.height/2)
    if hr_version.x then
      sr_version.x = math.floor(hr_version.x/2)
    end
    if hr_version.y then
      sr_version.y = math.floor(hr_version.y/2)
    end
    sr_version.filename = apm.bob_rework.lib.datautil.replace(sr_version.filename, "/hr/", "/sr/")
    sr_version.filename = apm.bob_rework.lib.datautil.replace(sr_version.filename, "/hr-", "/")
    sr_version.hr_version = hr_version
    return sr_version
  end

 apm.bob_rework.lib.datautil.replace = function(str, what, with)
    what = string.gsub(what, "[%(%)%.%+%-%*%?%[%]%^%$%%]", "%%%1") -- escape pattern
    with = string.gsub(with, "[%%]", "%%%%") -- escape replacement
    str = string.gsub(str, what, with)
    return str --only return the first variable from str_gsub
  end
  