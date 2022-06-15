if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.utils == nil then apm.bob_rework.lib.utils = {} end
if apm.bob_rework.lib.utils.tech == nil then apm.bob_rework.lib.utils.tech = {} end

require('lib.utils.debug')
require('lib.utils.recipe')
require('lib.utils.assembler')

local hasRecipeTag = 'has-recipe'
local unlockRecipeTag = 'unlock-recipe'
-- local defaultType = 'default-statup-recipe'
local moduleList = {
    ['module-case'] ={},
    ['module-circuit-board'] ={},
    ['speed-processor'] ={},
    ['effectivity-processor'] ={},
    ['productivity-processor'] ={},
    ['pollution-clean-processor'] ={},
    ['pollution-create-processor'] ={},
}
local buffList = {
    ['toolbelt'] = {},
    ['toolbelt-2'] = {},
    ['toolbelt-3'] = {},
    ['toolbelt-4'] = {},
    ['toolbelt-5'] = {},
    ['steel-axe'] = {deps = {}},
    ['steel-axe-2'] = {},
    ['steel-axe-3'] = {},
    ['steel-axe-4'] = {},
    ['steel-axe-5'] = {},
    ['steel-axe-6'] = {},
    ['weapon-shooting-speed-1'] = {deps = {['military-science-pack']={}}},
    ['weapon-shooting-speed-2'] = {},
    ['weapon-shooting-speed-3'] = {},
    ['weapon-shooting-speed-4'] = {},
    ['weapon-shooting-speed-5'] = {},
    ['weapon-shooting-speed-6'] = {},
    ['physical-projectile-damage-1'] = {deps = {['military-science-pack']={}}},
    ['physical-projectile-damage-2'] = {},
    ['physical-projectile-damage-3'] = {},
    ['physical-projectile-damage-4'] = {},
    ['physical-projectile-damage-5'] = {},
    ['physical-projectile-damage-6'] = {},
    ['physical-projectile-damage-7'] = {},
    ['stronger-explosives-1'] = {deps = {['explosives']={}}},
    ['stronger-explosives-2'] = {},
    ['stronger-explosives-3'] = {},
    ['stronger-explosives-4'] = {},
    ['stronger-explosives-5'] = {},
    ['stronger-explosives-6'] = {},
    ['stronger-explosives-7'] = {},
    ['inserter-capacity-bonus-1'] = {},
    ['inserter-capacity-bonus-2'] = {},
    ['inserter-capacity-bonus-3'] = {},
    ['inserter-capacity-bonus-4'] = {},
    ['inserter-capacity-bonus-5'] = {},
    ['inserter-capacity-bonus-6'] = {},
    ['inserter-capacity-bonus-7'] = {},
    ['inserter-capacity-bonus-8'] = {},
    ['laser-shooting-speed-1'] = {deps = {['laser-turret']={}}},
    ['laser-shooting-speed-2'] = {},
    ['laser-shooting-speed-3'] = {},
    ['laser-shooting-speed-4'] = {},
    ['laser-shooting-speed-5'] = {},
    ['laser-shooting-speed-6'] = {},
    ['laser-shooting-speed-7'] = {},
    ['rampant-arsenal-technology-character-health-1'] = {deps = {['advanced-electronics']={}}},
    ['rampant-arsenal-technology-character-health-2'] = {},
    ['rampant-arsenal-technology-character-health-3'] = {},
    ['rampant-arsenal-technology-character-health-4'] = {},
    ['rampant-arsenal-technology-character-health-5'] = {},
    ['rampant-arsenal-technology-character-health-6'] = {},
    ['rampant-arsenal-technology-character-health-7'] = {},
    ['mining-productivity-1'] = {deps = {['logistics-2']={}}},
    ['mining-productivity-2'] = {},
    ['mining-productivity-3'] = {},
    ['mining-productivity-4'] = {},
    ['refined-flammables-1'] = {},
    ['refined-flammables-2'] = {},
    ['refined-flammables-3'] = {},
    ['refined-flammables-4'] = {},
    ['refined-flammables-5'] = {},
    ['refined-flammables-6'] = {},
    ['refined-flammables-7'] = {},
    ['energy-weapons-damage-1'] = {deps = {['laser-turret']={}}},
    ['energy-weapons-damage-2'] = {},
    ['energy-weapons-damage-3'] = {},
    ['energy-weapons-damage-4'] = {},
    ['energy-weapons-damage-5'] = {},
    ['energy-weapons-damage-6'] = {},
    ['energy-weapons-damage-7'] = {},
    ['follower-robot-count-1'] = {},
    ['follower-robot-count-2'] = {},
    ['follower-robot-count-3'] = {},
    ['follower-robot-count-4'] = {},
    ['follower-robot-count-5'] = {},
    ['follower-robot-count-6'] = {},
    ['follower-robot-count-7'] = {},
    ['braking-force-1'] = {},
    ['braking-force-2'] = {},
    ['braking-force-3'] = {},
    ['braking-force-4'] = {},
    ['braking-force-5'] = {},
    ['braking-force-6'] = {},
    ['braking-force-7'] = {},
    ['worker-robots-storage-1'] = {},
    ['worker-robots-storage-2'] = {},
    ['worker-robots-storage-3'] = {},
    ['bob-infinite-worker-robots-storage-1'] = {deps = {['robotics']={}}},
    ['bob-infinite-character-logistic-trash-slots-1'] = {deps = {['robotics']={}}},
    ['worker-robots-speed-1'] = {deps = {['robotics']={}}},
    ['worker-robots-speed-2'] = {},
    ['worker-robots-speed-3'] = {},
    ['worker-robots-speed-4'] = {},
    ['worker-robots-speed-5'] = {},
    ['worker-robots-speed-6'] = {},
    ['artillery-shell-range-1'] = {deps = {['production-science-pack']={}}},
    ['artillery-shell-speed-1'] = {deps = {['production-science-pack']={}}},
    ['research-speed-1'] = {deps = {['logistic-science-pack']={}}},
    ['research-speed-2'] = {},
    ['research-speed-3'] = {},
    ['research-speed-4'] = {},
    ['research-speed-5'] = {},
    ['research-speed-6'] = {},
    ['inserter-stack-size-bonus-1'] = {deps= {['apm_inserter_capacity_bonus'] = {}}},
    ['inserter-stack-size-bonus-2'] = {deps= {['apm_inserter_capacity_bonus'] = {}}},
    ['inserter-stack-size-bonus-3'] = {deps= {['apm_inserter_capacity_bonus'] = {}}},
    ['inserter-stack-size-bonus-4'] = {deps= {['apm_inserter_capacity_bonus'] = {}}},
    ['inserter-stack-size-bonus-5'] = {},
    ['inserter-stack-size-bonus-6'] = {},
    ['inserter-stack-size-bonus-7'] = {},
    ['inserter-stack-size-bonus-8'] = {},
    ['inserter-stack-size-bonus-9'] = {},
}

local militarySP = 'military-science-pack'
local steamSP = 'apm_steam_science_pack'
local chemicalSP = 'chemical-science-pack'
local logisticSP = 'logistic-science-pack'
local automationSP = 'automation-science-pack'
local advancedLogisticSP = 'advanced-logistic-science-pack'
local utilitySP = 'utility-science-pack'
local nuclearSP = 'apm_nuclear_science_pack'
local productionSP = 'production-science-pack'
local spaceSP = 'space-science-pack'
local industrialSP = 'apm_industrial_science_pack'

local sciencePackFrom = {
    ['military-science-pack'] = militarySP,
    ['apm_steam_science_pack'] = steamSP,
    ['chemical-science-pack'] = chemicalSP,
    ['logistic-science-pack'] = logisticSP,
    ['apm_power_automation_science_pack'] = automationSP,
    ['advanced-logistic-science-pack'] = advancedLogisticSP,
    ['utility-science-pack'] = utilitySP,
    ['apm_nuclear_science_pack'] = nuclearSP,
    ['space-science-pack'] = spaceSP,
    ['production-science-pack'] = productionSP,
}

function apm.bob_rework.lib.utils.tech.getTechFromSP(sp)
    if sp == nuclearSP then return 'apm_nuclear_science_pack' end
    if sp == steamSP then return 'apm_steam_science_pack' end
    if sp == automationSP then return 'apm_power_automation_science_pack' end
    return sp
end

local techTier = {
    [1] = {
        science = {[0] = industrialSP, [1] = steamSP},
        core= {
            [0] = 'apm_fuel-3', [1] = 'apm_coking_plant_1', [2] = 'apm_tools_2', [3] = 'more-inserters-1',
            [4] = 'military-science-pack', [5] = 'physical-projectile-damage-1', [6] = 'weapon-shooting-speed-1',
        },
    },
    [2] = {
        science = {[0] = industrialSP, [1] = steamSP, [2] = automationSP},
        core = {
            [0] = 'chemical-processing-1', [1] = 'inserter-stack-size-bonus-1', [2] = 'electric-engine', [3] = 'fluid-handling', [4] = 'electrolysis',
            [5] = 'apm_electric_mining_drills', [6] = 'automation', [7] = 'logistics', [8] = 'pumpjack',
            [9] = 'electronics-machine-1', [10] = 'automation-2',
            
        },
    },
    [3] = {
        science = {[0] = industrialSP, [1] = steamSP, [2] = automationSP, [3] = logisticSP},
        core = {
            [0] = 'logistic-train-network', [1] = 'fluid-wagon', [2] = 'electrolysis-2', [3] = 'more-inserters-2',
            [4] = 'bob-heat-pipe-1', [5] = 'fast-inserter', [6] = 'chemical-plant', [7] = 'bob-distillery-2',
            [8] = 'apm_fuel-4', [9] = 'bob-pumpjacks-1', [10] = 'inserter-stack-size-bonus-1',
            [11] = 'engine',
        },
    },
    [4] = {
        science = {[0] = industrialSP, [1] = steamSP, [2] = automationSP, [3] = logisticSP, [4] = chemicalSP},
        core = {
            [0] = 'lead-processing', [1] = 'electrolyser-2', [2] = 'electric-pole-2', [3] = 'lithium-processing',
            [4] = 'advanced-oil-processing', [5] = 'toolbelt-2', [6] = 'inserter-stack-size-bonus-2',
        },
    },
    [5] = {
        science = {[0] = industrialSP, [1] = steamSP, [2] = automationSP, [3] = logisticSP, [4] = chemicalSP, [5] = advancedLogisticSP},
        core = {
            [0] = 'inserters-stack-size-bonus-2', [1] = 'gas-canisters',
        },
    },
    [6] = {
        science = {[0] = industrialSP, [1] = steamSP, [2] = automationSP, [3] = logisticSP, [4] = chemicalSP, [5] = advancedLogisticSP, [6] = productionSP},
        core = {
            [0] = 'electrolyser-3',
        },
    },
    [7] = {
        science = {[0] = industrialSP, [1] = steamSP, [2] = automationSP, [3] = logisticSP, [4] = chemicalSP,  [5] = advancedLogisticSP, [6] = productionSP, [7] = utilitySP},
        core = {
            [0] = 'heavy-water-processing', [1] = 'electrolyser-4',
        },
    },
    [8] = {
        science = {[0] = industrialSP, [1] = steamSP, [2] = automationSP, [3] = logisticSP, [4] = chemicalSP, [5] = advancedLogisticSP, [6] = productionSP, [7] = utilitySP, [8] = nuclearSP},
        core = {
            [0] = 'electrolyser-5', [1] = 'apm_nuclear_thorium_processing',
        },
    },
    [9] = {
        science = {[0] = industrialSP, [1] = steamSP, [2] = automationSP, [3] = logisticSP, [4] = chemicalSP, [5] = advancedLogisticSP, [6] = productionSP, [7] = utilitySP, [8] = nuclearSP, [9] = spaceSP},
    },
    [10] = {
        addative = true,
        science = {[0] = militarySP},
        core = {
            [0] = 'bob-turrets-2', [1] = 'rampant-arsenal-technology-shotgun', [2] = 'physical-projectile-damage-1', [3] = 'physical-projectile-damage-2',
            [4] = 'weapon-shooting-speed-1', [5] = 'heavy-armor', [6] = 'bob-sniper-turrets-1', [7] = 'night-vision-equipment',
            [8] = 'exoskeleton-equipment', [9] = 'solar-panel-equipment', [10] = 'power-armor-mk2',
            [11] = 'military-2'
        }
    },
}

function apm.bob_rework.lib.utils.tech.free(name)
    apm.lib.utils.technology.disable(name)
    apm.lib.utils.technology.delete(name)
    -- force
    if data.raw.technology[name] then
        data.raw.technology[name] = nil
    end
end

function apm.bob_rework.lib.utils.tech.rebuild(startingTName, startingSciencePack)
    local map = {}
    map[unlockRecipeTag] = {}
    map[hasRecipeTag] = {}
    local techMap = {}
    local depMap = {}
    local reverseDepMap = {}
   

    local availableProducts = apm.bob_rework.lib.utils.recipe.allItems()
    -- local availableProducts = apm.bob_rework.lib.utils.tech.startingList(startingTName)
    local whitelist = apm.bob_rework.lib.utils.tech.special()
    for _, tech in pairs(data.raw.technology) do
        local tName = tech.name
        if apm.bob_rework.lib.utils.tech.hasEffects(tech) then 
            techMap[tName] = tech
            apm.bob_rework.lib.utils.tech.pushItems(tech, map, availableProducts)
        else
            -- try drop tech without any effects
            if not whitelist[tName] then
                apm.bob_rework.lib.utils.debug.object('tech rebuild:: drop empty tech: ' .. tName)
                apm.bob_rework.lib.utils.tech.free(tName)
            end
        end
    end
    -- ignore pushItems
    availableProducts = apm.bob_rework.lib.utils.tech.startingList()

    -- for tname, _ in pairs(techMap) do
    -- local tech = data.raw.technology[tname]
    for tName, tech in pairs(techMap) do
        if not apm.bob_rework.lib.utils.tech.isModule(tName) then
            if not buffList[tName] then
                apm.bob_rework.lib.utils.tech.dropAllPrerequisites(tech)
                apm.bob_rework.lib.utils.tech.dropAllSciencePacks(tech)
            end
        end
    end

    local startingTech = data.raw.technology[startingTName]
    apm.bob_rework.lib.utils.tech.insertSciencePack(startingTech, startingSciencePack)
    -- apm.bob_rework.lib.utils.tech.toogleItems(startingTech, availableProducts)

    -- apm.bob_rework.lib.utils.debug.object('JIB: availableProducts::')
    -- apm.bob_rework.lib.utils.debug.object(availableProducts)
    -- apm.bob_rework.lib.utils.debug.object('JIB: techMap::')
    -- apm.bob_rework.lib.utils.debug.object(techMap)

    local done = false
    local ind = 1
    local researchedTech = {}
    local t = {}
    t[startingTech.name] = startingTech
    local availableCraftingGroups = apm.bob_rework.lib.utils.tech.defaultCtaftingGroups()
    local sciencePacksMap = {
        [-1] = {pack = startingSciencePack}
    }
    apm.bob_rework.lib.utils.tech.buildLine(t, availableProducts, availableCraftingGroups, researchedTech, sciencePacksMap, depMap, reverseDepMap, ind)
    while not done do
        done = apm.bob_rework.lib.utils.tech.buildLine(techMap, availableProducts, availableCraftingGroups, researchedTech, sciencePacksMap, depMap, reverseDepMap, ind)
        ind = ind + 1
    end

    for tName, _ in pairs(researchedTech) do
        if not apm.bob_rework.lib.utils.tech.isModule(tName) then
            apm.bob_rework.lib.utils.debug.object('tech test  not a module tech ' .. tName)
            -- apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites(tName)
            -- drop modules
            for module, _ in pairs(moduleList) do
                apm.lib.utils.technology.remove.science_pack(tName, module)
            end
            

            local base, index = string.match(tName, "^(.*)-(%d+)$")
            if base and index then
                local ind = tonumber(index)
                local prev = ind - 1
                local suffix = '-' .. tostring(prev)
                if prev == 1 then
                    -- hack for some bob's tech (like tank - bob-tanks-2 and etc)
                    local _, dependency = string.match(base, "(.+)-(.+)s$")
                    if not dependency then
                        _, dependency = string.match(base, "(.+)-(.+)$")
                    end 
                    
                    apm.bob_rework.lib.utils.tech.addDependency(tName, dependency, depMap)
                    -- apm.lib.utils.technology.add.prerequisites(tName, dependency)
                    dependency = base
                    apm.bob_rework.lib.utils.tech.addDependency(tName, dependency, depMap)
                    -- apm.lib.utils.technology.add.prerequisites(tName, dependency)
                end
                local dependency = base .. suffix
                apm.bob_rework.lib.utils.tech.addDependency(tName, dependency, depMap)
                -- apm.lib.utils.technology.add.prerequisites(tName, dependency)
            end
        end
    end

    apm.bob_rework.lib.utils.tech.extendTreeWithTTiers(researchedTech, depMap, reverseDepMap)
    apm.bob_rework.lib.utils.tech.cleanupGraph(researchedTech, depMap, reverseDepMap)
    apm.bob_rework.lib.utils.tech.handleScience(researchedTech, depMap, reverseDepMap)
    for tName, _ in pairs(researchedTech) do
    -- for tName, _ in pairs(data.raw.technology) do
        if not apm.bob_rework.lib.utils.tech.isModule(tName) then
            apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites(tName)
        end
    end

    apm.bob_rework.lib.utils.tech.postProcessByTTiers()
    apm.bob_rework.lib.utils.tech.dropModulesFromNonModules(researchedTech, depMap, reverseDepMap)
    -- apm.bob_rework.lib.utils.tech.finalHacks(researchedTech, depMap, reverseDepMap)
end


local forceBind = {
    ['bob-boiler-2'] = {['apm_power_steam']={}},
    ['apm_coking_plant_1'] = {['apm_power_steam']={}},
    ['apm_fuel-3'] = {['apm_power_steam']={}},
    ['fluid-wagon'] = {['fluid-handling']={}, ['railway']={}},
    ['apm_tools_2'] = {['apm_treated_wood_planks-1']={}},
    ['bob-turrets-2'] = {['gun-turret']={}},
    ['automated-rail-transportation'] = {['railway']={}},
    ['electric-engine'] = {['apm_power_electricity']={}},
    ['landfill'] = {['apm_ash_production']={}},
    ['more-inserters-1'] = {['apm_power_steam']={}},
    ['steel-axe'] = {['steel-processing']={}},
    ['steel-mixing-furnace'] = {['steel-processing']={}},
    ['steel-chemical-furnace'] = {['chemical-processing-1']={}},
    ['fluid-mixing-furnace'] = {['pumpjack']={}},
    ['fluid-chemical-furnace'] = {['pumpjack']={}},
    ['military-science-pack'] = {['apm_lab_1']={}},
    ['apm_tools_0'] = {['apm_press_machine_1']={}},
    ['apm_tools_1'] = {['apm_crusher_machine_1']={}},
    ['bob-drills-1'] = {['apm_electric_mining_drills']={}},
    ['bob-pumpjacks-1'] = {['pumpjack']={}},
    ['bob-solar-energy-2'] = {['solar-energy']={}},
    ['vehicle-solar-panel-equipment-1'] = {['solar-energy']={}},
    ['solar-panel-equipment'] = {['solar-energy']={}},
    ['electric-pole-2'] = {['electric-energy-distribution-1']={}},
    ['chemical-plant-2'] = {['chemical-plant']={}},
    ['stack-inserter'] = {['fast-inserter']={}},
    ['automobilism_electric-1'] = {['automobilism']={}, ['battery']={}},
    ['bob-poison-rocket'] = {['rocketry']={}},
    ['bob-explosive-rocket'] = {['rocketry']={}},
    ['bob-flame-rocket'] = {['rocketry']={}},
    ['bob-piercing-rocket'] = {['rocketry']={}},
    ['bob-acid-rocket'] = {['rocketry']={}},
    ['radars-2'] = {['military-2']={}}
}

function apm.bob_rework.lib.utils.tech.postProcessByTTiers()
    for _, v in pairs(techTier) do
        if v.core then
            for _, tName in pairs(v.core) do
                local tech = data.raw.technology[tName]
                -- apm.lib.utils.technology.add.science_pack(tName, industrialSP)
                -- apm.bob_rework.lib.utils.tech.insertSciencePack(tech, industrialSP)
                for _, sp in pairs(v.science) do
                    apm.bob_rework.lib.utils.debug.object("adding sp:: " .. tName .. ' - ' .. sp)
                    -- apm.lib.utils.technology.add.science_pack(tName, sp)
                    apm.bob_rework.lib.utils.tech.insertSciencePack(tech, sp)
                end
            end
        end
    end
end

function apm.bob_rework.lib.utils.tech.extendTreeWithTTiers(researchedTech, depMap, reverseDepMap)
    -- first add some hack
    for tName, deps in pairs(forceBind) do
        if not researchedTech[tName] then
            researchedTech[tName] = data.raw.technology[tName]
        end
        for dep, _ in pairs(deps) do
            apm.bob_rework.lib.utils.debug.object("bind force to tech:: " .. tName .. ' - ' .. dep)
            apm.bob_rework.lib.utils.tech.addDependency(tName, dep, depMap)
        end
    end
    for _, v in pairs(techTier) do
        if v.core then
            for _, tName in pairs(v.core) do
                if not v.addative then
                    apm.bob_rework.lib.utils.tech.dropAllSciencePacks(data.raw.technology[tName])
                end
                for _, sp in pairs(v.science) do
                    apm.bob_rework.lib.utils.debug.object("adding tech:: " .. tName .. ' - ' .. apm.bob_rework.lib.utils.tech.getTechFromSP(sp))
                    
                    -- apm.lib.utils.technology.add.science_pack(tName, sp)

                    if sp ~= industrialSP then
                        apm.bob_rework.lib.utils.tech.addDependency(tName, apm.bob_rework.lib.utils.tech.getTechFromSP(sp), depMap)
                    end
                end
            end
        end
    end
end

-- function apm.bob_rework.lib.utils.tech.finalHacks(researchedTech, depMap, reverseDepMap)
--     apm.lib.utils.technology.add.prerequisites('fluid-wagon', 'fluid-handling')

-- end

-- expected builded full reverseDepMap structure
function apm.bob_rework.lib.utils.tech.handleScience(researchedTech, depMap, reverseDepMap)
    local techWithSciencePacks = {
        ['military-science-pack'] = {pack = 'military-science-pack'},
        ['apm_steam_science_pack'] = {pack = 'apm_steam_science_pack'},
        ['chemical-science-pack'] = {pack = 'chemical-science-pack'},
        ['logistic-science-pack'] = {pack = 'logistic-science-pack'},
        ['apm_power_automation_science_pack'] = {pack = 'automation-science-pack'},
        ['advanced-logistic-science-pack'] = {pack = 'advanced-logistic-science-pack'},
        ['utility-science-pack'] = {pack = 'utility-science-pack'},
        ['apm_nuclear_science_pack'] = {pack = 'apm_nuclear_science_pack'},
        ['space-science-pack'] = {pack = 'space-science-pack'},
        ['production-science-pack'] = {pack = 'production-science-pack'},
        -- force mode
        ['engine'] = {force='logistic-science-pack'},
        ['oil-processing'] = {force='logistic-science-pack'},
        ['bob-fluid-handling-2'] = {force='chemical-science-pack'},
        ['fluid-chemical-furnace'] = {force='chemical-science-pack'},
        ['fluid-mixing-furnace'] = {force='chemical-science-pack'},
        ['nitroglycerin-processing'] = {force='chemical-science-pack'},
        ['sulfur-processing'] = {force='chemical-science-pack'},
        ['solid-fuel'] = {force='chemical-science-pack'},
        ['bob-oil-burner-2'] = {force='chemical-science-pack'},
        ['construction-robotics'] = {force='advanced-logistic-science-pack'},
        ['logistic-robotics'] = {force='advanced-logistic-science-pack'},
        ['defender'] = {force='advanced-logistic-science-pack'},
        ['personal-roboport-equipment'] = {force='advanced-logistic-science-pack'},
        ['bob-robotics-2'] = {force='advanced-logistic-science-pack'},
        ['bob-robo-modular-1'] = {force='advanced-logistic-science-pack'},
        ['bob-artillery-wagon-3'] = {force='utility-science-pack'},
        ['rampant-arsenal-technology-flamethrower-3'] = {force='utility-science-pack'},
        ['bob-laser-turrets-4'] = {force='utility-science-pack'},
        ['advanced-electronics-2'] = {force='production-science-pack'},
        ['advanced-electronics-3'] = {force='utility-science-pack'},
        ['rocket-silo'] = {force='space-science-pack'},
        ['nuclear-power'] = {force='apm_nuclear_science_pack'},
        ['nuclear-fuel-reprocessing'] = {force='apm_nuclear_science_pack'},
    }
    for tName, list in pairs(reverseDepMap) do
        local t = techWithSciencePacks[tName]
        if t and t.pack then
            for dep, _ in pairs(list) do
                local tech = data.raw.technology[dep] 
                apm.bob_rework.lib.utils.tech.insertSciencePack(tech, t.pack)
            end
        end
        if t and t.force then
            local tech = data.raw.technology[tName] 
            apm.bob_rework.lib.utils.tech.insertSciencePack(tech, t.force)
            apm.bob_rework.lib.utils.tech.addDependency(tName, t.force, depMap)
            apm.lib.utils.technology.add.prerequisites(tName, t.force)
        end
    end

    apm.bob_rework.lib.utils.tech.handleScienceBuffs(researchedTech, depMap, reverseDepMap)
    -- apm.bob_rework.lib.utils.tech.handleMilitary(researchedTech, depMap, reverseDepMap)
    
end

function apm.bob_rework.lib.utils.tech.handleMilitary(researchedTech, depMap, reverseDepMap)
    local pack = 'military-science-pack'
    local tList = {
        ['weapon-shooting-speed-1'] = {}, ['physical-projectile-damage-1'] = {},
        ['explosives'] = {}, ['bob-laser-rifle'] = {}, ['laser-turret'] = {}, ['bob-laser-turrets-2'] = {},
        ['vehicle-laser-defence-equipment-1'] = {}, ['personal-laser-defence-equipment'] = {},
        ['bob-laser-robot'] = {}, ['tank'] = {}, ['tanks_electric-1'] = {}, ['bob-artillery-wagon-2'] = {},
        ['rampant-arsenal-technology-lite-artillery'] = {}, ['bob-artillery-turret-2'] = {},
        ['artillery'] = {}, ['bob-bulltets'] = {}, ['bob-shotgun-shells'] = {},
        ['atomic-bomb'] = {}, ['bob-rocket'] = {}, ['bob-turrets-2'] = {}, ['bob-sniper-turrets-1'] = {},
        ['gun-turret'] = {}, ['rampant-arsenal-technology-rocket-turret-1'] = {},
    }
    apm.lib.utils.technology.add.prerequisites('bob-laser-turrets-2', 'laser-turret')
    apm.lib.utils.technology.add.prerequisites('bob-artillery-wagon-2', 'artillery')
    apm.lib.utils.technology.add.prerequisites('bob-artillery-turret-2', 'artillery')
    apm.lib.utils.technology.add.prerequisites('artillery', 'rampant-arsenal-technology-lite-artillery')
    apm.lib.utils.technology.add.prerequisites('bob-turrets-2', 'gun-turret')
    for name, _ in pairs(tList) do
        apm.lib.utils.technology.add.prerequisites(name, pack)
        apm.bob_rework.lib.utils.tech.insertSciencePack(data.raw.technology[name], pack)
    end
end

function apm.bob_rework.lib.utils.tech.dropModulesFromNonModules(researchedTech, depMap, reverseDepMap)
    for tName, tech in pairs(researchedTech) do
        if not apm.bob_rework.lib.utils.tech.isModule(tName) then
            for name, _ in pairs(moduleList) do
                apm.lib.utils.technology.remove.science_pack(tName, name)
            end 
        end
    end
    -- apm.lib.utils.technology.remove.science_pack
end

function apm.bob_rework.lib.utils.tech.handleScienceBuffs(researchedTech, depMap, reverseDepMap)

    -- apm.bob_rework.lib.utils.tech.dropAllSciencePacks(data.raw.technology['more-inserters-1'])
    -- apm.bob_rework.lib.utils.tech.dropAllSciencePacks(data.raw.technology['more-inserters-2'])
    -- apm.bob_rework.lib.utils.tech.dropAllSciencePacks(data.raw.technology['long-inserters-2'])
    -- apm.bob_rework.lib.utils.tech.dropAllSciencePacks(data.raw.technology['long-inserters-2'])
    
    
    apm.lib.utils.technology.add.prerequisites('steel-axe', 'logistics-0')
    apm.lib.utils.technology.add.prerequisites('apm_inserter_capacity_bonus', 'logistic-0')
    apm.lib.utils.technology.add.prerequisites('apm_inserter_capacity_bonus', 'apm_coking_plant_0')

    apm.lib.utils.technology.remove.prerequisites('more-inserters-1', 'logistics-2')
    apm.lib.utils.technology.add.prerequisites('more-inserters-1', 'logistics-0')
    apm.lib.utils.technology.remove.prerequisites('long-inserters-1', 'apm_puddling_furnace_0')
    apm.lib.utils.technology.add.prerequisites('long-inserters-1', 'logistics-0')
    apm.lib.utils.technology.remove.prerequisites('long-inserters-2', 'logistic-3')
    apm.lib.utils.technology.add.prerequisites('long-inserters-2', 'logistics-2')
    apm.lib.utils.technology.remove.prerequisites('more-inserters-2', 'logistic-3')
    apm.lib.utils.technology.add.prerequisites('more-inserters-2', 'logistics-2')

    apm.lib.utils.technology.add.prerequisites('weapon-shooting-speed-1', 'military-science-pack')
    apm.lib.utils.technology.add.prerequisites('physical-projectile-damage-1', 'military-science-pack')

    apm.lib.utils.technology.add.prerequisites('mining-productivity-1', 'logistics-1')
    apm.bob_rework.lib.utils.tech.insertSciencePack(data.raw.technology['apm_inserter_capacity_bonus'], 'apm_industrial_science_pack')
    apm.bob_rework.lib.utils.tech.insertSciencePack(data.raw.technology['rampant-arsenal-technology-cannon-turret-2'], 'apm_industrial_science_pack')
    apm.bob_rework.lib.utils.tech.insertSciencePack(data.raw.technology['rampant-arsenal-technology-cannon-turret-2'], 'military-science-pack')
    apm.bob_rework.lib.utils.tech.insertSciencePack(data.raw.technology['rampant-arsenal-technology-cannon-turret-2'], 'logistic-science-pack')
    apm.bob_rework.lib.utils.tech.insertSciencePack(data.raw.technology['rampant-arsenal-technology-cannon-turret-2'], 'automation-science-pack')
    apm.bob_rework.lib.utils.tech.insertSciencePack(data.raw.technology['rampant-arsenal-technology-cannon-turret-2'], 'advanced-logistic-science-pack')
    
    for buff, data in pairs(buffList) do
        if data.deps then
            for dep, _ in pairs(data.deps) do
                apm.lib.utils.technology.add.prerequisites(buff, dep)
            end
        end
    end
    
end

function apm.bob_rework.lib.utils.tech.cleanupGraph(researchedTech, depMap, reverseDepMap)
    for tName, _ in pairs(researchedTech) do
        local tDeps = depMap[tName]
        if tDeps then
            for depName, _ in pairs(tDeps) do
                if not reverseDepMap[depName] then
                    reverseDepMap[depName] = {}
                end
                reverseDepMap[depName][tName] = {}

                local deps = depMap[depName]
                if deps then
                    for key, _ in pairs(deps) do
                        if tDeps[key] then
                            tDeps[key].ignore = true
                        end
                    end
                end
            end
            for depName, dep in pairs(tDeps) do
                if not dep.ignore then
                    apm.lib.utils.technology.add.prerequisites(tName, depName)
                end
            end
        end
    end
end

function apm.bob_rework.lib.utils.tech.defaultCtaftingGroups()
    local list = apm.bob_rework.lib.utils.assembler.craftingCategories('apm_assembling_machine_0')
    list['rocket-building'] = {}
    return list
end

function apm.bob_rework.lib.utils.tech.hasEffects(tech)
    if tech and tech.effects then
        for _, v in pairs(tech.effects) do
            return true
        end
    end
    return false
end

function apm.bob_rework.lib.utils.tech.isAvailable(tech, requiredProducts, availableProducts)
    local providedProducts = apm.bob_rework.lib.utils.tech.products(tech)
    for req, _ in pairs(requiredProducts) do
        if not availableProducts[req] and not providedProducts[req] then
            return false
        end
    end
    return true
end

function apm.bob_rework.lib.utils.tech.buildLine(techMap, availableProducts, availableCraftingGroups, researchedTech, sciencePacksMap, depMap, reverseDepMap, index)
    -- apm.bob_rework.lib.utils.debug.object('tech rebuild:: buildLine .. ' .. tostring(index))
    local noChanges = true
    local dbg = 'fluid-handling'
    for tName, tech in pairs(techMap) do
        local requiredProducts = apm.bob_rework.lib.utils.tech.requiredProducts(tech, availableProducts)
        local hasItems = false
        for _, _ in pairs(requiredProducts) do
            hasItems = true
            break
        end

        if hasItems then
            -- apm.bob_rework.lib.utils.debug.object('tech rebuild:: buildLine:: required products for ' .. tName)
            -- apm.bob_rework.lib.utils.debug.object(requiredProducts)
            --
            if apm.bob_rework.lib.utils.tech.isAvailable(tech, requiredProducts, availableProducts) then
                -- check if new recipies can be crafted with current tech levels
                local techCraftingGroups = apm.bob_rework.lib.utils.tech.craftingGroups(tech)
                local requiredCraftingGroups = apm.bob_rework.lib.utils.tech.requiredCraftingGroups(tech)
                local canBeResearched = false
                local iter = 0
                --
                for required, _ in pairs(requiredCraftingGroups) do
                    iter = iter + 1
                    if techCraftingGroups[required] or availableCraftingGroups[required] then
                        canBeResearched = true
                        break
                    end
                end
                if iter == 0 then
                    canBeResearched = true
                end

                if canBeResearched then
                    -- apm.bob_rework.lib.utils.debug.object('tech rebuild:: buildLine:: tech can be researched ' .. tName)
                    techMap[tName] = nil
                    noChanges = false
                    apm.bob_rework.lib.utils.tech.mark(
                        tech, availableProducts, availableCraftingGroups,
                         techCraftingGroups, researchedTech,
                          requiredProducts, requiredCraftingGroups, sciencePacksMap, depMap, index
                        )
                    break
                end
                if not canBeResearched and tName == dbg then
                    -- apm.bob_rework.lib.utils.debug.object('tech rebuild:: buildLine:: tech can not be researched ' .. tName)
                    -- apm.bob_rework.lib.utils.debug.object('tech rebuild:: buildLine:: requiredCraftingGroups for' .. tName)
                    -- apm.bob_rework.lib.utils.debug.object(requiredCraftingGroups)
                    -- apm.bob_rework.lib.utils.debug.object('tech rebuild:: buildLine:: techCraftingGroups for ' .. tName)
                    -- apm.bob_rework.lib.utils.debug.object(techCraftingGroups)
                    -- apm.bob_rework.lib.utils.debug.object('tech rebuild:: buildLine:: availableCraftingGroups for ' .. tName)
                    -- apm.bob_rework.lib.utils.debug.object(availableCraftingGroups)

                end
            end
        else
            -- apm.bob_rework.lib.utils.debug.object('tech rebuild:: buildLine:: skipping ' .. tName)
        end
    end
    return noChanges
end

function apm.bob_rework.lib.utils.tech.isModule(tName)
    return string.find(tName, 'module') and tName ~= 'modules'
end

function apm.bob_rework.lib.utils.tech.mark(
    tech, availableProducts,
    availableCraftingGroups, techCraftingGroups,
    researchedTech, requiredProducts,
    requiredCraftingGroups,
    sciencePacksMap, depMap, index)

    local tName = tech.name
    local providedProducts = apm.bob_rework.lib.utils.tech.products(tech)
    for product, _ in pairs(providedProducts) do
        if not availableProducts[product] then
            availableProducts[product] = {by = tName}
            -- apm.bob_rework.lib.utils.debug.object('tech mark:: push new product  ' .. product  .. ' by ' .. tName)
        end
    end
    for cG, _ in pairs(techCraftingGroups) do
       if not availableCraftingGroups[cG] then
           availableCraftingGroups[cG] = {by = tName}
        --    apm.bob_rework.lib.utils.debug.object('tech mark:: push crafting group ' .. cG  .. ' by ' .. tName) 
       end
    end
    researchedTech[tName] = tech
    for required, _ in pairs(requiredProducts) do
        -- apm.bob_rework.lib.utils.debug.object('tech mark:: required for ' .. tName .. ' product ' .. required)
        -- apm.bob_rework.lib.utils.debug.object(availableProducts[required])
        if availableProducts[required] and availableProducts[required].by and availableProducts[required].by ~= tName  then
            local dependency = availableProducts[required].by
            -- apm.bob_rework.lib.utils.debug.object('tech mark:: try link ' .. tName .. ' with ' .. dependency)
            apm.bob_rework.lib.utils.tech.addDependency(tName, dependency, depMap)
            -- apm.lib.utils.technology.add.prerequisites(tName, dependency)
        end
    end
  
    -- apm.bob_rework.lib.utils.debug.object('tech mark:: required crafting groups for ' .. tName )
    -- apm.bob_rework.lib.utils.debug.object(requiredCraftingGroups)
    -- apm.bob_rework.lib.utils.debug.object(availableCraftingGroups)
    for cG, _ in pairs(requiredCraftingGroups) do
        if availableCraftingGroups[cG] and availableCraftingGroups[cG].by and availableCraftingGroups[cG].by ~= tName then
            local dependency = availableCraftingGroups[cG].by
            -- apm.bob_rework.lib.utils.debug.object('tech mark:: try link [by cf] ' .. tName .. ' with ' .. dependency)
            apm.bob_rework.lib.utils.tech.addDependency(tName, dependency, depMap)
            -- apm.lib.utils.technology.add.prerequisites(tName, dependency)
        end
    end

    apm.bob_rework.lib.utils.tech.tryAddExtraProducts(tName, availableProducts)

    -- local isMilitary = apm.bob_rework.lib.utils.tech.isMilitary(tName)
    -- if not apm.bob_rework.lib.utils.tech.isModule(tName) then
    --     for ind, v in pairs(sciencePacksMap) do
    --         if index > ind then
    --             if not isMilitary and v.pack ~= 'military-science-pack' then
    --                 -- apm.bob_rework.lib.utils.debug.object('tech mark:: try mark ' .. tName .. ' with sciencepack ' .. v.pack)
    --                 -- debug 
    --                 -- apm.lib.utils.technology.add.science_pack(tName, v.pack)
    --                 if  v.by then
    --                     -- apm.bob_rework.lib.utils.tech.addDependency(tName, v.by, depMap)
    --                     -- apm.lib.utils.technology.add.prerequisites(tName, v.by)
    --                 end
    --             end
    --         end
    --     end
    -- end

    local sciencePacks = {
        ['apm_industrial_science_pack'] = {},
        ['apm_steam_science_pack'] = {},
        ['automation-science-pack'] = {},
        ['logistic-science-pack'] = {},
        ['military-science-pack'] = {},
        ['chemical-science-pack'] = {},
        ['advanced-logistic-science-pack'] = {},
        ['production-science-pack'] = {},
        ['utility-science-pack'] = {},
        ['apm_nuclear_science_pack'] = {},
    }
    for product, _ in pairs(providedProducts) do
        if sciencePacks[product] then
            sciencePacksMap[index] = {pack = product, by = tName}
        end
    end

    -- mark same ?

end

function apm.bob_rework.lib.utils.tech.requiredCraftingGroups(tech)
    local groups = {}
    if tech and tech.effects then
        for _, v in pairs(tech.effects) do
            local eType = v.type
            if eType == unlockRecipeTag then
                local recipe = data.raw.recipe[v.recipe]
                if recipe and recipe.category then
                    groups[recipe.category] = {}
                end
            end
        end
    end
    return groups
end

function  apm.bob_rework.lib.utils.tech.craftingGroups(tech)
    local groups = {}
    if tech then
        local products = apm.bob_rework.lib.utils.tech.products(tech)
        for key, _ in pairs(products) do
            local res = apm.bob_rework.lib.utils.assembler.craftingCategories(key)
            for g, _ in pairs(res) do
                groups[g] = {}
            end
        end
    end

    return groups
end

function apm.bob_rework.lib.utils.tech.pushItems(tech, map, availableProducts)
    if tech and tech.effects then
        -- apm.bob_rework.lib.utils.debug.object('pushItems:: for ' .. tech.name)
        for _, effect in pairs(tech.effects) do
            local eType = effect.type
            -- apm.bob_rework.lib.utils.debug.object('pushItems:: effect  with type ' .. eType)
            -- apm.bob_rework.lib.utils.debug.object(effect)
            if effect.recipe then
                -- apm.bob_rework.lib.utils.debug.object('pushItems:: handle recipe' .. effect.recipe)
                local list = apm.bob_rework.lib.utils.recipe.getProducts(effect.recipe)
                -- apm.bob_rework.lib.utils.debug.object(list)
                for _, product in ipairs(list) do
                    -- apm.bob_rework.lib.utils.debug.object('pushItems:: mark item for ' .. tech.name .. ' {{' .. effect.recipe .. '}}' .. ' has product -> ' .. product)
                    availableProducts[product] = nil
                end
            end
            if map[eType] then
                map[eType][effect.recipe] = tech.name
                map[hasRecipeTag][tech.name] = true
                local list = apm.bob_rework.lib.utils.recipe.getProducts(effect.recipe)
                for _, product in ipairs(list) do
                    -- apm.bob_rework.lib.utils.debug.object('pushItems:: mark item for ' .. tech.name .. ' has product -> ' .. product)
                    availableProducts[product] = nil
                end
            else
                -- apm.bob_rework.lib.utils.debug.object('pushItems:: failed get products for effect')
                -- apm.bob_rework.lib.utils.debug.object(effect)
            end
        end
    end
end

function apm.bob_rework.lib.utils.tech.dropAllPrerequisites(tech)
    if tech then
        tech.prerequisites = {}
    end
end 

function apm.bob_rework.lib.utils.tech.dropAllSciencePacks(tech)
    if tech then
        tech.unit.ingredients = {}
    end
end

function apm.bob_rework.lib.utils.tech.insertSciencePack(tech, pack)
    -- if tech and tech.unit and tech.unit.ingredients then
    --     for _, v in ipairs(tech.unit.ingredients) do
    --         if v.name == pack then
    --             return
    --         end
    --     end
    --     table.insert(tech.unit.ingredients, {pack, 1})
    -- end
    if tech then
        local tName = tech.name
        apm.lib.utils.technology.add.science_pack(tName, pack)
    end
end

function apm.bob_rework.lib.utils.tech.addDependency(tName, dep, depMap)
    if not apm.lib.utils.technology.exist(tName) or not apm.lib.utils.technology.exist(dep) then
        return
    end

    if not depMap[tName] then
        depMap[tName] = {}
    end 
    depMap[tName][dep] = {}

    -- apm.lib.utils.technology.add.prerequisites(tName, dep)
end

function apm.bob_rework.lib.utils.tech.products(tech)
    local products ={}
    if tech and tech.effects then
        for _, v in pairs(tech.effects) do
            local eType = v.type
            if eType == unlockRecipeTag then
                local list = apm.bob_rework.lib.utils.recipe.getProducts(v.recipe)
                for _, p in ipairs(list) do
                    products[p] = {}
                end
            end
        end
    end
    if tech.name == 'fluid-handling' or tech.name == 'gas-canisters' then
        apm.bob_rework.lib.utils.tech.fluidHandleHack(products)

    end

    return products
end

function apm.bob_rework.lib.utils.tech.fluidHandleHack(products)
    for k, _ in pairs(products) do
        local itm = data.raw.fluid[k]
        if itm and itm.type == 'fluid' then
            products[k] = nil
        end
    end
end

function apm.bob_rework.lib.utils.tech.requiredProducts(tech, availableProducts)
    local products = {}
    local techProducts = {}
    if tech and tech.effects then
        for _, v in pairs(tech.effects) do
            local eType = v.type
            if eType == unlockRecipeTag then
                local ingredients = apm.bob_rework.lib.utils.recipe.getIngredients(v.recipe)
                -- apm.bob_rework.lib.utils.debug.object('requiredProducts:: for .. ' .. v.recipe)
                -- apm.bob_rework.lib.utils.debug.object(ingredients)
                for _, ingredient in ipairs(ingredients) do
                    local state = false
                    if availableProducts[ingredient] then
                        state = true
                    end
                    products[ingredient] = {enabled = state}
                end
                local list = apm.bob_rework.lib.utils.recipe.getProducts(v.recipe)
                for _, p in ipairs(list) do
                    techProducts[p] = {}
                end
            end
        end
        -- remove from requirements current tech products
        for k, _ in pairs(techProducts) do
            products[k] = nil
        end
    end
    if tech.name == 'fluid-handling' or tech.name == 'gas-canister' then
        apm.bob_rework.lib.utils.tech.fluidHandleHack(products)
    end
    if tech.name == 'nuclear-fuel-reprocessing' then
        products['apm_fuel_rod_uranium_active'] = nil
        products['apm_fuel_rod_mox_active'] = nil
    end
    if tech.name == 'gun-turret' then
        products[apm.bob_rework.lib.entities.chem.lubricant] = {}
    end

    return products
end

function apm.bob_rework.lib.utils.tech.toogleItems(tech, availableProducts)
    if tech and tech.effects then
        for _, v in pairs(tech.effects) do
            local eType = v.type
            if eType == unlockRecipeTag then
                local list = apm.bob_rework.lib.utils.recipe.getProducts(v.recipe)
                for _, v in ipairs(list) do
                    availableProducts[v] = {tech = tech.name}
                    -- apm.bob_rework.lib.utils.debug.object('toogleItems for ' .. tech.name .. ' product -> ' .. v)
                end
            end
        end
    end
end

function apm.bob_rework.lib.utils.tech.tryAddExtraProducts(tName, availableProducts)
    local hardcoded = {}
    hardcoded['apm_power_steam'] = {steam = {}}
    hardcoded['pumpjack'] = {}
    hardcoded['pumpjack']['crude-oil'] = {}
    hardcoded['pumpjack']['lithia-water'] = {}
    hardcoded['military-science-pack'] = {}
    hardcoded['military-science-pack']['gun-turret'] = {}
    hardcoded['bob-nuclear-power-3'] = {}
    hardcoded['bob-nuclear-power-3']['used-up-deuterium-fuel-cell'] = {}
    hardcoded['apm_nuclear_neptunium_fuel'] = {}
    hardcoded['apm_nuclear_neptunium_fuel']['apm_fuel_rod_neptunium_active'] = {}
    hardcoded['apm_nuclear_thorium_fuel'] = {}
    hardcoded['apm_nuclear_thorium_fuel']['apm_fuel_rod_thorium_active'] = {}

    if hardcoded[tName] then
        for product, _ in pairs(hardcoded[tName]) do
            availableProducts[product] = { by = tName}
        end
    end
end

function apm.bob_rework.lib.utils.tech.special()
    local list = {
        ["long-inserters-1"] = {},
        ["long-inserters-2"] = {},
        ["near-inserters"] = {},
        ["more-inserters-1"] = {},
        ["more-inserters-2"] = {},
        ["module-merging"] = {},
    }
    return list
end

function apm.bob_rework.lib.utils.tech.isMilitary(tName)

    return false
end

function apm.bob_rework.lib.utils.tech.startingList(tName)
    local list = {
        ["iron-plate"] = { } ,
        ["copper-plate"] = { },
        ["copper-cable"] = { } ,
        ["iron-gear-wheel"] = { } ,
        ["wooden-chest"] = { } ,
        ["iron-chest"] = { } ,
        ["linked-chest"] = { } ,
        ["linked-belt"] = { } ,
        ["apm_dummy"] = { } ,
        ["apm_hidden_fuel"] = { } ,
        ["gem-ore"] = { } ,
        ["ruby-ore"] = { } ,
        ["sapphire-ore"] = { } ,
        ["emerald-ore"] = { } ,
        ["amethyst-ore"] = { } ,
        ["topaz-ore"] = { } ,
        ["diamond-ore"] = { } ,
        ["tin-ore"] = { } ,
        ["lead-ore"] = { } ,
        ["quartz"] = { } ,
        ["zinc-ore"] = { } ,
        ["gold-ore"] = { } ,
        ["bauxite-ore"] = { } ,
        ["rutile-ore"] = { } ,
        ["tungsten-ore"] = { } ,
        ["thorium-ore"] = { } ,
        ["nickel-ore"] = { } ,
        ["cobalt-ore"] = { } ,
        ["ruby-3"] = { } ,
        ["sapphire-3"] = { } ,
        ["emerald-3"] = { } ,
        ["amethyst-3"] = { } ,
        ["topaz-3"] = { } ,
        ["diamond-3"] = { } ,
        ["glass"] = { } ,
        ["void"] = { } ,
        ["tin-plate"] = { } ,
        ["bronze-alloy"] = { } ,
        ["stone-mixing-furnace"] = { } ,
        ["wooden-board"] = { } ,
        -- ["bronze-pipe"] = { } ,
        ["apm_assembling_machine_0"] = { } ,
        ["apm_lab_0"] = { } ,
        ["apm_gearing"] = { } ,
        ["apm_mechanical_relay"] = { } ,
        ["apm_pistions"] = { } ,
        ["apm_simple_engine"] = { } ,
        ["apm_machine_frame_basic"] = { } ,
        ["apm_machine_frame_basic_used"] = { } ,
        ["apm_machine_frame_steam"] = { } ,
        ["apm_machine_frame_steam_used"] = { } ,
        ["apm_machine_frame_advanced"] = { } ,
        ["apm_machine_frame_advanced_used"] = { } ,
        ["bronze-gear-wheel"] = { } ,
        ["wood"] = { } ,
        ["stone"] = { } ,
        ["coal"] = { } ,
        ["sulfur"] = { } ,
        ["bronze-bearing"] = { } ,
        ["burner-mining-drill"] = {},
        ["burner-inserter"] = {},
        ["apm_burner_filter_inserter"] = {},
        ["lead-plate"] = {},
        ["silver-plate"] = {},
        ["firearm-magazine"] = {},
        ["apm_sea_water"] = {} ,
        ["apm_dirt_water"] = {},
        ["apm_discharged_battery"] = {},
        ["apm_discharged_lithium-ion-battery"] = {},
        ["apm_discharged_silver-zinc-battery"] = {},
        ["apm_shielded_nuclear_fuel_cell_used"] = {},
        ["apm_fuel_rod_thorium_active"] = {},
        ["apm_fuel_rod_neptunium_active"] = {},
        ["apm_breeder_uranium_active"] = {},
        ["apm_breeder_thorium_active"] = {},
        ["apm_breeder_container_worn"] = {},
        ["iron-ore"] = {},
        ["copper-ore"] = {},
    }

    if tName then
        for key, _ in pairs(list) do
            list[key] = {by = tName}
        end
    end

    return list
end