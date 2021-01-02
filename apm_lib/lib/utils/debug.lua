require 'util'

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.debug.table(t)
    log('--- DEBUG: Table -----------------------------------')
    log('->: ' .. tostring(t))
    log(serpent.block( t, {comment = false, numformat = '%1.8g' } ))
end

function apm.lib.utils.dump(obj)
    return apm.lib.utils.render(obj, '')
end

function apm.lib.utils.render(obj, indent)
    if type(obj) == 'table' then
        local s = '{ '
        for k,v in pairs(obj) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. dump(v, indent .. '\t') .. ',\n' .. indent
        end
        return s .. '} '
    else
        return tostring(obj)
    end
end

function apm.lib.utils.debug.object(obj)
    log(apm.lib.utils.dump(obj))
end