if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.recipe == nil then apm.bob_rework.lib.utils.recipe = {} end

require('lib.utils.debug')

function apm.bob_rework.lib.utils.disable_productivity(recipies)
    -- if not apm.lib.utils.recipe.exist(recipe) then return end
    for key, p_module in pairs(data.raw["module"]) do
        if apm.lib.utils.modules.has_productivity(p_module.name) then
            if not p_module.limitation_blacklist then
                p_module.limitation_blacklist = {}
            end
            for recipe, _ in pairs(recipies) do
                table.insert(p_module.limitation_blacklist, recipe)
            end
            if p_module.limitation then 
                for ind, limitation in pairs(p_module.limitation) do
                    if recipies[limitation] then
                        p_module.limitation[ind] = nil
                    end
                end
            end
        end
    end
end
