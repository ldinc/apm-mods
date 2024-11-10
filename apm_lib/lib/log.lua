local json = require('json')

local loglevel_setting = settings.startup["apm_lib_log_level"].value

local loglevel = 0
if loglevel_setting == '0: Error' then loglevel = 0 end
if loglevel_setting == '1: Warning' then loglevel = 1 end
if loglevel_setting == '2: Info' then loglevel = 2 end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function APM_LOG_ERR(caller, func, msg)
	if loglevel >= 0 then
		log('Error: ' .. caller .. ' -> ' .. func .. ': ' .. msg)
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function APM_LOG_DEPR(caller, func, msg)
	if loglevel >= 0 then
		log('Deprecated: ' .. caller .. ' -> ' .. func .. ': ' .. msg)
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function APM_LOG_WARN(caller, func, msg)
	if loglevel >= 1 then
		log('Warning: ' .. caller .. ' -> ' .. func .. ': ' .. msg)
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function APM_LOG_INFO(caller, func, msg)
	if loglevel >= 2 then
		log('Info: ' .. caller .. ' -> ' .. func .. ': ' .. msg)
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function APM_LOG_HEADER(path)
	if loglevel >= 2 then
		log('- Info ------------------------------------------------')
		log(tostring(path))
		log('-------------------------------------------------------')
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function APM_LOG_SETTINGS(caller, name, value)
	if loglevel >= 2 then
		log('Setting: ' .. caller .. ': ' .. name .. ' -> ' .. tostring(value))
	end
end

function APM_LOG_JSON(caller, name, value)
	if loglevel >= 2 then
		log('Json: ' .. caller .. ':' .. name .. ' = ' .. json.encode(value))
	end
end

function APM_LOG_JSON_ERROR(caller, name, value)
	if loglevel >= 0 then
		log('Error with json: ' .. caller .. ':' .. name .. ' = ' .. json.encode(value))
	end
end

---@param caller string
---@param name string
---@param value any
---@param options? serpent.options
function APM_LOG_SERPENT_BLOCK_ERROR(caller, name, value, options)
	if loglevel >= 0 then
		log('Error with serpent: ' .. caller .. ':' .. name .. ' = \n' .. serpent.line(value, options))
	end
end


---@param caller string
---@param name string
---@param value any
---@param options? serpent.options
function APM_LOG_SERPENT_LINE_ERROR(caller, name, value, options)
	if loglevel >= 0 then
		log('Error with serpent: ' .. caller .. ':' .. name .. ' = \n' .. serpent.block(value, options))
	end
end

function render(obj, indent)
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

function APM_LOG_OBJECT_ERROR(caller, name, value)
	if loglevel >= 0 then
		log('Error with object: ' .. caller .. ':' .. name .. ' = \n' .. render(value, '  '))
	end
end
