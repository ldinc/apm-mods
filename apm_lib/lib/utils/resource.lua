require 'util'
require('lib.log')

local self = 'lib.utils.resource'

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.resource.exist(resource_name)
	if data.raw.resource[resource_name] then
        return true
    end
    APM_LOG_WARN(self, 'exist()', 'resource with name: "' .. tostring(resource_name) .. '" doesnt exist.')
    return false
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.resource.on_starting_zone(resource_name, value)
    log('JIB JIB')
    if not apm.lib.utils.resource.exist(resource_name) then
        APM_LOG_WARN(self, 'on_starting_zone()', 'resource with name: "' .. tostring(resource_name) .. '" not found!')
        return
    end
    local res = data.raw.resource[resource_name]
    log('JIB ----------------------------------------')
    -- if resource_generator then
    --     resource_generator.setup_resource_autoplace_data("sulfur", {
    --         name = "sulfur",
    --         order = "c",
    --         base_density = 8,
    --         has_starting_area_placement = false,
    --         regular_rq_factor_multiplier = 1,
    --     })
    -- else
    --     data.raw.resource["sulfur"].autoplace = resource_autoplace.resource_autoplace_settings{
    --         name = "sulfur",
    --         order = "c",
    --         base_density = 8,
    --         has_starting_area_placement = false,
    --         regular_rq_factor_multiplier = 1,
    --     }
    -- end
 
    if res.autoplace then
        res.autoplace.has_starting_area_placement  = value
        res.autoplace.starting_rq_factor_multiplier = 1
    end
    -- apm.lib.utils.debug.object(res.autoplace)
    log('JIB ----------------------------------------')

    local msg = '" added as starting resource point'
    if not value then 
        msg = '" excluded as starting resource point'
    end
    APM_LOG_INFO(self, 'on_starting_zone()', 'resource with name: "' .. tostring(resource_name) .. msg)
end