if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.assembler == nil then apm.bob_rework.lib.utils.assembler = {} end

function apm.bob_rework.lib.utils.assembler.craftingCategories(name)
    local assembler = data.raw['assembling-machine'][name]
    local map = {}
    if assembler then
        for _, v in pairs(assembler.crafting_categories) do
            local key = v
            if v.name then
                key = v.name
            end
            map[key] = {}
        end
    end

    return map
end