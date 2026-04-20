require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/lib/definitions.lua'

APM_LOG_HEADER(self)

if apm.recycling.color == nil then apm.recycling.color = {} end
if apm.recycling.path == nil then apm.recycling.path = {} end
if apm.recycling.icons == nil then apm.recycling.icons = {} end

apm.recycling.path.scrap = '__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_scrap_metal.png'
apm.recycling.path.box = '__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_scrap_metal_box.png'
