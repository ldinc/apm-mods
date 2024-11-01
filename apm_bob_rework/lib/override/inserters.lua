if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local ins = require('lib.entities.buildings.inserters')
local t = require('lib.tier.base')

local genInserterts = function(tier, eK, isExpensive)
    local recipe = tier.inserter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, eK)
    if isExpensive then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 1)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 1)
    if recipe == ins.basic.steam then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 1)
    end

    local recipe = tier.filterInserter
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.inserter, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 4)
    end

    local recipe = tier.stackInserter
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, eK)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    end

    local recipe = tier.stackFilterInserter
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.stackInserter, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    end
end

local fixSteamInseter = function()
    local name = 'steam-inserter-all-corners'
    local ins = table.deepcopy(data.raw.inserter[t.steam.inserter])
    if ins then
        ins.name = name
        local box = ins.energy_source.fluid_box
        -- apm.lib.utils.debug.object(box)
        box.pipe_connections = {
            {
                type = "input-output",
                position = { 1, 0 },
            },
            {
                type = "input-output",
                position = { -1, 0 },
            },
            {
                type = "input-output",
                position = { 0, 1 },
            },
            {
                type = "input-output",
                position = { 0, -1 },
            }
        }
        ins.minable.result = name
    end

    data:extend({ ins })

    local item = table.deepcopy(data.raw.item[t.steam.inserter])

    item.name = name
    item.place_result = name
    item.icons =
    apm.lib.utils.icon.merge({
        apm.lib.utils.icon.get.from_item(t.steam.inserter),
        { apm.lib.icons.dynamics.t1 },
    })

    data:extend({ item })


    local recipe = table.deepcopy(data.raw.recipe[t.steam.inserter])

    recipe.name = name
    recipe.result = name
    recipe.icons =
        apm.lib.utils.icon.merge({
            apm.lib.utils.icon.get.from_item(t.steam.inserter),
            { apm.lib.icons.dynamics.t1 },
        })
    recipe.enabled = false

    data:extend({ recipe })

    apm.lib.utils.recipe.ingredient.remove_all(name)
    apm.lib.utils.recipe.ingredient.mod(name, t.steam.inserter, 1)
    apm.lib.utils.recipe.ingredient.mod(name, t.steam.pipe, 1)

    apm.lib.utils.technology.add.recipe_for_unlock('apm_steam_science_pack', name)
end

apm.bob_rework.lib.override.inserters = function()
    genInserterts(t.gray, 1, false)
    genInserterts(t.steam, 1, true)
    genInserterts(t.yellow, 1, true)
    genInserterts(t.red, 2, true)
    genInserterts(t.blue, 3, true)

    fixSteamInseter()
end
