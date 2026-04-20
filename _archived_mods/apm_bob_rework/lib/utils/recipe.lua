if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.recipe == nil then apm.bob_rework.lib.utils.recipe = {} end

require('lib.utils.debug')

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

function apm.bob_rework.lib.utils.recipe.all()
    local map = {}
    for _, recipe in pairs(data.raw.recipe) do
        -- if recipe.enabled then
            map[recipe.name] = {}
        -- end
    end
    return map
end

function apm.bob_rework.lib.utils.recipe.getProducts(name)
    local recipe = data.raw.recipe[name]
    local list = {}

    local result = recipe.result
    if not result and recipe and recipe.normal and recipe.normal.result then
        result = recipe.normal.result
    end

    if result then
        table.insert(list, result)
        return list
    end

    local results = recipe.results
    if recipe and recipe.normal and recipe.normal.results then
        results = recipe.normal.results
    end
    if results then
        for _, v in ipairs(results) do
            table.insert(list, v.name)
        end

        return list
    end

    return list
end

function apm.bob_rework.lib.utils.recipe.allItems()
    local map = {}
    for _, itm in pairs(data.raw.item) do
        map[itm.name] = {}
    end

    return map
end

function apm.bob_rework.lib.utils.recipe.getIngredients(name)
    local recipe = data.raw.recipe[name]
    local list = {}
    local items = {}
    if recipe then
        if recipe.ingredients then
            items = recipe.ingredients
        elseif recipe.normal and recipe.normal.ingredients then
            items = recipe.normal.ingredients
        end
            -- TODO: handle normal and expensive recipe
        for _, ingredient in ipairs(items) do
            local itm = ingredient.name
            if not itm then
                itm = ingredient[1]
            end 
            table.insert(list, itm)
        end
    end

    return list
end

-- ["name"] = gate,
-- ["enabled"] = false,
-- ["ingredients"] = { [1] = { [1] = stone-wall,
-- 		[2] = 1,
-- 		} ,
-- 	[2] = { [1] = steel-plate,
-- 		[2] = 2,
-- 		} ,
-- 	[3] = { [1] = electronic-circuit,
-- 		[2] = 2,
-- 		} ,
-- 	} ,
-- ["result"] = gate,
-- } 