if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end
if apm.bob_rework.lib.science == nil then apm.bob_rework.lib.science = {} end

local science = {}

science.industrial = 'apm_industrial_science_pack'
science.steam = 'apm_steam_science_pack'
science.automation = 'automation-science-pack'
science.logistics = 'logistic-science-pack'
science.military = 'military-science-pack'
science.chemical = 'chemical-science-pack'
science.advanced = {
    logistics = 'advanced-logistic-science-pack'
}
science.production = 'production-science-pack'
science.utility = 'utility-science-pack'
science.nuclear = 'apm_nuclear_science_pack'
science.space = 'space-science-pack'

return science