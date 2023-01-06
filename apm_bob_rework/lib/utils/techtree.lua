local bob = require "lib.entities.bob"
local science = require "lib.entities.science"
local t = require "lib.entities.tech"
local default = require "lib.entities.default"
local json    = require "lib.utils.json"
local techtree_data = require "lib.utils.techtree_data"

-- Package for tech tree rebuilding

if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.tech == nil then apm.bob_rework.lib.utils.tech = {} end
if apm.bob_rework.lib.utils.tech.tree == nil then apm.bob_rework.lib.utils.tech.tree = {} end

local sciencePacks = {
    [science.industrial] = {},
    [science.steam] = {},
    [science.automation] = {},
    [science.logistics] = {},
    [science.military] = {},
    [science.chemical] = {},
    [science.advanced.logistics] = {},
    [science.production] = {},
    [science.utility] = {},
    [science.nuclear] = {},
    [science.space] = {},
}

local modulesHashMap = function ()
    local hashmap = {}
    hashmap[bob.modules.part.board.main] = {}
    hashmap[bob.modules.part.board.basic] = {}
    hashmap[bob.modules.part.board.logic] = {}
    hashmap[bob.modules.part.board.processor] = {}
    hashmap[bob.modules.part.board.bonus.efficency.basic] = {}
    hashmap[bob.modules.part.board.bonus.efficency.logic] = {}
    hashmap[bob.modules.part.board.bonus.efficency.processor] = {}
    hashmap[bob.modules.part.board.bonus.pollution.decrease.basic] = {}
    hashmap[bob.modules.part.board.bonus.pollution.decrease.logic] = {}
    hashmap[bob.modules.part.board.bonus.pollution.decrease.processor] = {}
    hashmap[bob.modules.part.board.bonus.pollution.increase.basic] = {}
    hashmap[bob.modules.part.board.bonus.pollution.increase.logic] = {}
    hashmap[bob.modules.part.board.bonus.pollution.increase.processor] = {}
    hashmap[bob.modules.part.board.bonus.productivity.basic] = {}
    hashmap[bob.modules.part.board.bonus.productivity.logic] = {}
    hashmap[bob.modules.part.board.bonus.productivity.processor] = {}
    hashmap[bob.modules.part.board.bonus.speed.basic] = {}
    hashmap[bob.modules.part.board.bonus.speed.logic] = {}
    hashmap[bob.modules.part.board.bonus.speed.processor] = {}

    return hashmap
end

local linkedTechMap = {
    [t.combat.turret.gun.I] = {t.crusher.burner},
    [t.processing.oil.basic] = {t.science.chemical},
    [t.battery.liio] = {t.science.chemical},
    [t.logistics.rail.signals] = {t.science.logistics},
    [t.logistics.automobile.basic] = {t.science.logistics},
    [t.logistics.inserters.red] = {t.science.logistics},
    [t.electronics.basic] = {t.science.steam},
    -- red sp bindings
    [t.electronics.advanced.I] = {t.science.logistics},
    -- purple sp bindings
    [t.electronics.advanced.II] = {t.science.production},
    -- pink sp bindings
    [t.electronics.advanced.III] = {t.science.advanced.logistics},
    -- nuclear bindings
    [t.nuclear.rtg] = {t.science.nuclear},
    [t.nuclear.processing.thorium] = {t.science.nuclear},
    [t.nuclear.breeder] = {t.science.nuclear},
    [t.nuclear.portable.reactor] = {t.science.nuclear},
    [t.nuclear.synthesys.plutonium] = {t.science.nuclear},
    [t.nuclear.portable.reactor] = {t.science.nuclear},
    [t.nuclear.thorium] = {t.science.nuclear, t.nuclear.thorium_breeder},
    [t.nuclear.fuel.product] = {t.science.nuclear, t.nuclear.synthesys.plutonium},
}

local getLinks = function()
    local map = table.deepcopy(linkedTechMap)
    for _, list in ipairs(techtree_data.tiers) do
        log(json.encode(list))
        local prev = nil
        for _, target in pairs(list) do
            log('debug '.. target)
            if prev then
                if map[target] == nil then
                    map[target] = {}
                end
                log('from '..target..' to '..prev)
                table.insert(map[target],prev)
            end
            prev = target
        end
    end

    return map
end

local reactorProductsMap = {
    [t.nuclear.uranium] = {['apm_fuel_rod_uranium_active'] = {}, ['apm_fuel_rod_mox_active'] = {}, ['apm_fuel_rod_thorium_active'] = {}, ['apm_fuel_rod_neptunium_active'] = {}},
    [t.nuclear.thorium] = {['apm_fuel_rod_uranium_active'] = {}, ['apm_fuel_rod_mox_active'] = {}, ['apm_fuel_rod_thorium_active'] = {}, ['apm_fuel_rod_neptunium_active'] = {}},
    [t.nuclear.breeder] = {['used-up-thorium-fuel-cell'] = {}},
    [t.nuclear.fuel.reprocessing] = {['apm_oxide_pellet_u238'] = {}},
    [t.nuclear.synthesys.plutonium] = {['plutonium-239'] = {}},
    [t.nuclear.deuterium] = {['used-up-deuterium-fuel-cell'] = {}},
}

local log = apm.bob_rework.lib.utils.debug.object

-- init empty tech tree
local emptyTree = function()
    local tree = {
        technologies = {
            all = {},
            linked = {},
            modules = {},
        },
        cache = {
            products = {},
            craftingGroups = {},
        },
        cursor = {
            current = nil,
            previous = nil,
        },

        queue = {},
    }

    return tree
end

-- fill tree by technologies
local appendTechologiesSet = function (tree)
    for _, tech in pairs(data.raw.technology) do
        local tName = tech.name
        tree.technologies.all[tName] = {
            ref = tech,
            isMilitary = false,
            isModuleBranch = false,
            isBuff = false,
            isEmpty = false,
            isResearch = false,

            dependencies = {
                products = nil,
                technologies = nil,
                craftingGroups = nil,
            },

            products = nil, -- products as result of current technology
            recipies = nil,
            craftingGroups = nil,

            science = {},
            sciencePacks = {},

            allAvailable = {
                products = nil,
                craftingGroups = nil,
            },

            children = nil,

            isHandled = false,
            willBeIgnored = false,
            ID = -1,
        }
    end
end

local techIsValid = function (tItem)
    if tItem.isEmpty == true or tItem.isModuleBranch == true or tItem.isBuff == true  then
        return false
    end

    return true
end

local extractResearchUnits = function (tech)
    if tech == nil or tech.unit == nil or tech.unit.ingredients == nil then
        return nil
    end

    local ingredients = tech.unit.ingredients
    local list = {}
    for _, itm in ipairs(ingredients) do
        if itm ~= nil and itm[1] ~= nil then
            list[itm[1]] = {}
        end
    end

    return list
end

local technologyIsEmpty = function (tech)
    if tech.effects == nil then
        return true
    end

    for _, itm in ipairs(tech.effects) do
        return false
    end

    return true
end

local technologyHasRecipeToUnlock = function (tech)
    if tech.effects == nil then
        return false
    end

    for _, itm in ipairs(tech.effects) do
        if itm.type == 'unlock-recipe' then
            return true
        end
    end

    return false
end

local setupResearchFlag = function (tree)
    for tName, tItem in pairs(tree.technologies.all) do
        if tItem.products then
            for product, value in pairs(tItem.products) do
                if sciencePacks[product] then
                    tItem.isResearch = true
                    tItem.sciencePacks[product] = {}
                end
            end
        end
    end
end

local setupTechnologyFlags = function (tree)

    local modulesHashMap = modulesHashMap()

    for tName, tItem in pairs(tree.technologies.all) do

        tItem.isEmpty = technologyIsEmpty(tItem.ref)

        if technologyHasRecipeToUnlock(tItem.ref) == false and tItem.isEmpty == false then
            tItem.isBuff = true
        end

        local rUnits = extractResearchUnits(tItem.ref)
        local isMilitaryTech = false
        local isModuleTech = false
        if rUnits ~= nil then
            for rUnit, _ in pairs(rUnits) do
                if rUnit == science.military then
                    isMilitaryTech = true
                end
                if modulesHashMap[rUnit] ~= nil then
                    isModuleTech = true
                end
            end
        end

        tItem.isMilitary = isMilitaryTech
        tItem.isModuleBranch = isModuleTech

        if tItem.isModuleBranch then
            tree.technologies.modules[tName] = tItem
        end
    end
end

local resetTechnologies = function (tree)
    for tName, tItem in pairs(tree.technologies.all) do
        if tItem.ref ~= nil and tItem.isModuleBranch == false and tItem.isEmpty == false then
            if tItem.isBuff then
               -- TODO: mb do smth 
            else
                local tech = tItem.ref
                apm.bob_rework.lib.utils.tech.dropAllPrerequisites(tech)
                apm.bob_rework.lib.utils.tech.dropAllSciencePacks(tech)
            end
        end
    end
end

local disableEmptyTechnologies = function (tree)
    for tName, tItem in pairs(tree.technologies.all) do
        if tItem.isEmpty then
            log('technology ['..tName..'] was disabled (empty)')
            apm.lib.utils.technology.disable(tItem.ref)
            tItem.ref.hidden = true
            tree.technologies.all[tName] = nil
        end
    end
end

local getTechnologyProductDependecies = function (tech)
    if tech and tech.effects then
        local list = {}
        for _, effect in pairs(tech.effects) do
            if effect.type == 'unlock-recipe' and effect.recipe  then
                local ingredients = apm.bob_rework.lib.utils.recipe.getIngredients(effect.recipe)
                for _, ingredient in ipairs(ingredients) do
                    list[ingredient] = {}
                end
            end
        end
        return list
    end

    return nil
end

local getCraftingGroupsForProduct = function (name)
    local groups = {}

    local assembler = data.raw['assembling-machine'][name]
    if assembler and assembler.crafting_categories then
        for _, group in ipairs(assembler.crafting_categories) do
            groups[group] = {}
        end
    end
    local furnace = data.raw['furnace'][name]
    if furnace and furnace.crafting_categories then
        for _, group in ipairs(furnace.crafting_categories) do
            groups[group] = {}
        end
    end

    -- TODO: research why not worked for rocket-silo
    -- HACK
    if name == 'rocket-silo' then
        groups['rocket-building'] = {}
    end

    return groups
end

local getCraftingGroupsForTech = function (tItem)
    local groups = {}

    for product in pairs(tItem.products) do
        local subgroups = getCraftingGroupsForProduct(product)
        for k, v in pairs(subgroups) do
            groups[k] = v
        end
    end

    return groups
end

local getDefaultCraftingGroups = function ()
    local groups = {}

    local products = default.list

    for product in pairs(products) do
        local subgroups = getCraftingGroupsForProduct(product)
        for k, v in pairs(subgroups) do
            groups[k] = v
        end
    end

    return groups
end

local tryHackForReactors = function (tName, list)
    local extra = reactorProductsMap[tName]
    if extra then
        for key, value in pairs(extra) do
            list[key] = value
        end
        -- log(tName..' will be enriched to :'..json.encode(list))
    end

    return list
end

local calculateProductsAndDependecies = function (tree)
    for tName, tItem in pairs(tree.technologies.all) do
        if techIsValid(tItem) or tItem.isModuleBranch then
            tItem.dependencies.craftingGroups = apm.bob_rework.lib.utils.tech.requiredCraftingGroups(tItem.ref)
            tItem.dependencies.products = getTechnologyProductDependecies(tItem.ref)
      
            local products, recipies = apm.bob_rework.lib.utils.tech.products(tItem.ref)

            -- hack for reactors
            products = tryHackForReactors(tName, products)

            tItem.products = products
            tItem.recipies = recipies
            tItem.craftingGroups = getCraftingGroupsForTech(tItem)

            -- remove from dependencies products and crafting groups from itself
            for p in pairs(products) do
                tItem.dependencies.products[p] = nil
            end
            for craftingCategory in pairs(tItem.craftingGroups) do
                tItem.dependencies.craftingGroups[craftingCategory] = nil
            end

            -- calculate dependencies from another technologies
            local otherTechnologies = tree.technologies.linked[tName]
            if otherTechnologies then
                tItem.dependencies.technologies = table.deepcopy(otherTechnologies)
            end
        end
    end
end

local isEmptyList = function (list)
    if list == nil then
        return true
    end

    for _, v in pairs(list) do
        return false
    end

    return true
end

local nodeSetupAvailableProductsAndCraftingGroups = function (tree)
    local tItem = tree.technologies.all[tree.cursor.current]
    local tName = tItem.ref.name

    if isEmptyList(tItem.dependencies.technologies) then
        tItem.allAvailable.products = table.deepcopy(default.list)
        tItem.allAvailable.craftingGroups = getDefaultCraftingGroups()
    else
        tItem.allAvailable.products = {}
        tItem.allAvailable.craftingGroups = {}
    end

    for product, value in pairs(tItem.products) do
        tItem.allAvailable.products[product] = value
        local itm = tree.cache.products[product]
        if itm == nil or itm.source == nil then
            tree.cache.products[product] = {source = tName}
        end
    end

    for craftingGroup, value in pairs(tItem.craftingGroups) do
        tItem.allAvailable.craftingGroups[craftingGroup] = value
        local itm = tree.cache.craftingGroups[craftingGroup]
        if itm == nil or itm.source == nil then
            tree.cache.craftingGroups[craftingGroup] = {source = tName}
        end
    end

end

local isTechResearchable = function (tree, tItem)
    local requirements = {
        products = table.deepcopy(tItem.dependencies.products),
        craftingGroups = table.deepcopy(tItem.dependencies.craftingGroups),
    }
    if requirements.products == nil then
        return nil
    end

    for product, v in pairs(requirements.products) do
        local value = tree.cache.products[product]
        if value then
            requirements.products[product] = {source = value.source}
        end
    end

    for craftingGroup, v in pairs(requirements.craftingGroups) do
        local value = tree.cache.craftingGroups[craftingGroup]
        if value then
            requirements.craftingGroups[craftingGroup].source = value.source
        end
    end

    -- check with current available products & tech groups
    local missing = 0
    for product, req in pairs(requirements.products) do
        if req and req.source == nil  then
            if tree.cache.products[product] then
                requirements.products[product].source = 'global'
            else
                missing = missing + 1
            end
        end
    end
    for craftingGroup, req in pairs(requirements.craftingGroups) do
        if req and req.source == nil then
            if tree.cache.craftingGroups[craftingGroup] then
                requirements.craftingGroups[craftingGroup].source = 'global'
            else
                missing = missing + 1
            end
        end
    end

    -- check dependecies from technologies
    if tItem.dependencies and tItem.dependencies.technologies then
        for _, technology in ipairs(tItem.dependencies.technologies) do
            local check = tree.technologies.all[technology]
            if check == nil or check.isHandled == false then
                missing = missing + 1
            end
        end
    end

    if missing > 0 then
        return nil
    end

    return requirements
end

local handleDependecies = function(target, deps)

    -- log("handle for "..target.ref.name..":"..json.encode(deps))

    local map = {}
    if target.dependencies.technologies then
        for _, tech in ipairs(target.dependencies.technologies) do
            map[tech] = {}
        end
    else
        target.dependencies.technologies = {}
    end

    if deps.products then
        for _, value in pairs(deps.products) do
            if value and value.source ~= '' and value.source ~= 'global' and map[value.source] == nil then
                map[value.source] = {}
                table.insert(target.dependencies.technologies, value.source)
            end
        end
    end

    if deps.craftingGroups then
        for _, value in pairs(deps.craftingGroups) do
            if value and value.source ~= '' and value.source ~= 'global' and map[value.source] == nil then
                map[value.source] = {}
                table.insert(target.dependencies.technologies, value.source)
            end
        end
    end

end


local getNextCursor = function (tree)
    local cursor = tree.cursor.current
    for tName, tItem in pairs(tree.technologies.all) do
        if techIsValid(tItem) and tItem.isHandled == false then
            local deps = isTechResearchable(tree, tItem)
            if deps ~= nil then
                handleDependecies(tItem, deps)
                return tName
            end
        end
    end

    return cursor
end

local handleScienceForCurrent = function (tree)
    local tItem = tree.technologies.all[tree.cursor.current]
    local name = tItem.ref.name

    if tItem.isMilitary then
        tItem.science[science.military] = 1
        if tItem.dependencies.technologies[t.science.military] == nil then
            table.insert(tItem.dependencies.technologies, t.science.military)
        end
    end

    if tItem.dependencies.technologies then
        for _, tech in ipairs(tItem.dependencies.technologies) do
            local parent = tree.technologies.all[tech]
            if parent then
                for pack in pairs(parent.science) do
                    tItem.science[pack] = 1
                end
                if parent.isResearch then
                    for pack in pairs(parent.sciencePacks) do
                        tItem.science[pack] = 1
                    end
                end
            end
        end
    else
        -- starting technology
        tItem.science[science.industrial] = 1
    end

    for pack, count in pairs(tItem.science) do
        apm.lib.utils.technology.add.science_pack(name, pack, count)
    end
end

local tryHandleModules = function (tree)
    if tree.cursor.current ~= 'modules' then
        return
    end

    local iteration = tree.technologies.all[tree.cursor.current].ID

    for moduleTechName, tItem in pairs(tree.technologies.modules) do
        tItem.isHandled = true
        tItem.ID = iteration
        if tItem.products then
            for product, value in pairs(tItem.products) do
                local itm = tree.cache.products[product]
                if itm == nil or itm.source == nil then
                    tree.cache.products[product] = {source = moduleTechName}
                end
            end
        end
    end
end

local treeWalk = function (tree)
    local iteration = 0
    while tree.cursor.current ~= tree.cursor.previous do
        table.insert(tree.queue, tree.cursor.current)
        tree.cursor.previous = tree.cursor.current
        iteration = iteration + 1

        nodeSetupAvailableProductsAndCraftingGroups(tree)
        handleScienceForCurrent(tree)
        tryHandleModules(tree)

        local current = tree.technologies.all[tree.cursor.current]
        current.ID = iteration
        current.isHandled = true

        tree.cursor.current = getNextCursor(tree)
    end
end

local setupDefaultProductsAndCraftingGroups = function (tree)
    tree.cache.products = table.deepcopy(default.list)
    tree.cache.craftingGroups = table.deepcopy(getDefaultCraftingGroups())
end

local describe = function (name, tree)
    local tItem = tree.technologies.all[name]
    log('describe: '..name)
    if tItem == nil or tItem.dependencies == nil then
        log('item or nil deps')
        return
    end
    for product in pairs(tItem.dependencies.products) do
        local ok = tree.cache.products[product]
        if ok == nil then
            log('product:  '..product)
        end
    end
    for group in pairs(tItem.dependencies.craftingGroups) do
        local ok = tree.cache.craftingGroups[group]
        if ok == nil then
            log('craftingGroups:  '..group)
        end
    end
    log(json.encode(tItem))
end

local sortDependecies = function (tree)
    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]
        if target and target.dependencies and target.dependencies.technologies then
            table.sort(target.dependencies.technologies, function (a,b)
                local aID = tree.technologies.all[a].ID
                local bID = tree.technologies.all[b].ID
                return aID > bID
            end)
        end
    end
end

local walkSubtree
walkSubtree = function (tree, subrootName, fn)
    fn(subrootName)
    local subroot = tree.technologies.all[subrootName]
    if subroot and subroot.dependencies and subroot.dependencies.technologies then
        for _, depName in pairs(subroot.dependencies.technologies) do
           walkSubtree(tree, depName, fn) 
        end
    end
end

local treeOptimize = function (tree)
    -- Try to reduce graph by aggresive usage of indirect dependecies
    -- sort dependecies by research iteration
    -- expecting more late technology has more inderect dependencies for current
    -- tree.queue sorted by asc research iter by builder algo
    sortDependecies(tree)

    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]
        if target and target.dependencies and target.dependencies.technologies then
            local candidates = {}
            local dependencies = {}
            for _, depName in pairs(target.dependencies.technologies) do
                local ok = dependencies[depName]
                if ok == nil then
                    table.insert(candidates, depName)
                    walkSubtree(tree, depName, function (name)
                        dependencies[name] = {}
                    end)
                end
            end
            target.dependencies.technologies = candidates
        end
    end
end

local inGameLinkTech = function (tree)
    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]
        if target and target.dependencies and target.dependencies.technologies then
            for _, tech in ipairs(target.dependencies.technologies) do
                apm.lib.utils.technology.add.prerequisites(target.ref.name, tech)
            end
        end
    end
end

local sortTechnologiesSetByKeys = function (tree)
    table.sort(tree.technologies.all, function (a,b)
        local aName = tree.technologies.all[a].name
        local bName = tree.technologies.all[b].name
        return aName < bName
    end)
end

apm.bob_rework.lib.utils.tech.tree.rebuild = function (startingTName)
    local tree = emptyTree()

    appendTechologiesSet(tree)
    tree.technologies.linked = getLinks()
    -- sortTechnologiesSetByKeys(tree)
    setupTechnologyFlags(tree)

    disableEmptyTechnologies(tree)
    resetTechnologies(tree)
    setupDefaultProductsAndCraftingGroups(tree)
    calculateProductsAndDependecies(tree)
    setupResearchFlag(tree)

    tree.cursor.current = startingTName
    treeWalk(tree)

    -- log(json.encode(tree))

    treeOptimize(tree)
    inGameLinkTech(tree)

    -- log(json.encode(tree))
    local why = function (name)
        describe(name, tree)
    end
    -- describe('bob-steam-engine-2', tree)
    why('space-science-pack')
    why('bob-nuclear-power-3')
    why('deuterium-fuel-reprocessing')

    log('total handled technologies count '..tostring(tree.technologies.all[tree.cursor.current].ID))
end