if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.debug == nil then apm.bob_rework.lib.utils.debug = {} end

function apm.bob_rework.lib.utils.dump(obj)
    return apm.bob_rework.lib.utils.render(obj, '')
end

function apm.bob_rework.lib.utils.render(obj, indent)
    if type(obj) == 'table' then
        local s = '{ '
        for k,v in pairs(obj) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. apm.bob_rework.lib.utils.render(v, indent .. '\t') .. ',\n' .. indent
        end
        return s .. '} '
    else
        return tostring(obj)
    end
end

function apm.bob_rework.lib.utils.debug.object(obj)
    log(apm.bob_rework.lib.utils.dump(obj))
end