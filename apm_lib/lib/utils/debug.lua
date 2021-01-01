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

function apm.lib.utils.dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k,v in pairs(o) do
            if type(k) ~= 'number' then k = '"'..k..'"' end
            s = s .. '['..k..'] = ' .. apm.lib.utils.dump(v) .. ',\n'
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function apm.lib.utils.debug.object(obj)
    log(apm.lib.utils.dump(obj))
end