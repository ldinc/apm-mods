if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.recipe == nil then apm.bob_rework.lib.utils.recipe = {} end

function apm.bob_rework.lib.utils.recipe.disableProductivity(recipies)
    for key, p_module in pairs(data.raw["module"]) do
        if apm.lib.utils.modules.has_productivity(p_module.name) then
            if not p_module.limitation_blacklist then
                p_module.limitation_blacklist = {}
            end
            for recipe, _ in pairs(recipies) do
                if apm.lib.utils.recipe.exist(recipe) then
                    table.insert(p_module.limitation_blacklist, recipe)
                end
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

function apm.bob_rework.lib.utils.recipe.getAllFluids()
    local recipies = {}

    for _, info in pairs(data.raw.recipe) do
        if apm.lib.utils.item.get_type(info.main_product) == 'fluid' then
            table.insert(recipies, info.name)
        end
        if info.results then
            for _, result in pairs(info.results) do
                if result.type == 'fluid' then
                    table.insert(recipies, info.name)
                    break
                end
            end
        end
    end

    return recipies
end

function apm.bob_rework.lib.utils.recipe.getWithFluids()
    local recipies = {}

    for _, info in pairs(data.raw.recipe) do
        if apm.lib.utils.item.get_type(info.main_product) == 'fluid' then
            table.insert(recipies, info.name)
        end
        if info.normal and info.normal.ingredients then
            for _, ingredient in pairs(info.normal.ingredients) do
                if apm.lib.utils.item.get_type(ingredient) == 'fluid' then
                    table.insert(recipies, info.name)
                    break
                end
            end
        end
    end

    return recipies
end
