local bob           = require "lib.entities.bob"
local science       = require "lib.entities.science"
local t             = require "lib.entities.tech"
local default       = require "lib.entities.default"
local json          = require "lib.utils.json"
local techtree_data = require "lib.utils.techtree_data"

-- Package for tech tree rebuilding

if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.tech == nil then apm.bob_rework.lib.utils.tech = {} end
if apm.bob_rework.lib.utils.tech.tree == nil then apm.bob_rework.lib.utils.tech.tree = {} end

local DBG = true

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

local modulesHashMap = function()
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
    [t.processing.gem.I] = { t.processing.grinding },
    ['bob-pumpjacks-1'] = { t.processing.oil.basic },
    [t.science.steam] = { t.energy.steam.boiler.basic },
    [t.combat.turret.gun.I] = { t.crusher.burner },
    [t.processing.oil.basic] = { t.science.chemical },
    [t.battery.liio] = { t.science.chemical },
    -- [t.logistics.rail.signals] = { t.science.logistics },
    -- [t.logistics.automobile.basic] = {t.science.logistics},
    [t.logistics.automobile.basic] = { t.materials.rubber.vulcano },
    [t.logistics.inserters.red] = { t.science.logistics },
    [t.electronics.basic] = { t.science.automation },
    -- red sp bindings
    [t.electronics.advanced.I] = { t.science.logistics },
    -- purple sp bindings
    [t.electronics.advanced.II] = { t.science.production },
    -- pink sp bindings
    [t.electronics.advanced.III] = { t.science.advanced.logistics },
    -- nuclear bindings
    [t.nuclear.rtg] = { t.science.nuclear },
    [t.nuclear.processing.thorium] = { t.science.nuclear },
    [t.nuclear.breeder] = { t.science.nuclear },
    [t.nuclear.portable.reactor] = { t.science.nuclear },
    [t.nuclear.synthesys.plutonium] = { t.science.nuclear },
    [t.nuclear.portable.reactor] = { t.science.nuclear },
    [t.nuclear.thorium] = { t.science.nuclear, t.nuclear.thorium_breeder },
    [t.nuclear.fuel.product] = { t.science.nuclear, t.nuclear.synthesys.plutonium },
    [t.energy.heat.pipe.basic] = { t.boiler.burner.advanced },
    [t.logistics.wagon.fluid.basic] = { t.logistics.rail.ways },
    [t.device.lamp] = { t.electricity },
    [t.energy.solar.basic] = { t.electricity },
    [t.network.basic] = { t.electricity },
    [t.network.ltn] = { t.network.basic },
    [t.equipment.shield.basic] = { t.electricity },
    [t.boiler.oil.basic] = { t.fluid.control.extra },
    [t.nuclear.processing.heavy_water] = { t.nuclear.uranium },
    [t.processing.low_density_structure] = { t.nuclear.uranium },
    [t.nuclear.processing.uranium] = { t.science.production },
    [t.combat.shield.II] = { t.combat.shield.I },
    [t.combat.shield.III] = { t.combat.shield.II },
    [t.combat.shield.IV] = { t.combat.shield.III },
    [t.processing.gold] = { t.science.logistics },
    [t.processing.grinding] = { t.science.logistics },
    [t.processing.titanium] = { t.science.production },
    [t.processing.tungsten] = { t.science.production },
    [t.buff.hp] = { t.military.II },
    [t.nuclear.deuterium] = { t.science.advanced.logistics },
    [t.combat.tank.electric] = { t.combat.tank.base },
    [t.combat.car.electric] = { t.combat.car.base },
    [t.effect.heat.pipe.advanced] = { t.science.production },
    [t.effect.heat.pipe.expert] = { t.science.nuclear },
    [t.nuclear.processing.deuterium] = { t.science.nuclear, t.science.space },
    [t.nuclear.fuel.deuterium.cell.advanced] = { t.nuclear.deuterium },

}

local getLinks = function()
    local map = table.deepcopy(linkedTechMap)
    for _, list in ipairs(techtree_data.tiers) do
        log(json.encode(list))
        local prev = nil
        for _, target in pairs(list) do
            log('debug ' .. target)
            if prev then
                if map[target] == nil then
                    map[target] = {}
                end
                log('from ' .. target .. ' to ' .. prev)
                table.insert(map[target], prev)
            end
            prev = target
        end
    end

    return map
end

local reactorProductsMap = {
    [t.nuclear.uranium] = { ['apm_fuel_rod_uranium_active'] = {}, ['apm_fuel_rod_mox_active'] = {}, ['apm_fuel_rod_thorium_active'] = {}, ['apm_fuel_rod_neptunium_active'] = {} },
    [t.nuclear.thorium] = { ['apm_fuel_rod_uranium_active'] = {}, ['apm_fuel_rod_mox_active'] = {}, ['apm_fuel_rod_thorium_active'] = {}, ['apm_fuel_rod_neptunium_active'] = {} },
    [t.nuclear.breeder] = { ['used-up-thorium-fuel-cell'] = {} },
    [t.nuclear.fuel.reprocessing] = { ['apm_oxide_pellet_u238'] = {} },
    [t.nuclear.synthesys.plutonium] = { ['plutonium-239'] = {} },
    [t.nuclear.deuterium] = { ['used-up-deuterium-fuel-cell'] = {} },
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
            depth = {},
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
local appendTechologiesSet = function(tree)
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

local techIsValid = function(tItem)
    if tItem.isEmpty == true or tItem.isModuleBranch == true or tItem.isBuff == true then
        return false
    end

    return true
end

local extractResearchUnits = function(tech)
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

local technologyIsEmpty = function(tech)
    if tech.effects == nil then
        return true
    end

    for _, itm in ipairs(tech.effects) do
        return false
    end

    return true
end

local technologyHasRecipeToUnlock = function(tech)
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

local setupResearchFlag = function(tree)
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

local specialTechBufs = {}
specialTechBufs['long-inserters-1'] = true
specialTechBufs['long-inserters-2'] = true
specialTechBufs['near-inserters'] = true
specialTechBufs['more-inserters-1'] = true
specialTechBufs['more-inserters-2'] = true

local setupTechnologyFlags = function(tree)
    local modulesHashMap = modulesHashMap()

    for tName, tItem in pairs(tree.technologies.all) do
        tItem.isEmpty = technologyIsEmpty(tItem.ref)

        if technologyHasRecipeToUnlock(tItem.ref) == false and tItem.isEmpty == false then
            tItem.isBuff = true
        end
        local isSpecial = specialTechBufs[tItem.ref.name]
        if isSpecial then
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

local resetTechnologies = function(tree)
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

local disableEmptyTechnologies = function(tree)
    for tName, tItem in pairs(tree.technologies.all) do
        if tItem.isEmpty and not tItem.isBuff then
            log('technology [' .. tName .. '] was disabled (empty)')
            apm.lib.utils.technology.disable(tItem.ref)
            tItem.ref.hidden = true
            tree.technologies.all[tName] = nil
        end
    end
end

local getTechnologyProductDependecies = function(tech)
    if tech and tech.effects then
        local list = {}
        for _, effect in pairs(tech.effects) do
            if effect.type == 'unlock-recipe' and effect.recipe then
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

local getCraftingGroupsForProduct = function(name)
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

local getCraftingGroupsForTech = function(tItem)
    local groups = {}

    for product in pairs(tItem.products) do
        local subgroups = getCraftingGroupsForProduct(product)
        for k, v in pairs(subgroups) do
            groups[k] = v
        end
    end

    return groups
end

local getDefaultCraftingGroups = function()
    local groups = {}

    local products = default.list

    for product in pairs(products) do
        local subgroups = getCraftingGroupsForProduct(product)
        for k, v in pairs(subgroups) do
            groups[k] = v
        end
    end

    groups['apm_handcrafting_only'] = {}

    return groups
end

local tryHackForReactors = function(tName, list)
    local extra = reactorProductsMap[tName]
    if extra then
        for key, value in pairs(extra) do
            list[key] = value
        end
        -- log(tName..' will be enriched to :'..json.encode(list))
    end

    return list
end

local calculateProductsAndDependecies = function(tree)
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

local isEmptyList = function(list)
    if list == nil then
        return true
    end

    for _, v in pairs(list) do
        return false
    end

    return true
end

local nodeSetupAvailableProductsAndCraftingGroups = function(tree)
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
            tree.cache.products[product] = { source = tName }
        end
    end

    for craftingGroup, value in pairs(tItem.craftingGroups) do
        tItem.allAvailable.craftingGroups[craftingGroup] = value
        local itm = tree.cache.craftingGroups[craftingGroup]
        if itm == nil or itm.source == nil then
            tree.cache.craftingGroups[craftingGroup] = { source = tName }
        end
    end
end

local isTechResearchable = function(tree, tItem)
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
            requirements.products[product] = { source = value.source }
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
        if req and req.source == nil then
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


local getNextCursor = function(tree)
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

local handleScienceForCurrent = function(tree)
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

local tryHandleModules = function(tree)
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
                    tree.cache.products[product] = { source = moduleTechName }
                end
            end
        end
    end
end

local treeWalk = function(tree)
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

local setupDefaultProductsAndCraftingGroups = function(tree)
    tree.cache.products = table.deepcopy(default.list)
    tree.cache.craftingGroups = table.deepcopy(getDefaultCraftingGroups())
end

local describe = function(name, tree)
    local tItem = tree.technologies.all[name]

    log('describe: ' .. name)

    if tItem == nil then
        log('nil item')
        return
    end

    if tItem.dependencies == nil then
        log('nil deps')
        return
    end
    for product in pairs(tItem.dependencies.products) do
        local ok = tree.cache.products[product]
        if ok == nil then
            log('product:  ' .. product)
        end
    end
    for group in pairs(tItem.dependencies.craftingGroups) do
        local ok = tree.cache.craftingGroups[group]
        if ok == nil then
            log('craftingGroups:  ' .. group)
        end
    end

    log(json.encode(tItem))
end

local sortDependecies = function(tree)
    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]
        if target and target.dependencies and target.dependencies.technologies then
            table.sort(target.dependencies.technologies, function(a, b)
                local aID = tree.technologies.all[a].ID
                local bID = tree.technologies.all[b].ID
                return aID > bID
            end)
        end
    end
end

local walkSubtree
walkSubtree = function(tree, subrootName, fn)
    fn(subrootName)
    local subroot = tree.technologies.all[subrootName]
    if subroot and subroot.dependencies and subroot.dependencies.technologies then
        for _, depName in pairs(subroot.dependencies.technologies) do
            walkSubtree(tree, depName, fn)
        end
    end
end

local treeOptimize = function(tree)
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
                    walkSubtree(tree, depName, function(name)
                        dependencies[name] = {}
                    end)
                end
            end
            target.dependencies.technologies = candidates
        end
    end
end

local inGameLinkTech = function(tree)
    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]
        if target and target.dependencies and target.dependencies.technologies then
            for _, tech in ipairs(target.dependencies.technologies) do
                apm.lib.utils.technology.add.prerequisites(target.ref.name, tech)
            end
        end
    end
end

local sortTechnologiesSetByKeys = function(tree)
    table.sort(tree.technologies.all, function(a, b)
        local aName = tree.technologies.all[a].name
        local bName = tree.technologies.all[b].name
        return aName < bName
    end)
end

local function getTechDepth(tree, tName)
    local value = tree.cache.depth[tName]
    if value then
        return value
    end

    local depth = 1

    local target = tree.technologies.all[tName]
    if target and target.dependencies and target.dependencies.technologies then
        local max = 0
        for _, depName in pairs(target.dependencies.technologies) do
            local depDepth = getTechDepth(tree, depName)
            if depDepth > max then
                max = depDepth
            end
        end
        depth = depth + max
    end

    tree.cache.depth[tName] = depth

    return depth
end

local getSciencePackCount = function(technology_name)
    local count = 0

    if not apm.lib.utils.technology.exist(technology_name) then return end

    local technology = data.raw.technology[technology_name]

    if not technology.unit then return false end
    if not technology.unit.ingredients then return false end

    for _, ingredient in pairs(technology.unit.ingredients) do
        count = count + 1
    end

    return count
end

local updateCosts = function(tree, data)
    -- try auto inherit

    local cCount = 5
    local cTime = 5

    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]
        if target.isModuleBranch == false then
            local depth = getTechDepth(tree, tName)
            local sciencePacksCount = getSciencePackCount(tName)
            apm.lib.utils.technology.mod.unit_count(tName, (depth + sciencePacksCount) * cCount)

            local utime = math.ceil(depth / 3) * cTime

            apm.lib.utils.technology.mod.unit_time(tName, utime)
        end
    end
    -- manual fixes
    for tName, cost in pairs(data) do
        local tech = tree.technologies[tName]
        if tech then
            if cost and cost.count then
                apm.lib.utils.technology.mod.unit_count(tName, cost.count)
            end
            if cost and cost.time then
                apm.lib.utils.technology.mod.unit_time(tName, cost.time)
            end
        end
    end
end

local dropDuplEffects = function(tree)
    for tName, tItem in pairs(tree.technologies.all) do
        local handled = {}
        local tech = tItem.ref
        local changed = false

        if tech and tech.effects then
            for k, v in pairs(tech.effects) do
                if tech[k] == nil then
                    handled[k] = v
                else
                    changed = true
                end
            end
        end

        if changed then
            tech.effects = handled
        end
    end
end

local calculateEvolution = function(tree)
    -- extra evo in %
    local special = {
        [t.science.military] = 3,
        [t.science.steam] = 5,
        [t.science.automation] = 10,
        
        [t.science.nuclear] = 8.0,
    }

    local specialSum = 0.0
    for _, v in pairs(special) do
        specialSum = specialSum + v
    end

    local sp = {
        [science.industrial] = 1.0,
        [science.steam] = 1.0,
        [science.automation] = 1.0,
        [science.logistics] = 1.0,
        [science.military] = 1.0,
        [science.chemical] = 1.0,
        [science.advanced.logistics] = 1.0,
        [science.production] = 1.0,
        [science.utility] = 1.0,
        [science.space] = 1.0,
    }

    local totalCost = 0.0
    local totalHandled = 0

    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]

        if target and not target.isBuff and not target.willBeIgnored then
            local cost = 0.0
            for key, _ in pairs(target.science) do
                if key and sp[key] then
                    cost = cost + sp[key]
                end
            end

            target.evolution = cost 
            totalCost = totalCost + cost
            totalHandled = totalHandled + 1
        end
    end

    -- local k = totalCost / 100
    local k = (totalCost-specialSum*0.9) / 100
    
    -- write custom effects

    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]

        if target and target.evolution > 0 then
            local v = target.evolution / k

            v = math.ceil(v*1000) / 1000

            local extra = special[target.ref.name]
            if extra then
                v = v + extra
            end

            -- if target.ref.name == 'nuclear-fuel-reprocessing' then
            --     v = v + 1.0
            -- end

            local effect = {
                type               = "nothing",
                effect_description = { "research-causes-evolution-effect", v }
            }

            if target.ref.effects then
                table.insert(target.ref.effects, effect)
            else
                target.ref.effects = { effect }
            end
        end
    end
end

-- Rampant fixed tier mapping ...
-- local evoToTierMapping={}
-- for i=1,10 do
--     evoToTierMapping[#evoToTierMapping+1] = (((i - 1) * 0.1) ^ 0.8) - 0.01
--     print(evoToTierMapping[i])
-- end
--1 -0.01
--2  0.14848931924611
--3  0.26594593229224
--4  0.37167789096182
--5  0.47044977359257
--6  0.56434917749852
--7  0.65453980594897
--8  0.74175864665005
--9  0.82651164207302
--10 0.90916611884012

local rampantFixedCost = {16, 14, 13, 11, 13, 13, 16, 20}

local experimentalEvo = function (tree)
    local sp = {
        [science.industrial] = 1.0,
        [science.steam] = 1.0,
        [science.automation] = 1.0,
        [science.logistics] = 1.0,
        -- [science.military] = 0.0, -- ignore military as tier lvl
        [science.chemical] = 1.0,
        [science.advanced.logistics] = 1.0,
        [science.production] = 1.0,
        [science.utility] = 1.0,
        [science.space] = 1.0,
    }

    local techTier = {0,0,0,0,0,0,0,0} -- max 8
    local totalHandled = 0

    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]

        if target and not target.isBuff and not target.willBeIgnored then
            local tier = 0
            for key, _ in pairs(target.science) do
                if key and sp[key] then
                    tier = tier + 1
                end
            end

            target.tier = tier
            totalHandled = totalHandled + 1
            techTier[tier] = techTier[tier] + 1
        end
    end

    local techTierCost = {0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0}
    -- local w = 100/8
    for index, value in ipairs(techTier) do
        -- techTierCost[index] = w/(value + 1)
        techTierCost[index] = rampantFixedCost[index]/(value + 1)
    end

    -- build evo

    for _, tName in pairs(tree.queue) do
        local target = tree.technologies.all[tName]

        if target and target.tier then
            target.evolution = techTierCost[target.tier]

            if sp[target.ref.name] then
                target.evolution = techTierCost[target.tier]*2.2
            end

             if target.ref.name == 'nuclear-fuel-reprocessing' then
                target.evolution = target.evolution + 8.0
            end
        end

        if target and target.evolution > 0 then
            local v = target.evolution

            v = math.ceil(v*1000) / 1000

            -- local extra = special[target.ref.name]
            -- if extra then
                -- v = v + extra
            -- end
            

            local effect = {
                type               = "nothing",
                effect_description = { "research-causes-evolution-effect", v }
            }

            if target.ref.effects then
                table.insert(target.ref.effects, effect)
            else
                target.ref.effects = { effect }
            end
        end
    end

    -- apm.lib.utils.debug.object(techTier)
    -- apm.lib.utils.debug.object(techTierCost)
end

local cleanupItems = function (tree)
    for tName, tech in pairs(tree.technologies.all) do
        if  not tech.isHandled and not tech.isBuff then
            -- apm.lib.utils.debug.object(tName)
            -- apm.lib.utils.debug.object(tech.ref.effects)
        end
    end
end

apm.bob_rework.lib.utils.tech.tree.rebuild = function(startingTName)
    local tree = emptyTree()

    appendTechologiesSet(tree)

    -- log(apm.lib.utils.debug.object(data.raw.technology))

    tree.technologies.linked = getLinks()
    -- sortTechnologiesSetByKeys(tree)
    setupTechnologyFlags(tree)

    disableEmptyTechnologies(tree)
    resetTechnologies(tree)
    setupDefaultProductsAndCraftingGroups(tree)
    calculateProductsAndDependecies(tree)
    -- dropDuplEffects(tree)
    setupResearchFlag(tree)

    tree.cursor.current = startingTName
    treeWalk(tree)

    -- log(json.encode(tree))

    treeOptimize(tree)
    inGameLinkTech(tree)

    updateCosts(tree, techtree_data.recalculate.tech_cost)

    -- log(json.encode(tree.technologies.all))

    local why = function(name)
        describe(name, tree)
    end

    -- why('logistics-0')
    -- why('bob-plasma-rocket')

    -- describe('bob-steam-engine-2', tree)
    -- why('space-science-pack')
    -- why('bob-nuclear-power-3')
    -- why('deuterium-fuel-reprocessing')
    --
    log('total handled technologies count ' .. tostring(tree.technologies.all[tree.cursor.current].ID))

    if settings.startup["apm_bob_rework_tech_to_evo_enabled"].value then
        -- calculateEvolution(tree)
        experimentalEvo(tree)
    end

    cleanupItems(tree)
end
