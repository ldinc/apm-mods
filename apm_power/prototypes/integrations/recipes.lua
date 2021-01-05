require ('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/integrations/recipes.lua'

APM_LOG_HEADER(self)

local iron = 'iron-plate'
local lead = 'lead-plate'
local steel = 'steel-plate'
local tin = 'tin-plate'
local copper = 'copper-plate'
local alum = 'aluminium-plate'
local tungsten = 'tungsten-plate'
local copperTungsten = 'copper-tungsten-alloy'
local invar = 'invar-alloy'
local titanium = 'titanium-plate'
local cobaltSteel = 'cobalt-steel-alloy'
local heavy = 'nitinol-alloy'
local ironG = 'iron-gear-wheel'
local steelG = 'steel-gear-wheel'
local titaniumG = 'titanium-gear-wheel'
local heavyG = 'nitinol-gear-wheel'
local cobaltSteelG = 'cobalt-steel-gear-wheel'
local ironB = 'apm_iron_bearing'
local steelB = 'steel-bearing'
local titaniumB = 'titanium-bearing'
local heavyB = 'nitinol-bearing'
local cobaltSteelB = 'cobalt-steel-bearing'
--
local logicMech = 'apm_mechanical_relay'
local logicSteam = 'apm_steam_relay'
local logic = 'basic-circuit-board'
local logic1 = 'electronic-circuit'
local logic2 = 'advanced-circuit'
local logic3 = 'processing-unit'
local logic4 = 'advanced-processing-unit'
--
local basicFr, steamFr, advFr = 'apm_machine_frame_basic', 'apm_machine_frame_steam', 'apm_machine_frame_advanced'
-- 
local steelPipe = 'steel-pipe'
local heavyPipe = 'nitinol-pipe'
local titaniumPipe = 'titanium-pipe'
local ceramicPipe = 'ceramic-pipe'
local copperPipe = 'copper-pipe'
local copperTungstenPipe = 'copper-tungsten-pipe'
--
local brick, concrete, refConcrete = 'stone-brick', 'concrete', 'refined-concrete'
local eEngine = 'electric-engine'
local eGenerator = 'apm_egen_unit'
local eMagnet = 'apm_electromagnet'

function vanilaFinalUpdatesRecipe()
	log('DBG::: vanilaFinalUpdatesRecipe')
	-- more early electric engine technology
	apm.lib.utils.technology.remove.science_pack(eEngine ,'chemical-science-pack')
	apm.lib.utils.technology.add.prerequisites(eEngine, 'apm_power_electricicty')
	updateVanilaTechnology()
	-- used frames
	local used = apm.lib.utils.setting.get.starup('apm_power_machine_frames_recycling')
	if not used then
		dropFrameMaintenance()
	end
	-- update concrete
	updateConcrete()
	-- integrate electric generators
	useEGenUnits()
	-- setup startingresources
	apm.lib.utils.resource.on_starting_zone('sulfur', true)
	if not apm.lib.utils.resource.exist('sulfur') then
		-- change recipe for gun powder 
		apm.lib.utils.recipe.ingredient.mod('apm_gun_powder', 'sulfur', 0)
	end
	local recipe = 'piercing-rounds-magazine'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'firearm-magazine', 0)
	recipe = 'piercing-shotgun-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'shotgun-shell', 0)
end

function  dropFrameMaintenance()
	apm.lib.utils.recipe.remove('apm_machine_frame_basic_maintenance')
	apm.lib.utils.recipe.remove('apm_machine_frame_steam_maintenance')
	apm.lib.utils.recipe.remove('apm_machine_frame_advanced_maintenance')
end

function useEGenUnits()
	-- assuming one eGenerator ~ 400 kW
	local recipe = 'steam-engine'
	apm.lib.utils.recipe.ingredient.mod(recipe, eGenerator, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, eMagnet, 0)
	recipe = 'apm_steam_engine_2'
	apm.lib.utils.recipe.ingredient.mod(recipe, eGenerator, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, eMagnet, 0)

end

function genInsertersName(name)

	if name == 'yellow' or name == '' then 
		return 'inserter', 'yellow-filter-inserter', '', ''
	end
	if name == 'red' or name == 'fast' then
		return 'long-handed-inserter', 'red-filter-inserter', 'red-stack-inserter', 'red-filter-inserter'
	end
	if name == 'express' then
		return 'fast-inserter', 'filter-inserter', 'stack-inserter', 'stack-filter-inserter'
	end
	if name == 'ultimate' then
		name = 'express'
	end
	if name ~= '' then
		name = name .. '-'
	end

	return name .. 'inserter', name ..  'filter-inserter', name .. 'stack-inserter', name .. 'stack-filter-inserter'
end

local insBase, insFilter, insStack, insFilterStack = genInsertersName('')
local inserterTier1 = {base=insBase, filter=insFilter, stack=insStack, stackFilter=insFilterStack}
insBase, insFilter, insStack, insFilterStack = genInsertersName('fast')
local inserterTier2 = {base=insBase, filter=insFilter, stack=insStack, stackFilter=insFilterStack}
insBase, insFilter, insStack, insFilterStack = genInsertersName('express')
local inserterTier3 = {base=insBase, filter=insFilter, stack=insStack, stackFilter=insFilterStack}
insBase, insFilter, insStack, insFilterStack = genInsertersName('turbo')
local inserterTier4 = {base=insBase, filter=insFilter, stack=insStack, stackFilter=insFilterStack}
insBase, insFilter, insStack, insFilterStack = genInsertersName('ultimate')
local inserterTier5 = {base=insBase, filter=insFilter, stack=insStack, stackFilter=insFilterStack}
local inserterTiers = {inserterTier1, inserterTier2, inserterTier3, inserterTier4, inserterTier5}


function deepcopy(obj, seen)
	if type(obj) ~= 'table' then return obj end
	if seen and seen[obj] then return seen[obj] end
	local s = seen or {}
	local res = setmetatable({}, getmetatable(obj))
	s[obj] = res
	for k, v in pairs(obj) do res[deepcopy(k, s)] = deepcopy(v, s) end
	return res
  end

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ',\n'
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end

function addEquipmentGrid(eType, eName, equipmentGrid)
	if data.raw[eType] and data.raw[eType][eName] then
		log(eType)
		log(eName)
		log(dump( data.raw[eType][eName].equipment_grid))
        data.raw[eType][eName].equipment_grid = equipmentGrid
    end
end

function updateVanilaTechnology() 
	local recipe = 'electric-engine'
	apm.lib.utils.technology.remove.prerequisites(recipe, 'lubricant')
	apm.lib.utils.technology.add.prerequisites(recipe, 'apm_power_automation_science_pack')
	apm.lib.utils.technology.remove.science_pack(recipe, 'logistic-science-pack')
end

function makeGrid(attributes)
    local name = attributes.name .. "-grid-apm"
    
    data:extend({
            {
                type = "equipment-grid",
                name = name,
                width = attributes.width or 5,
                height = attributes.height or 5,
                equipment_categories = attributes.categories or {"armor"}
            }
    })

	return name
end

function genBelts(name)
	if name ~= '' then
		name = name .. '-'
	end
	-- vanila loader mod compability
	local loader = name .. 'loader'
	if name == 'turbo' then 
		loader = 'purple-loader'
	end
	if name == 'ultimate' then 
		loader = 'green-loader'
	end
	return name .. 'transport-belt', name .. 'underground-belt', name .. 'splitter', loader
end

function genGearingBearing(alloy)
	if alloy == 'iron' then 
		return 'iron-gear-wheel', 'apm_iron_bearing'
	end
	return alloy .. '-gear-wheel', alloy .. '-bearing'
end

function genBeltsRecipes(name, alloy, logic, sub) 
	local belt, under, splitter, loader = genBelts(name)
	local gearing, bearing = genGearingBearing(sub)
	
	-- belt
	apm.lib.utils.recipe.ingredient.remove_all(belt)
	apm.lib.utils.recipe.ingredient.mod(belt, bearing, 2)
	apm.lib.utils.recipe.ingredient.mod(belt, gearing, 2)
	apm.lib.utils.recipe.ingredient.mod(belt, alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(belt, 'apm_rubber', 1)
	-- under
	apm.lib.utils.recipe.ingredient.remove_all(under)
	apm.lib.utils.recipe.ingredient.mod(under, belt, 5)
	apm.lib.utils.recipe.ingredient.mod(under, alloy, 4)
	-- splitter
	apm.lib.utils.recipe.ingredient.remove_all(splitter)
	apm.lib.utils.recipe.ingredient.mod(splitter, belt, 2)
	apm.lib.utils.recipe.ingredient.mod(splitter, gearing, 2)
	apm.lib.utils.recipe.ingredient.mod(splitter, bearing, 2)
	apm.lib.utils.recipe.ingredient.mod(splitter, alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(splitter, logic, 5)
	-- loader (if vanila mod enabled)
	if name == 'turbo' then loader = 'purple-loader' end
	if name == 'ultimate' then loader = 'green-loader' end
	apm.lib.utils.recipe.ingredient.remove_all(loader)
	apm.lib.utils.recipe.ingredient.mod(loader, belt, 5)
	apm.lib.utils.recipe.ingredient.mod(loader, alloy, 5)
	apm.lib.utils.recipe.ingredient.mod(loader, gearing, 8)
	apm.lib.utils.recipe.ingredient.mod(loader, logic, 5)
end

function genInserterts(name, alloy, logic, sub, tier)
	local ins, fins, sins, sfins = genInsertersName(name)
	local gearing, bearing = genGearingBearing(sub)

	local recipe = ins
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-engine-unit', tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, gearing, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, bearing, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic, 1) 

	recipe = fins
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, ins, 1)		
	apm.lib.utils.recipe.ingredient.mod(recipe, gearing, 1)

	if sins ~= '' then 
		recipe = sins
		apm.lib.utils.recipe.ingredient.remove_all(recipe)
		apm.lib.utils.recipe.ingredient.mod(recipe, ins, 1)
		apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, gearing, 1)
		apm.lib.utils.recipe.ingredient.mod(recipe, bearing, 1)
	end
	if sfins ~= '' then 
		recipe = fsins
		apm.lib.utils.recipe.ingredient.remove_all(recipe)
		apm.lib.utils.recipe.ingredient.mod(recipe, fins, 1)
		apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, gearing, 1)
		apm.lib.utils.recipe.ingredient.mod(recipe, bearing, 1)
	end
end

function genStorageTank(recipe, alloy, pipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'stone-brick', tier*10)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 20)

	local wCorners = 'bob-storage-tank-all-corners-' .. tostring(tier)
	if tier == 1 then 
		wCorners = 'bob-storage-tank-all-corners'
	end
	apm.lib.utils.recipe.ingredient.remove_all(wCorners)
	apm.lib.utils.recipe.ingredient.mod(wCorners, recipe, 1)
	apm.lib.utils.recipe.ingredient.mod(wCorners, pipe, 20)
end

function genElectricPole(tier, alloy, wire, logic)
	local recipe = 'medium-electric-pole'
	if tier > 1 then
		recipe = recipe .. '-' .. tostring(tier)
	end
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'steel-plate', 2 * tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, wire, 2)
	local recipe = 'big-electric-pole'
	if tier > 1 then
		recipe = recipe .. '-' .. tostring(tier)
	end
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'steel-plate', 5 * tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, wire, 5)
	local recipe = 'substation'
	if tier > 1 then
		recipe = recipe .. '-' .. tostring(tier)
	end
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'steel-plate', 5 * tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, wire, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic, 5)
end

function genPump(tier, alloy, pipe, logic) 
	local recipe = 'bob-pump-' .. tostring(tier)
	if tier == 1 then 
		recipe = 'pump'
	end
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_rubber', 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-engine-unit', tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic, 2)
end

function updateConcrete()
	local recipe = 'concrete'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'water', 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'stone-brick', 5)
	local recipe = 'refined-concrete'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-stick', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'steel-plate', 2)
end

function nuclearReactor()
	local recipe = 'nuclear-reactor'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-plate', 500)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'concrete', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'refined-concrete', 300)
	--
	recipe = 'nuclear-reactor-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'refined-concrete', 500)

	recipe = 'nuclear-reactor-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'refined-concrete', 500)
	
	recipe = 'apm_nuclear_breeder'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'refined-concrete', 500)
end

function locomotiveBuff(recipe,tier, armoured, w,h)
	local locomotive = data.raw.locomotive[recipe]
	if locomotive then
		local list = {"noInventory", "train", "locomotive", "vehicle", "movement", "adv-generator", 'train', 'cargo-wagon'}
		if armoured > 0 then
			list = {"noInventory", "train", "locomotive", "vehicle", "movement", "adv-generator", 'train', 'cargo-wagon', 'armoured-vehicle', 'armoured-train', }
		end
		local grid = makeGrid({
			name = recipe,
			width = w,
			height = h,
			categories = list
		})
		locomotive.max_health = tier * (1000 + armoured * 500)
		addEquipmentGrid(recipe, recipe, grid)
		locomotive.equipment_grid = grid
	end
end

function cargoWagonBuff(recipe, tier, armoured, w,h)
	local wagon = data.raw["cargo-wagon"][recipe]
	if wagon then
		wagon.max_health = tier * (1000 + 500*armoured)
		local list = {'train', 'vehicle', 'cargo-wagon'}
		if armoured then 
			list = {'train', 'vehicle', 'cargo-wagon', 'armoured-vehicle', 'armoured-train', 'armoured-cargo-wagon'}
		end
		local grid = makeGrid({
			name = recipe,
			width = w,
			height = h,
			categories = list
		})
		addEquipmentGrid(recipe, recipe, grid)
		wagon.equipment_grid = grid
	end
end

function artilleryWagonBuff(recipe, tier, armoured, w,h)
	local wagon = data.raw["artillery-wagon"][recipe]
	if wagon then
		wagon.max_health = tier * (1000 + 500*armoured)
		local list = {'train', 'vehicle', 'cargo-wagon'}
		if armoured then 
			list = {'train', 'vehicle', 'cargo-wagon', 'armoured-vehicle', 'armoured-train', 'armoured-cargo-wagon'}
		end
		local grid = makeGrid({
			name = recipe,
			width = w,
			height = h,
			categories = list
		})
		addEquipmentGrid(recipe, recipe, grid)
		wagon.equipment_grid = grid
	end
end


function fluidWagonBuff(recipe, tier, armoured, w,h)
	local wagon = data.raw["fluid-wagon"][recipe]
	if wagon then
		wagon.max_health = tier * (1000 + 500*armoured)
		local list = {'train', 'vehicle', 'cargo-wagon'}
		if armoured then 
			list = {'train', 'vehicle', 'cargo-wagon', 'armoured-vehicle', 'armoured-train', 'armoured-cargo-wagon'}
		end
		local grid = makeGrid({
			name = recipe,
			width = w,
			height = h,
			categories = list
		})
		addEquipmentGrid(recipe, recipe, grid)
		wagon.equipment_grid = grid
	end
end

function enableSteamCoolant()
	if apm.nuclear then
		local recipe = 'apm_hybrid_cooling_tower_0'
		apm.lib.utils.recipe.ingredient.remove_all(recipe)
		apm.lib.utils.recipe.ingredient.mod(recipe, 'steel-plate', 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, 'copper-pipe', 10)
		apm.lib.utils.recipe.ingredient.mod(recipe, 'electronic-circuit', 10)
		apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_machine_frame_advanced', 3)
		apm.lib.utils.recipe.ingredient.mod(recipe, 'pump', 1)
		local tech = 'apm_steelworks-1'
		if apm.lib.utils.technology.exist(tech) then
			apm.lib.utils.technology.add.recipe_for_unlock(tech, recipe)
			recipe = 'steam_condensing'
			apm.lib.utils.technology.add.recipe_for_unlock(tech, recipe)
		end
	end
end

function fixBurnerGeneratorBob()
	local name = 'bob-burner-generator'
	local generator = data.raw['burner-generator'][name]
	local fc = apm.lib.utils.entity.get.fuel_categories('apm_steelworks_0')
	generator.burner.fuel_category = 'apm_refined_chemical'
	generator.burner.fuel_categories = fc
	-- boilers
	genBoilers('boiler', 1, 'steel-plate', 'pipe')
	genBoilers('boiler-2', 2, 'steel-plate', 'steel-pipe')
	genBoilers('boiler-3', 3, 'titanium-plate', 'titanium-pipe')
	genBoilers('boiler-4', 4, tungsten, 'tungsten-pipe')
	genBoilers('boiler-5', 5, copperTungsten, copperTungstenPipe)
	-- steam generators
	genSteamEGen('steam-engine', 1, 'steel-plate', 'pipe', 'basic-circuit-board')
	genSteamEGen('steam-engine-2', 2, 'steel-plate', 'steel-pipe', 'electronic-circuit')
	genSteamEGen('steam-engine-3', 3, 'titanium-plate', 'titanium-pipe', 'advanced-circuit')
	genSteamEGen('steam-engine-4', 4, 'tungsten-plate', 'tungsten-pipe', 'processing-unit')
	genSteamEGen('steam-engine-5', 5, 'copper-tungsten-alloy', 'copper-tungsten-pipe', 'advanced-processing-unit')
	-- fluid generators
	genFluidEGen('fluid-generator', 1, 'steel-plate', 'steel-pipe', 'basic-circuit-board', 'steel-gearing', 'steel-bearing')
	genFluidEGen('fluid-generator-2', 2, 'titanium-plate', 'titanium-pipe', 'electronic-circuit', 'cobalt-steel-gearing', 'cobalt-steel-bearing')
	genFluidEGen('fluid-generator-3', 3, 'tungsten-plate', 'tungsten-pipe', 'processing-unit', 'titanium-gearing', 'titanium-bearing')
	-- remove dissasembling
	apm.lib.utils.recipe.remove('boiler-2-from-oil-boiler')
	apm.lib.utils.recipe.remove('boiler-3-from-heat-exchanger')
	apm.lib.utils.recipe.remove('boiler-3-from-oil-boiler-2')
	apm.lib.utils.recipe.remove('boiler-4-from-heat-exchanger-2')
	apm.lib.utils.recipe.remove('boiler-4-from-oil-boiler-3')
	apm.lib.utils.recipe.remove('boiler-5-from-heat-exchanger-3')
	apm.lib.utils.recipe.remove('boiler-5-from-oil-boiler-4')
	-- fluid boilers
	genBoilers('oil-boiler', 1, 'steel-plate', 'steel-plate')
	genBoilers('oil-boiler-2', 2, 'titanium-plate', 'titanium-pipe')
	genBoilers('oil-boiler-3', 3, 'tungsten-plate', 'tungsten-pipe')
	genBoilers('oil-boiler-4', 4, copperTungsten, copperTungstenPipe)
	apm.lib.utils.recipe.remove('oil-boiler-2-from-boiler-3')
	apm.lib.utils.recipe.remove('oil-boiler-3-from-boiler-4')
	apm.lib.utils.recipe.remove('oil-boiler-4-from-boiler-5')
	genHydrazineEGen()
end

function genHydrazineEGen()
	local recipe = 'hydrazine-generator'
	local alloy, pipe, logic = 'nitinol-alloy', 'nitinol-pipe', 'advanced-processing-unit'
	local gearing, bearing = 'nitinol-gear-wheel', 'nitinol-bearing' 
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_machine_frame_advanced', 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_egen_unit', 6 * 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, gearing, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, bearing, 10)	
end

function genFluidEGen(recipe, tier, alloy, pipe, logic, gearing, bearing)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_machine_frame_advanced', 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_egen_unit', 6 * tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, gearing, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, bearing, 10)
end

function genSteamEGen(recipe, tier, alloy, pipe, logic)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_machine_frame_steam', 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_steam_engine', 2*tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_egen_unit', 4 *tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic, 2)
end

function genBoilers(recipe, tier, alloy, pipe)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'stone-furnace', 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 15)
end

function genFluidBoilers(recipe, tier, alloy, pipe)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'stone-furnace', 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 5)
end

function updateGenerators()
	local recipe = 'bob-burner-generator'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_egen_unit', 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_machine_frame_basic', 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'stone-furnace', 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'copper-cable', 6)
end

function fixSolarPanels()
	genSolarI('solar-panel-small', 1)
	genSolarI('solar-panel',2)
	genSolarI('solar-panel-large',3)
	genSolarII('solar-panel-small-2', 1)
	genSolarII('solar-panel-2',2)
	genSolarII('solar-panel-large-2',3)
	genSolarIII('solar-panel-small-3', 1)
	genSolarIII('solar-panel-3',2)
	genSolarIII('solar-panel-large-3',3)
end

function genSolarI(recipe, size)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'glass', size)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'steel-plate', 2*size)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'copper-plate', 2*size)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electronic-circuit', 2*size)
end


function genSolarII(recipe, size)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'glass', 4*size)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'aluminium-plate', 2*size)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'silver-plate', 2*size)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'advanced-circuit', 2*size)
end

function genSolarIII(recipe, size)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'silicon-wafer', 20*size)
	apm.lib.utils.recipe.ingredient.mod(recipe, titanium, 2*size)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'gold-plate', 2*size)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'processing-unit', 2*size)
end

function genAccum()
	genAccumI('accumulator', 1)
	genAccumI('fast-accumulator', 2)
	genAccumI('slow-accumulator', 2)
	genAccumI('large-accumulator', 3)
	genAccumII('fast-accumulator-2', 2)
	genAccumII('slow-accumulator-2', 2)
	genAccumII('large-accumulator-2', 3)
	genAccumIII('fast-accumulator-3', 2)
	genAccumIII('slow-accumulator-3', 2)
	genAccumIII('large-accumulator-3', 3)
end

function genAccumI(recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, iron, 2)
	local battery = 5
	if tier == 3 then
		battery = 10
		apm.lib.utils.recipe.ingredient.mod(recipe, iron, 3)
	end
	if tier == 2 then
		battery = 4 
		apm.lib.utils.recipe.ingredient.mod(recipe, 'electronic-circuit', 2)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, 'battery', battery)
end

function genAccumII(recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'aluminium-plate', 2)
	local battery = 5
	if tier == 3 then
		battery = 10
		apm.lib.utils.recipe.ingredient.mod(recipe, 'aluminium-plate', 3)
	end
	if tier == 2 then
		battery = 4 
		apm.lib.utils.recipe.ingredient.mod(recipe, 'electronic-circuit', 2)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, 'lithium-ion-battery', battery)
end

function genAccumIII(recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'titanium-plate', 2)
	local battery = 5
	if tier == 3 then
		battery = 10
		apm.lib.utils.recipe.ingredient.mod(recipe, 'titanium-plate', 3)
	end
	if tier == 2 then
		battery = 4 
		apm.lib.utils.recipe.ingredient.mod(recipe, 'processig-unit', 2)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, 'silver-zinc-battery', battery)
end

function genGreenhouses()
	local recipe = 'apm_greenhouse_0'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'glass', 20)
	recipe = 'apm_greenhouse_1'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'glass', 30)
	recipe = 'apm_greenhouse_2'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'glass', 35)
end

local ironTier = {alloy=iron, gearing=ironG, bearing=ironB, logic='basic-circuit-board', frame=basicFr, pipe='pipe', pump='apm_pump_0'}
local steelTier = {alloy=steel, gearing=steelG, bearing=steelB, logic=logic1, frame=basicFr, pipe='steel-pipe', pump='pump'}
local cobaltSteelTier = {alloy=cobaltSteel, gearing=cobaltSteelG, bearing=cobaltSteelB, logic=logic2, frame=advFr, pipe='plastic-pipe', pump='bob-pump-2'}
local titaniumTier = {alloy=titanium, gearing=titaniumG, bearing=titaniumB, logic=logic3, frame=advFr, pipe='titanium-pipe', pump='bob-pump-3'}
local heavyTier = {alloy=heavy, gearing=heavyG, bearing=heavyB, logic=logic4, frame=advFr, pipe=heavyPipe, pump='bob-pump-4'}

local techTiers = {ironTier,steelTier,cobaltSteel,titaniumTier,heavyTier}

function genMiners()
	genMiner('electric-mining-drill', 1, ironTier, false)
	genMiner('bob-mining-drill-1', 2, steelTier, false)
	genMiner('bob-area-mining-drill-1', 2, steelTier, true)
	genMiner('bob-mining-drill-2', 3, cobaltSteelTier, false)
	genMiner('bob-area-mining-drill-2', 3, cobaltSteelTier, true)
	genMiner('bob-mining-drill-3', 4, titaniumTier, false)
	genMiner('bob-area-mining-drill-3', 4, titaniumTier, true)
	genMiner('bob-mining-drill-4', 5, heavyTier, false)
	genMiner('bob-area-mining-drill-4', 5, heavyTier, true)
end

function  genMiner(recipe, tier, tech, isLarge)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-engine-unit', 2*tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.frame, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 5)
	if isLarge then 
		apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 10)
		apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 10)
	end
end

function genPumpjacks()
	genPumpjack('pumpjack', 1, ironTier)
	local tier = deepcopy(steelTier)
	tier.pipe = 'plastic-pipe'
	genPumpjack('bob-pumpjack-1', 2, tier)
	tier = deepcopy(steelTier)
	tier.logic = cobaltSteelTier.logic
	tier.frame = cobaltSteelTier.frame
	tier.pipe = steelTier.pipe
	genPumpjack('bob-pumpjack-2', 3, tier)
	genPumpjack('bob-pumpjack-3', 4, titaniumTier)
	genPumpjack('bob-pumpjack-4', 5, heavyTier)
end

function genPumpjack(recipe, tier, tech)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 2)
	local pump = tech.pump
	if tier == 3 then pump = 'bob-pump-2' end
	apm.lib.utils.recipe.ingredient.mod(recipe, pump, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.frame, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pipe, 60)
end

function genWaterjacks()
	genWaterjack(1, ironTier)
	local tier = deepcopy(steelTier)
	tier.pipe = 'plastic-pipe'
	genWaterjack(2, tier)
	tier = deepcopy(steelTier)
	tier.logic = cobaltSteelTier.logic
	tier.frame = cobaltSteelTier.frame
	tier.pipe = steelTier.pipe
	genWaterjack(3, tier)
	genWaterjack(4, titaniumTier)
	genWaterjack(5, heavyTier)
end

function genWaterjack(tier, tech)
	local recipe = 'water-miner-' .. tostring(tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 2)
	local pump = tech.pump
	if tier == 3 then pump = 'bob-pump-2' end
	apm.lib.utils.recipe.ingredient.mod(recipe, pump, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.frame, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pipe, 40)
end

function genAirPumps()
	local tech = deepcopy(ironTier)
	tech.pump = steelTier.pump
	tech.logic = steelTier.logic
	genAirPump(1, tech)
	tech = deepcopy(steelTier)
	tech.pump = cobaltSteelTier.pump
	tech.logic = cobaltSteelTier.logic
	genAirPump(2, tech)
	genAirPump(3, titaniumTier)
	genAirPump(4, heavyTier)
end

function genAirPump(tier, tech)
	local recipe = 'air-pump-' .. tostring(tier)
	if tier == 1 then
		recipe = 'air-pump'
	end
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pump, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pipe, 10)
end

function genWaterPumps()
	local tech = deepcopy(ironTier)
	tech.pump = steelTier.pump
	tech.logic = steelTier.logic
	genWaterPump(1, tech)
	tech = deepcopy(steelTier)
	tech.logic = cobaltSteelTier.logic
	tech.pump = cobaltSteelTier.pump
	genWaterPump(2, tech)
	genWaterPump(3, titaniumTier)
	genWaterPump(4, heavyTier)
end

function genWaterPump(tier, tech)
	local recipe = 'water-pump-' .. tostring(tier)
	if tier == 1 then
		recipe = 'water-pump'
	end
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pump, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pipe, 15)
end

function genVoidPump()
	local recipe = 'void-pump'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	local tech = steelTier
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pump, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pipe, 15)
end

function genFurnaces()
	local recipe = 'fluid-furnace'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, brick, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, steel, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelPipe, 5)
	recipe = 'electric-furnace-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-furnace', 0)
	recipe = 'electric-furnace-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-furnace-2', 0)
	--
	apm.lib.utils.recipe.remove('stone-furnace-from-stone-chemical-furnace')
	apm.lib.utils.recipe.remove('stone-furnace-from-stone-mixing-furnace')
	apm.lib.utils.recipe.remove('steel-furnace-from-fluid-furnace')
	apm.lib.utils.recipe.remove('steel-furnace-from-steel-chemical-furnace')
	apm.lib.utils.recipe.remove('steel-furnace-from-steel-mixing-furnace')
	apm.lib.utils.recipe.remove('fluid-furnace-from-fluid-chemical-furnace')
	apm.lib.utils.recipe.remove('fluid-furnace-from-fluid-mixing-furnace')
	apm.lib.utils.recipe.remove('electric-furnace-from-electric-mixing-furnace')
	apm.lib.utils.recipe.remove('electric-furnace-from-electric-chemical-furnace')
	apm.lib.utils.recipe.remove('stone-chemical-furnace-from-stone-furnace')
	apm.lib.utils.recipe.remove('steel-chemical-furnace-from-fluid-chemical-furnace')
	apm.lib.utils.recipe.remove('steel-chemical-furnace-from-steel-furnace')
	apm.lib.utils.recipe.remove('fluid-chemical-furnace-from-fluid-furnace')
	apm.lib.utils.recipe.remove('stone-mixing-furnace-from-stone-furnace')
	apm.lib.utils.recipe.remove('steel-mixing-furnace-from-fluid-mixing-furnace')
	apm.lib.utils.recipe.remove('steel-mixing-furnace-from-steel-furnace')
	apm.lib.utils.recipe.remove('fluid-mixing-furnace-from-fluid-furnace')
	apm.lib.utils.recipe.remove('fluid-mixing-furnace-from-steel-furnace')
	apm.lib.utils.recipe.remove('electric-chemical-furnace-from-electric-furnace')
	apm.lib.utils.recipe.remove('electric-mixing-furnace-from-electric-furnace')
	--
	local recipe = 'fluid-chemical-furnace'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, brick, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, steel, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelPipe, 10)
	local recipe = 'fluid-mixing-furnace'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, brick, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, steel, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelPipe, 10)
	local recipe = 'electric-chemical-mixing-furnace'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-chemical-furnace', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, refConcrete, 10)
	local recipe = 'electric-chemical-mixing-furnace-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-chemical-mixing-furnace', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, refConcrete, 15)
end

function genDistilators()
	genDistilator(1, ironTier)
	genDistilator(2, steelTier)
	genDistilator(3, cobaltSteelTier)
	genDistilator(4, titaniumTier)
	genDistilator(5, heavyTier)
end

function genDistilator(tier, tech)
	local recipe = 'bob-distillery'
	if tier > 1 then
		recipe = recipe .. '-' .. tostring(tier)		
	end
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, advFr, 2)
	if tier < 4 then
		apm.lib.utils.recipe.ingredient.mod(recipe, brick, 10)
		apm.lib.utils.recipe.ingredient.mod(recipe, copperPipe, 10)
	else
		apm.lib.utils.recipe.ingredient.mod(recipe, refConcrete, 10)
		apm.lib.utils.recipe.ingredient.mod(recipe, copperTungstenPipe, 10)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 10)
end

function genNuclearCent()
	local recipe = 'centrifuge'
	apm.lib.utils.recipe.ingredient.mod(recipe, ironG, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, cobaltSteelG, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, cobaltSteelB, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, invar, 100)
	local recipe = 'centrifuge-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'centrifuge', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, refConcrete, 125)
	recipe = 'centrifuge-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'centrifuge-2', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, refConcrete, 150)
end

function genSteamTurbineWithExhangers()
	local recipe = 'apm_hexafluoride_sample'
	apm.lib.utils.recipe.ingredient.mod(recipe, lead, 10)
	recipe = 'heat-exchanger'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'boiler-3', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'heat-pipe', 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, titanium, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, titaniumPipe, 20)
	recipe = 'heat-exchanger-2'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'boiler-4', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'heat-pipe-2', 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tungsten, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, ceramicPipe, 20)
	recipe = 'heat-exchanger-3'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'boiler-5', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'heat-pipe-3', 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, copperTungsten, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, copperTungstenPipe, 20)
	--
	genSteamTurbine(1, cobaltSteelTier, alum)
	genSteamTurbine(2, titaniumTier, 'silicon-nitride')
	genSteamTurbine(3, heavyTier, 'tungsten-carbide')
end

function genSteamTurbine(tier, tech, alloy)
	local recipe = 'steam-turbine'
	if tier > 1 then recipe = recipe .. '-' .. tostring(tier) end
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_egen_unit', 10+4*tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 12)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 20)
	if tier == 1 then
		apm.lib.utils.recipe.ingredient.mod(recipe, steelPipe, 20)
	else
		apm.lib.utils.recipe.ingredient.mod(recipe, tech.pipe, 20)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 25)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 10)
end

function genAssemblers()
	for tier=1,6 do genAssembler(tier) end
	for tier=1,3 do genEAssembler(tier) end
end

function genAssembler(tier)
	local recipe = 'assembling-machine-' .. tostring(tier)
	local prev = 'assembling-machine-' .. tostring(tier - 1)
	local tech = 1
	if tier > 1 then
		apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
		tech = tier - 1
	end
	if tier == 1 then 
		apm.lib.utils.recipe.ingredient.mod(recipe, iron, 5)
	end
	if tier == 2 then
		apm.lib.utils.recipe.ingredient.remove_all(recipe)
		apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, steelG, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, advFr, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, advFr, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, steel, 5)
	end
	if tier == 3 then
		apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 5)
	end
	if tier == 4 then
		apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 0)
		apm.lib.utils.recipe.ingredient.mod(recipe, 'brass-gear-wheel', 0)
		apm.lib.utils.recipe.ingredient.mod(recipe, cobaltSteelB, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, cobaltSteelG, 5)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-engine-unit', 1 + tier*2)
	apm.lib.utils.recipe.ingredient.mod(recipe, inserterTiers[tech].base, 2)
end

function genEAssembler(tier)
	local recipe = 'electronics-machine-' .. tostring(tier)
	local prev = 'electronics-machine-' .. tostring(tier - 1)
	local tech = 1
	if tier == 1 then 
		apm.lib.utils.recipe.ingredient.mod(recipe, ironB, 2)
		apm.lib.utils.recipe.ingredient.mod(recipe, iron, 5)
	end
	if tier == 2 then
		apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 3)
		apm.lib.utils.recipe.ingredient.mod(recipe, steel, 5)
	end
	if tier == 3 then
		apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 5)
	end
	if tier == 4 then
		apm.lib.utils.recipe.ingredient.mod(recipe, 'brass-gear-wheel', 0)
		apm.lib.utils.recipe.ingredient.mod(recipe, cobaltSteelG, 5)
		apm.lib.utils.recipe.ingredient.mod(recipe, cobaltSteelB, 5)
	end
	if tier > 1 then
		apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
		tech = 2*tier - 1
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, inserterTiers[tech].base, 2)
end

function genChemicalPlants()
	local recipe, prev = 'chemical-plant-2', 'chemical-plant'
	apm.lib.utils.recipe.ingredient.mod(prev, 'pump', 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'bob-pump-2', 2)
	prev = recipe
	recipe = 'chemical-plant-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'bob-pump-3', 2)
	prev = recipe
	recipe = 'chemical-plant-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'bob-pump-4', 2)
end

function genElectrolysers()
	local recipe, prev = 'electrolyser-2', 'electrolyser'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'electrolyser-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'electrolyser-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'electrolyser-5'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, advFr, 12)
end

function nuclearTrain()
	local recipe = 'nuclear-train-vehicle-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic4, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-plate', 300)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'nuclear-reactor', 1)	
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-engine-unit', 60)	
	apm.lib.utils.recipe.ingredient.mod(recipe, titanium, 100)	

	local locomotive = data.raw.locomotive['nuclear-train-vehicle-rampant-arsenal']
	if locomotive then
		locomotive.burner.fuel_category = ''
		locomotive.burner.fuel_categories = {'apm_nuclear_uranium', 'apm_nuclear_mox', 'apm_nuclear_neptunium', 'apm_nuclear_thorium'}
		locomotive.max_speed = 1.5
		locomotive.max_power = '5.67MW'
	end

	--
	local generator = data.raw['generator-equipment']['nuclear-generator-rampant-arsenal']
	if generator then
		generator.burner.fuel_category = ''
		generator.burner.fuel_categories = {'apm_nuclear_uranium', 'apm_nuclear_mox', 'apm_nuclear_neptunium', 'apm_nuclear_thorium'}
	end
end

function genTrainsAndWagons()
	locomotiveBuff('locomotive', 1, 0, 8,6)
	locomotiveBuff('bob-locomotive-2', 2, 0, 10,6)
	locomotiveBuff('bob-locomotive-3', 3, 0, 12,6)
	locomotiveBuff('bob-armoured-locomotive', 2, 1, 14,8)
	locomotiveBuff('bob-armoured-locomotive-2', 3, 1, 16,8)	
	locomotiveBuff('nuclear-train-vehicle-rampant-arsenal', 4, 3, 20, 20)

	cargoWagonBuff('cargo-wagon', 1, 0, 8, 6)
	cargoWagonBuff('bob-cargo-wagon-2', 2, 0, 10, 6)
	cargoWagonBuff('bob-cargo-wagon-3', 3, 0, 12, 6)
	cargoWagonBuff('bob-armoured-cargo-wagon', 1, 1, 14, 8)
	cargoWagonBuff('bob-armoured-cargo-wagon-2', 2, 1, 16, 8)
	cargoWagonBuff('bob-armoured-cargo-wagon-3', 3, 1, 18, 8)

	fluidWagonBuff('fluid-wagon', 1, 0, 8, 6)
	fluidWagonBuff('bob-fluid-wagon-2', 2, 0, 10, 6)
	fluidWagonBuff('bob-fluid-wagon-3', 3, 0, 12, 6)
	fluidWagonBuff('bob-armoured-fluid-wagon', 1, 1, 14, 8)
	fluidWagonBuff('bob-armoured-fluid-wagon-2', 2, 1, 16, 8)
	fluidWagonBuff('bob-armoured-fluid-wagon-3', 3, 1, 18, 8)

	artilleryWagonBuff('artillery-wagon', 1, 1, 12, 8)
	artilleryWagonBuff('bob-artillery-wagon-2', 2, 1, 14, 8)
	artilleryWagonBuff('bob-artillery-wagon-3', 3, 1, 16, 8)
	
	genTrain('locomotive', 1, false, ironTier, steel, false, 'apm_steam_engine', 'apm_steam_relay')
	genTrain('bob-locomotive-2', 2, false, steelTier, invar, false, 'apm_steam_engine', nil)
	genTrain('bob-locomotive-3', 3, false, titaniumTier, 'silicon-nitride', false, 'apm_steam_engine', nil)
	genTrain('bob-armoured-locomotive', 1, true, titaniumTier, titanium, false, 'apm_steam_engine', nil)
	genTrain('bob-armoured-locomotive-2', 2, true, titaniumTier, heavy, false, 'apm_steam_engine', nil)

	genCargo('cargo-wagon', 1, false, ironTier, steel)
	genCargo('bob-cargo-wagon-2', 2, false, steelTier, invar)
	genCargo('bob-cargo-wagon-3', 3, false, titaniumTier, cobaltSteel)
	genCargo('bob-armoured-cargo-wagon', 2, true, steelTier, titanium)
	genCargo('bob-armoured-cargo-wagon-2', 3, true, titaniumTier, heavy)
	-- genCargo('bob-armoured-cargo-wagon-3', 4, true, titaniumTier, tungsten)

	genFluidCargo('fluid-wagon', 1, nil, ironTier)
	genFluidCargo('bob-fluid-wagon-2', 2, nil, steelTier)
	genFluidCargo('bob-fluid-wagon-3', 3, nil, titaniumTier)
	genFluidCargo('bob-armoured-fluid-wagon', 1, titanium, steelTier)
	genFluidCargo('bob-armoured-fluid-wagon-2', 2, heavy, titaniumTier)
	-- genFluidCargo('bob-armoured-fluid-wagon-3', 3, cobaltSteel, titaniumTier)

	genArtilleryWagon('artillery-wagon', 1, iron, steelTier)
	genArtilleryWagon('bob-artillery-wagon-2', 2, invar, titaniumTier)
	genArtilleryWagon('bob-artillery-wagon-3', 3, tungsten, heavyTier)
end

function genArtilleryWagon(recipe, tier, armor, tech)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, armor, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'engine-unit', tier*20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 12)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 20)
end

function genFluidCargo(recipe, tier, armor, tech)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 12)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pipe, 24)
	local tank = 'storage-tank'
	if tier > 1 then tank = 'storage-tank-' .. tostring(tier) end
	apm.lib.utils.recipe.ingredient.mod(recipe, tank, 1)
	if armor then
		apm.lib.utils.recipe.ingredient.mod(recipe, armor, 20)
	end
end

function genCargo(recipe, tier, armoured, tech, extraAlloy)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 30)
	local count = 20
	if armoured then count = 40 end
	if extraAlloy then apm.lib.utils.recipe.ingredient.mod(recipe, extraAlloy, count) end
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 12)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 8)
end

function genTrain(recipe, tier, armoured, tech, extraAlloy, useBaseAlloy, engine, logic)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, engine, tier * 20)
	if useBaseAlloy then 
		apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 20)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, extraAlloy, tier * 20)
	if armoured then
		apm.lib.utils.recipe.ingredient.mod(recipe, extraAlloy, tier * 40)
	end
	if logic then
		apm.lib.utils.recipe.ingredient.mod(recipe, logic, 20)
	else
		apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 20)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 16)
end

function genRoboports()
	local prev, recipe = 'roboport', 'bob-roboport-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-roboport-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-roboport-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	--
	prev, recipe = 'bob-logistic-zone-expander', 'bob-logistic-zone-expander-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-logistic-zone-expander-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-logistic-zone-expander-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	--
	prev, recipe = 'bob-robochest', 'bob-robochest-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robochest-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robochest-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	--
	prev, recipe = 'bob-robo-charge-port', 'bob-robo-charge-port-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robo-charge-port-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robo-charge-port-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	--
	prev, recipe = 'bob-robo-charge-port-large', 'bob-robo-charge-port-large-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robo-charge-port-large-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robo-charge-port-large-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
end

function genOilRefineries()
	genOilRefinery('oil-refinery', 1, steelTier, brick, nil)
	genOilRefinery('oil-refinery-2', 2, cobaltSteelTier, concrete, invar)
	genOilRefinery('oil-refinery-3', 3, titaniumTier, concrete, 'silicon-nitride')
	genOilRefinery('oil-refinery-4', 4, heavyTier, refConcrete, 'copper-tungsten-alloy')
end

local pumps = {'pump', 'bob-pump-2', 'bob-pump-3','bob-pump-4'}

function modPump() 
	local recipe = 'apm_offshore_pump_1'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-pipe', 3)
	recipe = 'apm_egen_unit'
	apm.lib.utils.recipe.ingredient.mod(recipe, logic, 1)
	recipe = 'apm_ammonium_sulfate_chem'
	apm.lib.utils.recipe.category.change(recipe, 'chemical-furnace')
end

function genOilRefinery(recipe, tier, tech, walls, mat)
	local pump = pumps[tier]
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, advFr, 6+tier*2)
	apm.lib.utils.recipe.ingredient.mod(recipe, pump, 2+tier)
	if mat then apm.lib.utils.recipe.ingredient.mod(recipe, mat, 10) end
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.pipe, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, walls, 8+tier*2)
end

function genWeapons()
	local recipe = 'piercing-rounds-magazine'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, copper, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, lead, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)
	local recipe = 'firearm-magazine'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, lead, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)
	if mods.bobrevamp then
		local recipe = 'apm_ammonium_sulfate_chem'
		apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_coal_saturated_wastewater', 0)
		apm.lib.utils.recipe.ingredient.mod(recipe, 'ammonia', 15)
	end
	apm.lib.utils.recipe.remove('bio-magazine-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('he-magazine-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('incendiary-magazine-ammo-rampant-arsenal')
	local recipe = 'shotgun-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, copper, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)
	local recipe = 'piercing-shotgun-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, copper, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, lead, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)
	apm.lib.utils.recipe.remove('bio-shotgun-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('he-shotgun-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('incendiary-shotgun-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('uranium-shotgun-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('bio-rocket-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('he-rocket-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('incendiary-rocket-ammo-rampant-arsenal')
	apm.lib.utils.recipe.remove('rocket')
	apm.lib.utils.recipe.remove('explosive-rocket')
	apm.lib.utils.recipe.remove('bob-electric-rocket')
	apm.lib.utils.recipe.remove('electric-bullet-magazine')
	apm.lib.utils.recipe.remove('electric-bullet')
	apm.lib.utils.recipe.remove('electric-bullet-projectile')
	apm.lib.utils.recipe.remove('plasma-bullet')
	apm.lib.utils.recipe.remove('plasma-bullet-projectile')
	apm.lib.utils.recipe.remove('plasma-rocket-warhead')
	apm.lib.utils.recipe.remove('electric-rocket-warhead')
	apm.lib.utils.recipe.remove('shotgun-electric-shell')
	apm.lib.utils.recipe.remove('plasma-bullet-magazine')
	apm.lib.utils.recipe.remove('plasma-rocket')
	apm.lib.utils.recipe.remove('shotgun-plasma-shell')
	apm.lib.utils.recipe.remove('bob-plasma-turret')
	apm.lib.utils.recipe.remove('bob-plasma-turret-1')
	apm.lib.utils.recipe.remove('bob-plasma-turret-2')
	apm.lib.utils.recipe.remove('bob-plasma-turret-3')
	apm.lib.utils.recipe.remove('bob-plasma-turret-4')
	apm.lib.utils.recipe.remove('bob-plasma-turret-5')
	apm.lib.utils.recipe.remove('distractor-artillery-shell')
	apm.lib.utils.recipe.remove('fire-artillery-shell')
	apm.lib.utils.recipe.remove('poison-artillery-shell')
	apm.lib.utils.recipe.remove('explosive-artillery-shell')
	apm.lib.utils.recipe.remove('atomic-artillery-shell')
	-- disable tech
	apm.lib.utils.technology.delete('bob-fire-artillery-shells')
	apm.lib.utils.technology.delete('bob-posion-artillery-shells')
	apm.lib.utils.technology.delete('bob-explosive-artillery-shells')
	apm.lib.utils.technology.delete('bob-distractor-artillery-shells')
	apm.lib.utils.technology.delete('bob-plasma-bullets')
	apm.lib.utils.technology.delete('bob-plasma-rocket')
	apm.lib.utils.technology.delete('bob-electric-bullets')
	apm.lib.utils.technology.delete('bob-electric-rocket')
	apm.lib.utils.technology.delete('bob-shotgun-electric-shells')
	apm.lib.utils.technology.delete('bob-shotgun-plasma-shells')
	apm.lib.utils.technology.delete('bob-shotgun-plasma-shells')
	apm.lib.utils.technology.delete('bob-plasma-turrets-1')
	--
	recipe = 'artillery-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, steel, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tungsten, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'cordite', 50)
	recipe = 'cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'cordite', 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 0)
	recipe = 'explosive-cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'cordite', 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 1)
	--
	apm.lib.utils.recipe.remove('mk3-generator-rampant-arsenal')
	apm.lib.utils.recipe.remove('mk3-shield-rampant-arsenal')
	apm.lib.utils.recipe.remove('mending-wall-rampant-arsenal')
	apm.lib.utils.recipe.remove('mending-gate-rampant-arsenal')
	apm.lib.utils.recipe.remove('reinforced-wall')
	apm.lib.utils.recipe.remove('reinforced-gate')
	apm.lib.utils.recipe.remove('medic-item-rampant-arsenal')
	apm.lib.utils.recipe.remove('lightning-item-rampant-arsenal')
	apm.lib.utils.recipe.remove('advanced-beam-item-rampant-arsenal')
	--
	recipe = 'nuclear-generator-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'fusion-reactor-equipment-2', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'nuclear-reactor', 1)
	--
	genGunTurrets()
	apm.lib.utils.recipe.remove('gun-item-rampant-arsenal')
	recipe = 'shotgun-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, ironB, 10)
	recipe = 'cannon-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, titaniumB, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, titaniumG, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, steel, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, refConcrete, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'engine-unit', 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic3, 20)
	recipe = 'rapid-cannon-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, titaniumB, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, titaniumG, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, steel, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, refConcrete, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'engine-unit', 40)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic3, 40)
	recipe = 'rocket-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, steel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelG, 20)
	-- apm.lib.utils.recipe.ingredient.mod(recipe, 'engine-unit', 40)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic2, 15)
	recipe = 'rapid-rocket-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, steel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelG, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'engine-unit', 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic2, 30)
	--
	genLasers()
	--
	recipe = 'advanced-laser-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, heavy, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-engine-unit', 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic4, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'diamond-5', 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'large-accumulator-3', 20)
	--
	genSniperTurrets()
	recipe = 'suppression-cannon-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelG, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic2, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic3, 30)
	recipe = 'capsule-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, steelG, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 0)
	--
	genArtilleries()
	--
	genRadars()
end

function genRadars()
	genRadar('radar', 1, ironTier)
	genRadar('radar-2', 2, steelTier)
	genRadar('radar-3', 3, cobaltSteelTier)
	genRadar('radar-4', 4, titaniumTier)
	genRadar('radar-5', 5, heavyTier)
end

function genRadar(recipe, tier, tech)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 5)
end

function genArtilleries()
	genArtillery('artillery-turret', 1, steelTier, cobaltSteel)
	genArtillery('bob-artillery-turret-2', 2, titaniumTier, 'silicone-nitride')
	genArtillery('bob-artillery-turret-3', 3, heavyTier, 'tungsten-carbide')
end

function genArtillery(recipe, tier, tech)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 60)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.logic, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, refConcrete, 50*tier)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'engine-unit', 20 + 20*tier)

end

function genSniperTurrets()
	genGunTurret('bob-sniper-turret-1', 1, ironTier)
	genGunTurret('bob-sniper-turret-2', 2, cobaltSteelTier)
	genGunTurret('bob-sniper-turret-3', 3, titaniumTier)
end

function genLasers()
	local recipe = 'laser-turret'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'ruby-5', 1)
	local prev = recipe
	recipe = 'bob-laser-turret-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'battery', 12)
	prev = recipe
	recipe = 'bob-laser-turret-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-laser-turret-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-laser-turret-5'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)

end

function genGunTurrets()
	genGunTurret('gun-turret', 1, ironTier)
	genGunTurret('bob-gun-turret-2', 2, steelTier)
	genGunTurret('bob-gun-turret-3', 3, cobaltSteelTier)
	genGunTurret('bob-gun-turret-4', 4, titaniumTier)
	genGunTurret('bob-gun-turret-5', 5, heavyTier)
end

function genGunTurret(recipe, tier, tech)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.alloy, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.gearing, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tech.bearing, 10)
end

local apm_power_overhaul_machine_frames = settings.startup["apm_power_overhaul_machine_frames"].value
local apm_power_steam_assembler_craftin_with_fluids = settings.startup["apm_power_steam_assembler_craftin_with_fluids"].value
local apm_power_compat_bob = settings.startup["apm_power_compat_bob"].value
local apm_power_compat_bob_overhaul_machine_frames = settings.startup["apm_power_compat_bob_overhaul_machine_frames"].value
local apm_power_compat_angel = settings.startup["apm_power_compat_angel"].value
local apm_power_compat_angel_overhaul_machine_frames = settings.startup["apm_power_compat_angel_overhaul_machine_frames"].value
local apm_power_compat_angel_overwrite_crystal_saw_blades = settings.startup["apm_power_compat_angel_overwrite_crystal_saw_blades"].value
local apm_power_compat_sctm = settings.startup["apm_power_compat_sctm"].value
local apm_power_compat_sct_overhaul_machine_frames = settings.startup["apm_power_compat_sct_overhaul_machine_frames"].value
local apm_power_compat_earendel = settings.startup["apm_power_compat_earendel"].value
local apm_power_compat_bio_industries = settings.startup["apm_power_compat_bio_industries"].value
local apm_power_compat_expensivelandfillrecipe = settings.startup["apm_power_compat_expensivelandfillrecipe"].value
local apm_power_compat_kingarthur = settings.startup["apm_power_compat_kingarthur"].value
local apm_power_compat_mferrari = settings.startup["apm_power_compat_mferrari"].value
local apm_power_compat_linver = settings.startup["apm_power_compat_linver"].value
local apm_power_compat_realistic_reactors = settings.startup["apm_power_compat_realistic_reactors"].value
local apm_power_compat_reverse_factory = settings.startup["apm_power_compat_reverse_factory"].value
local apm_power_compat_arcitos = settings.startup["apm_power_compat_arcitos"].value
local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value

APM_LOG_SETTINGS(self, 'apm_power_overhaul_machine_frames', apm_power_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_steam_assembler_craftin_with_fluids', apm_power_steam_assembler_craftin_with_fluids)
APM_LOG_SETTINGS(self, 'apm_power_compat_bob', apm_power_compat_bob)
APM_LOG_SETTINGS(self, 'apm_power_compat_bob_overhaul_machine_frames', apm_power_compat_bob_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel', apm_power_compat_angel)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel_overhaul_machine_frames', apm_power_compat_angel_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel_overwrite_crystal_saw_blades', apm_power_compat_angel_overwrite_crystal_saw_blades)
APM_LOG_SETTINGS(self, 'apm_power_compat_sctm', apm_power_compat_sctm)
APM_LOG_SETTINGS(self, 'apm_power_compat_sct_overhaul_machine_frames', apm_power_compat_sct_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_earendel', apm_power_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_power_compat_bio_industries', apm_power_compat_bio_industries)
APM_LOG_SETTINGS(self, 'apm_power_compat_expensivelandfillrecipe', apm_power_compat_expensivelandfillrecipe)
APM_LOG_SETTINGS(self, 'apm_power_compat_kingarthur', apm_power_compat_kingarthur)
APM_LOG_SETTINGS(self, 'apm_power_compat_mferrari', apm_power_compat_mferrari)
APM_LOG_SETTINGS(self, 'apm_power_compat_linver', apm_power_compat_linver)
APM_LOG_SETTINGS(self, 'apm_power_compat_realistic_reactors', apm_power_compat_realistic_reactors)
APM_LOG_SETTINGS(self, 'apm_power_compat_reverse_factory', apm_power_compat_reverse_factory)
APM_LOG_SETTINGS(self, 'apm_power_compat_arcitos', apm_power_compat_arcitos)
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

vanilaFinalUpdatesRecipe()

if mods.apm_recycling then
	apm.lib.utils.assembler.burner.overhaul('apm_recycling_machine_0')
	apm.lib.utils.recipe.ingredient.mod('apm_recycling_machine_0', 'iron-plate', 0)
	apm.lib.utils.recipe.ingredient.mod('apm_recycling_machine_0', 'copper-plate', 0)

	apm.power.machine_frame_addition('apm_recycling_machine_0', 1, nil, 3, nil, true)
	apm.power.machine_frame_addition('apm_recycling_machine_1', 3, 1, 5, 3, true)
	apm.power.machine_frame_addition('apm_recycling_machine_2', 3, 3, 7, 4, true)
	apm.power.machine_frame_addition('apm_recycling_machine_3', 3, 3, 9, 5, true)
end

if mods.apm_energy_addon then
	apm.lib.utils.recipe.ingredient.mod('apm_battery_charging_station', 'steel-plate', 0)
	apm.power.machine_frame_addition('apm_battery_charging_station', 3, 3, 6, 3, true)
end

if mods.apm_nuclear then
	apm.lib.utils.recipe.ingredient.mod('apm_cooling_pond_0', 'steel-plate', 0)
	apm.power.machine_frame_addition('apm_cooling_pond_0', 3, nil, 6, nil, true)
	apm.lib.utils.recipe.ingredient.mod('apm_hybrid_cooling_tower_0', 'steel-plate', 0)
	apm.power.machine_frame_addition('apm_hybrid_cooling_tower_0', 3, nil, 6, nil, true)	
end

-- AsphaltRoads ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['AsphaltRoads'] and apm_power_compat_arcitos then
	apm.lib.utils.recipe.ingredient.remove_all('Arci-asphalt')
	apm.lib.utils.recipe.ingredient.mod('Arci-asphalt', 'apm_asphalt', 5)
	apm.lib.utils.recipe.ingredient.mod('Arci-asphalt', 'steam', 50)
	apm.lib.utils.recipe.category.change('Arci-asphalt', 'chemistry')
end

-- ExpensiveLandFillRecipe ----------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.ExpensiveLandfillRecipe and apm_power_compat_expensivelandfillrecipe then
	apm.lib.utils.recipe.ingredient.mod('apm_landfill', 'stone', 0)
	apm.lib.utils.recipe.ingredient.mod('apm_landfill', 'gravel-pile', 150)
	apm.lib.utils.recipe.energy_required.mod('apm_landfill', 10)
	apm.lib.utils.recipe.result.mod('apm_landfill', 'landfill', 1)
	if settings.startup['apm_power_generic_ash'].value == true then
		apm.lib.utils.recipe.ingredient.mod('apm_landfill', 'apm_generic_ash', 1500)
	else
		apm.lib.utils.recipe.ingredient.mod('apm_landfill', 'apm_generic_ash', 1500)
	end
end

-- linver ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.FluidMustFlow and apm_power_compat_linver then
	apm.lib.utils.recipe.ingredient.mod('duct-small', 'apm_sealing_rings', 2, 4)
	apm.lib.utils.recipe.ingredient.mod('duct-t-junction', 'apm_sealing_rings', 3, 6)
	apm.lib.utils.recipe.ingredient.mod('duct-curve', 'apm_sealing_rings', 2, 4)
	apm.lib.utils.recipe.ingredient.mod('duct-cross', 'apm_sealing_rings', 4, 8)
	apm.lib.utils.recipe.ingredient.mod('duct-underground', 'apm_sealing_rings', 2, 4)
end

-- bio_industries -------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.Bio_Industries and apm_power_compat_bio_industries then
	apm.lib.utils.recipe.remove('bi_recipe_stone_crusher')
	apm.lib.utils.recipe.remove('bi_recipe_charcoal')
	apm.lib.utils.recipe.remove('bi_recipe_charcoal_2')
	apm.lib.utils.recipe.remove('bi_recipe_ash_1')
	apm.lib.utils.recipe.remove('bi_recipe_ash_2')
	apm.lib.utils.recipe.remove('bi_recipe_stone_brick')
	apm.lib.utils.recipe.remove('bi_recipe_cokery')
	apm.lib.utils.recipe.remove('bi_recipe_coal')
	apm.lib.utils.recipe.remove('bi_recipe_coke_coal')
	apm.lib.utils.recipe.remove('bi_recipe_coal_2')
	apm.lib.utils.recipe.remove('bi_recipe_resin_wood')
	apm.lib.utils.recipe.remove('bi_recipe_crushed_stone')
	apm.lib.utils.recipe.remove('bi_recipe_soild_fuel')
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_rail_wood', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_rail_wood_bridge', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_wood_pipe', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_wood_pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_big_wooden_pole', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_huge_wooden_pole', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.result.mod('bi_recipe_seed_1', 'bi-seed', 40/5)
	apm.lib.utils.recipe.result.mod('bi_recipe_seed_2', 'bi-seed', 50/5)
	apm.lib.utils.recipe.result.mod('bi_recipe_seed_3', 'bi-seed', 60/5)
	apm.lib.utils.recipe.result.mod('bi_recipe_seed_4', 'bi-seed', 80/5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seedling_mk1', 'bi-seed', 20/5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seedling_mk2', 'bi-seed', 20/5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seedling_mk3', 'bi-seed', 20/5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seedling_mk4', 'bi-seed', 20/5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seed_bomb_basic', 'bi-seed', 400/5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seed_bomb_standard', 'bi-seed', 400/5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seed_bomb_advanced', 'bi-seed', 400/5)
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_plastic_1', 'wood', 'apm_wood_pellets', 2)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_wood_fuel_brick', 'bi-woodpulp', 7)
	apm.lib.utils.recipe.result.mod('bi_recipe_wood_fuel_brick', 'apm_wood_briquette', 1)
	apm.lib.utils.recipe.result.mod('bi_recipe_wood_fuel_brick', 'wood-bricks', 0)
	apm.lib.utils.recipe.category.change('bi_recipe_wood_fuel_brick', 'apm_press')
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_rail_wood', 'apm_crushed_stone', 0)
	apm.lib.utils.recipe.ingredient.mod('rail', 'apm_crushed_stone', 0)
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_mineralized_sulfuric_waste', 'wood-charcoal', 'apm_charcoal')
end

-- Earendel -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['aai-industry'] and apm_power_compat_earendel then
	-- revert some changes from aai-industry
	apm.lib.utils.recipe.ingredient.replace('medium-electric-pole', 'small-iron-electric-pole', 'small-electric-pole')
	apm.lib.utils.recipe.remove('small-iron-electric-pole')
	apm.lib.utils.recipe.ingredient.replace('assembling-machine-1', 'burner-assembling-machine', 'apm_assembling_machine_1')
    if apm.lib.utils.setting.get.starup('apm_power_overhaul_machine_frames') then
    	apm.lib.utils.recipe.result.mod('assembling-machine-1', 'apm_machine_frame_steam_used', 3)
    end
	apm.lib.utils.recipe.remove('burner-assembling-machine')
	apm.lib.utils.recipe.ingredient.replace('lab', 'burner-lab', 'apm_lab_1')
	apm.lib.utils.recipe.remove('burner-lab')
	apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'burner-mining-drill', 0)
	apm.lib.utils.recipe.ingredient.mod('inserter', 'iron-plate', 1)
	apm.lib.utils.recipe.ingredient.mod('inserter', 'apm_gearing', 1)
	apm.lib.utils.recipe.remove('electronic-circuit-stone')

	apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', 'motor', 0)
	apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', 'stone-brick', 0)
	apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', 'stone-furnace', 1)

	if not mods.bobelectronics then
		apm.lib.utils.recipe.ingredient.mod('inserter', 'electronic-circuit', 1)
		apm.lib.utils.recipe.ingredient.mod('apm_offshore_pump_1', 'electronic-circuit', 5)
	else
		apm.lib.utils.recipe.ingredient.mod('inserter', 'basic-circuit-board', 1)
		apm.lib.utils.recipe.ingredient.mod('apm_offshore_pump_1', 'basic-circuit-board', 5)
	end

	-- integrate motors
	apm.lib.utils.recipe.ingredient.mod('burner-inserter', 'motor', 0)
	apm.lib.utils.recipe.ingredient.replace('steam-engine', 'electric-motor', 'iron-gear-wheel')
	apm.lib.utils.recipe.ingredient.replace('steam-turbine', 'electric-motor', 'iron-gear-wheel')

	if mods.boblogistics and apm.lib.utils.setting.get.starup('bobmods-logistics-beltoverhaul') then
		apm.lib.utils.recipe.ingredient.replace('basic-transport-belt', 'motor', 'iron-gear-wheel', 2)
	else
		apm.lib.utils.recipe.ingredient.replace('transport-belt', 'motor', 'iron-gear-wheel', 2)
		apm.lib.utils.recipe.ingredient.replace('underground-belt', 'motor', 'iron-gear-wheel')
		apm.lib.utils.recipe.ingredient.replace('splitter', 'motor', 'iron-gear-wheel')
	end
	apm.lib.utils.recipe.ingredient.mod('engine-unit', 'motor', 0)

	if not mods.bobelectronics then
		--apm.lib.utils.recipe.ingredient.replace('electronic-circuit', 'wood', 'apm_wood_board')
		apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'electronic-circuit', 3)
		apm.lib.utils.recipe.ingredient.mod('electronic-circuit', 'stone-tablet', 1)
	else
		apm.lib.utils.recipe.ingredient.mod('apm_offshore_pump_1', 'basic-circuit-board', 0)
		apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'basic-circuit-board', 3)
		apm.lib.utils.recipe.ingredient.mod('basic-circuit-board', 'stone-tablet', 1)
	end
end

if mods['aai-vehicles-hauler'] and apm_power_compat_earendel then
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'motor', 0)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'iron-gear-wheel', 0)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'iron-plate', 5, 10)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'apm_simple_engine', 2, 3)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'steel-plate', 3, 6)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'apm_rubber', 4)
end

if mods['aai-vehicles-warden'] and apm_power_compat_earendel then
	apm.lib.utils.recipe.ingredient.mod('vehicle-warden', 'apm_rubber', 6)
end

if mods['aai-vehicles-chaingunner'] and apm_power_compat_earendel then
	apm.lib.utils.recipe.ingredient.mod('vehicle-chaingunner', 'motor', 0)
	apm.lib.utils.recipe.ingredient.mod('vehicle-chaingunner', 'iron-gear-wheel', 0)
	apm.lib.utils.recipe.ingredient.mod('vehicle-chaingunner', 'apm_simple_engine', 3, 6)
	apm.lib.utils.recipe.ingredient.mod('vehicle-chaingunner', 'steel-plate', 5, 10)
end

if mods['aai-vehicles-warden'] and apm_power_compat_earendel then
end

if mods['aai-vehicles-warden'] and apm_power_compat_earendel then
end

if (mods['space-exploration'] or mods['aai-industry']) and apm_power_compat_earendel then
	-- integrate stone from sand
	apm.lib.utils.recipe.ingredient.mod('sand-from-stone', 'apm_crushed_stone', 4)
	apm.lib.utils.recipe.ingredient.mod('sand-from-stone', 'stone', 0)
	apm.lib.utils.recipe.category.change('sand-from-stone', 'apm_crusher')
	-- integrate glass
	apm.lib.utils.recipe.ingredient.mod('apm_greenhouse_0', 'glass', 25)
	apm.lib.utils.recipe.ingredient.mod('apm_greenhouse_1', 'glass', 25)
	apm.lib.utils.recipe.ingredient.mod('apm_greenhouse_2', 'glass', 25)
	apm.lib.utils.recipe.ingredient.mod('apm_lab_1', 'glass', 10)
end

if mods['space-exploration'] and apm_power_compat_earendel then
	apm.lib.utils.recipe.ingredient.mod('se-space-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.replace('se-lifesupport-canister-coal', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('se-meteor-point-defence-ammo', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('se-nutrient-gel', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('se-observation-frame-blank', 'coal', 'apm_coal_briquette', 1)
	apm.lib.utils.recipe.ingredient.replace('se-bio-sludge-from-wood', 'wood', 'apm_wood_pellets', 2)
	apm.lib.utils.recipe.ingredient.replace('se-lifesupport-canister-fish', 'wood', 'apm_wood_pellets', 1)
end

-- bob ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobpower and apm_power_compat_bob then
	if apm.lib.utils.setting.get.starup('bobmods-power-steam') then
		apm.lib.utils.recipe.remove('apm_boiler_2')
		apm.lib.utils.recipe.remove('apm_steam_engine_2')
	end
	apm.lib.utils.recipe.ingredient.mod('steam-engine-2', 'apm_electromagnet', 6, 10)
	apm.lib.utils.recipe.ingredient.mod('steam-engine-3', 'apm_electromagnet', 6, 10)
	apm.lib.utils.recipe.ingredient.mod('steam-engine-4', 'apm_electromagnet', 6, 10)
	apm.lib.utils.recipe.ingredient.mod('steam-engine-5', 'apm_electromagnet', 6, 10)
	apm.lib.utils.recipe.ingredient.mod('steam-turbine-2', 'apm_electromagnet', 12, 18)
	apm.lib.utils.recipe.ingredient.mod('steam-turbine-3', 'apm_electromagnet', 12, 18)
	apm.lib.utils.recipe.ingredient.mod('fluid-generator', 'apm_electromagnet', 12, 18)
	apm.lib.utils.recipe.ingredient.mod('fluid-generator-2', 'apm_electromagnet', 12, 18)
	apm.lib.utils.recipe.ingredient.mod('fluid-generator-3', 'apm_electromagnet', 12, 18)
	apm.lib.utils.recipe.ingredient.mod('hydrazine-generator', 'apm_electromagnet', 12, 18)
end

if mods.boblogistics and apm_power_compat_bob then
	if apm.lib.utils.setting.get.starup('bobmods-logistics-inserteroverhaul') then
		-- if mods.bobores and mods.bobplates then
		-- 	genInserterts('',  'bronze-alloy', 'basic-circuit-board', 'iron', 1) -- inserter
		-- 	genInserterts('fast', 'brass-alloy', 'electronic-circuit', 'steel', 1) -- fast
		-- 	genInserterts('express', 'aluminium-plate', 'advanced-circuit', 'cobalt-steel', 2)
		-- 	genInserterts('turbo', 'titanium-plate', 'processing-unit', 'titanium', 3)
		-- 	genInserterts('ultimate', 'nitinol-alloy', 'advanced-processing-unit', 'nitinol', 4)
		-- 	apm.lib.utils.recipe.ingredient.mod('burner-inserter', tin, 2)			
		-- end

		apm.lib.utils.recipe.ingredient.mod('filter-inserter', 'iron-plate', 0)
		apm.lib.utils.recipe.ingredient.mod('filter-inserter', 'apm_gearing', 0)
		apm.lib.utils.recipe.ingredient.mod('yellow-filter-inserter', 'iron-plate', 1)
		apm.lib.utils.recipe.ingredient.mod('yellow-filter-inserter', 'apm_gearing', 1)
		apm.lib.utils.recipe.ingredient.mod('fast-inserter', 'apm_gearing', 0)
		if mods.bobores and mods.bobplates then
			apm.lib.utils.recipe.ingredient.replace('inserter', 'iron-plate', 'tin-plate')
			apm.lib.utils.recipe.ingredient.replace('yellow-filter-inserter', 'iron-plate', 'tin-plate')
		end
	else
		if mods.bobores and mods.bobplates then
			apm.lib.utils.recipe.ingredient.replace('inserter', 'iron-plate', 'tin-plate')
			apm.lib.utils.recipe.ingredient.replace('filter-inserter', 'iron-plate', 'tin-plate')
		end
	end
	apm.lib.utils.recipe.ingredient.mod('copper-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('steel-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('stone-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('plastic-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('bronze-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('brass-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('ceramic-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('titanium-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('tungsten-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('nitinol-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.mod('copper-tungsten-pipe', 'apm_sealing_rings', 1)

	apm.lib.utils.recipe.category.change('steel-bearing', 'crafting-with-fluid')
	apm.lib.utils.recipe.category.change('cobalt-steel-bearing', 'crafting-with-fluid')
	apm.lib.utils.recipe.ingredient.mod('steel-bearing', 'lubricant', 10)
	apm.lib.utils.recipe.ingredient.mod('cobalt-steel-bearing', 'lubricant', 10)

	-- apm.lib.utils.recipe.ingredient.remove_all('steam-inserter')
	-- apm.lib.utils.recipe.ingredient.mod('steam-inserter', 'apm_steam_engine', 1)
	-- apm.lib.utils.recipe.ingredient.mod('steam-inserter', 'iron-stick', 0)
	-- apm.lib.utils.recipe.ingredient.mod('steam-inserter', 'tin-plate', 2)
	-- apm.lib.utils.recipe.ingredient.mod('steam-inserter', 'apm_steam_relay', 2)
	-- apm.lib.utils.recipe.ingredient.mod('steam-inserter', ironG, 1)
	-- apm.lib.utils.recipe.ingredient.mod('steam-inserter', ironB, 1)

	-- apm.lib.utils.recipe.ingredient.mod('apm_pump_0', tin, 1)
	-- apm.lib.utils.recipe.ingredient.mod('apm_pump_0', iron, 0)
	-- apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', tin, 3)
	-- apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', iron, 0)

	-- apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', iron, 3)
	-- apm.lib.utils.recipe.ingredient.mod('apm_burner_mining_drill_2', steel, 0)



	-- if mods.bobores and mods.bobplates then
	-- 	apm.lib.utils.recipe.ingredient.mod('apm_mechanical_relay', 'iron-plate', 0)
	-- 	apm.lib.utils.recipe.ingredient.mod('apm_mechanical_relay', 'tin-plate', 1)

	-- 	apm.lib.utils.recipe.ingredient.mod('apm_steam_relay', 'tin-plate', 2)
	-- 	apm.lib.utils.recipe.ingredient.mod('apm_steam_relay', 'iron-stick', 0)

	-- 	apm.lib.utils.recipe.ingredient.mod('electric-engine-unit', copper, 3)
	-- 	apm.lib.utils.recipe.ingredient.mod('electric-engine-unit', 'engine-unit', 0)
	-- 	apm.lib.utils.recipe.ingredient.mod('electric-engine-unit', steel, 1)
	-- 	apm.lib.utils.recipe.ingredient.mod('electric-engine-unit', 'apm_iron_bearing', 0)
	-- 	-- apm.lib.utils.recipe.ingredient.mod('electric-engine-unit', steelG, 2)

	-- 	apm.lib.utils.recipe.ingredient.mod('engine-unit', 'pipe', 0)

	-- 	apm.lib.utils.recipe.ingredient.mod('explosives', 'water', 0)
	-- 	apm.lib.utils.recipe.ingredient.mod('explosives', 'nitric-acid', 10)
	-- 	--apm_steelworks_0
	-- 	apm.lib.utils.recipe.ingredient.remove_all('apm_steelworks_0')
	-- 	apm.lib.utils.recipe.ingredient.mod('apm_steelworks_0', 'stone-furnace', 10)
	-- 	apm.lib.utils.recipe.ingredient.mod('apm_steelworks_0', 'advanced-circuit', 30)
	-- 	apm.lib.utils.recipe.ingredient.mod('apm_steelworks_0', 'concrete', 20)
	-- 	apm.lib.utils.recipe.ingredient.mod('apm_steelworks_0', 'apm_machine_frame_advanced', 10)
	-- 	--apm_steelworks_1
	-- 	-- apm.lib.utils.recipe.ingredient.remove_all('apm_steelworks_1')
	-- 	-- apm.lib.utils.recipe.ingredient.mod('apm_steelworks_1', 'electric-furnace', 6)
	-- 	-- apm.lib.utils.recipe.ingredient.mod('apm_steelworks_1', 'electronic-circuit', 30)
	-- 	-- apm.lib.utils.recipe.ingredient.mod('apm_steelworks_1', 'stone-brick', 20)
	-- 	-- apm.lib.utils.recipe.ingredient.mod('apm_steelworks_1', 'apm_machine_frame_advanced', 20)
	-- 	-- storage-tank (2,3,4)
	-- 	genStorageTank('storage-tank', 'iron-plate', 'pipe', 1)
	-- 	genStorageTank('storage-tank-2', 'invar-alloy', 'steel-pipe', 2)
	-- 	genStorageTank('storage-tank-3', 'titanium-plate', 'titanium-pipe', 3)
	-- 	genStorageTank('storage-tank-4', 'nitinol-alloy', 'nitinol-pipe', 4)
	-- 	-- electric pole
	-- 	if mods.bobpower then 
	-- 		genElectricPole(1, 'iron-plate', 'copper-cable', 'electronic-circuit')
	-- 		genElectricPole(2, 'brass-alloy', 'tinned-copper-cable', 'advanced-circuit')
	-- 		genElectricPole(3, 'titanium-plate', 'insulated-cable', 'processing-unit')
	-- 		genElectricPole(4, 'nitinol-alloy', 'gilded-copper-cable', 'advanced-processing-unit')
	-- 	end
	-- 	-- pump
	-- 	genPump(1, 'steel-plate', 'pipe', logic1)
	-- 	genPump(2, 'aluminium-plate', 'steel-pipe', logic2)
	-- 	genPump(3, 'titanium-plate', 'titanium-pipe', logic3)
	-- 	genPump(4, 'nitinol-alloy', 'nitinol-pipe', logic4)
	-- 	modPump()
	-- 	genGreenhouses()
	-- 	-- locobuff
	-- 	nuclearTrain()
	-- 	genTrainsAndWagons()
	-- 	nuclearReactor()

	-- 	-- concrete
	-- 	updateConcrete()
	-- 	-- steam fix
	-- 	enableSteamCoolant()
	-- 	-- generators
	-- 	fixBurnerGeneratorBob()
	-- 	updateGenerators()
	-- 	-- energy
	-- 	genAccum()
	-- 	fixSolarPanels()
	-- 	-- mining
	-- 	genMiners()
	-- 	genPumpjacks()
	-- 	genWaterjacks()
	-- 	genAirPumps()
	-- 	genWaterPumps()
	-- 	genVoidPump()
	-- 	--
	-- 	genFurnaces()
	-- 	genDistilators()
	-- 	genNuclearCent()
	-- 	--
	-- 	genAssemblers()
	-- 	dropFrameMaintenance()
	-- 	--
	-- 	genChemicalPlants()
	-- 	--
	-- 	genRoboports()
	-- 	genElectrolysers()
	-- 	genOilRefineries()
	-- 	--
	-- 	genWeapons()
	-- 	genSteamTurbineWithExhangers()
	-- end

	if apm.lib.utils.setting.get.starup('bobmods-logistics-beltoverhaul') then

		-- if mods.bobores and mods.bobplates then
		-- 	genBeltsRecipes('basic', 'tin-plate', 'apm_mechanical_relay', 'iron') 
		-- 	genBeltsRecipes('', 'bronze-alloy', 'basic-circuit-board', 'iron')
		-- 	genBeltsRecipes('fast', 'brass-alloy', 'electronic-circuit', 'steel')
		-- 	genBeltsRecipes('express', 'aluminium-plate', 'advanced-circuit', 'cobalt-steel')
		-- 	genBeltsRecipes('turbo', 'titanium-plate', 'processing-unit', 'titanium')
		-- 	genBeltsRecipes('ultimate', 'nitinol-alloy', 'advanced-processing-unit', 'nitinol')
		-- end
	
		apm.lib.utils.recipe.ingredient.replace('logistic-science-pack', 'basic-transport-belt', 'transport-belt')
	end
	if apm.lib.utils.setting.get.starup('bobmods-logistics-inserteroverhaul') then

		-- apm.lib.utils.recipe.ingredient.mod('long-handed-inserter', 'apm_burner_long_inserter', 0)
		-- apm.lib.utils.recipe.ingredient.mod('long-handed-inserter', 'apm_gearing', 0)
		-- apm.lib.utils.recipe.ingredient.mod('long-handed-inserter', 'inserter', 1)
		-- apm.lib.utils.recipe.ingredient.mod('yellow-filter-inserter', 'inserter', 0)
		-- apm.lib.utils.recipe.ingredient.mod('yellow-filter-inserter', 'apm_burner_filter_inserter', 1)
		-- apm.lib.utils.recipe.ingredient.mod('filter-inserter', 'apm_burner_filter_inserter', 0)
		-- apm.lib.utils.recipe.ingredient.mod('filter-inserter', 'fast-inserter', 1)
	end
	if apm.lib.utils.setting.get.starup('bobmods-logistics-inserterrequireprevious') then
		apm.lib.utils.recipe.ingredient.mod('filter-inserter', 'fast-inserter', 0)
	end
end

if mods.bobplates and apm_power_compat_bob then
	apm.lib.utils.recipe.ingredient.mod('enriched-fuel-from-liquid-fuel', 'solid-fuel', 1)
	apm.lib.utils.recipe.ingredient.replace('solid-fuel-from-hydrogen', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('polishing-wheel', 'wood', 'apm_wood_pellets', 1)

	if apm_power_compat_bob_overhaul_machine_frames then
		apm.power.machine_frame_addition('chemical-furnace', 3, nil, 3, nil)
		apm.power.machine_frame_addition('electric-mixing-furnace', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bob-distillery', 3, nil, 3, nil)
		apm.power.machine_frame_addition('electrolyser', 3, nil, 3, nil)
	end
end

if mods.bobwarfare and apm_power_compat_bob then
	apm.lib.utils.recipe.ingredient.replace('poison-rocket-warhead', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('poison-artillery-shell', 'coal', 'apm_coal_crushed', 1)
	apm.lib.utils.recipe.ingredient.replace('poison-bullet-projectile', 'coal', 'apm_coal_crushed', 1)
	apm.lib.utils.recipe.ingredient.replace('shotgun-poison-shell', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('gun-cotton', 'wood', 'apm_wood_pellets', 2)
	apm.lib.utils.recipe.ingredient.replace('sniper-rifle', 'wood', 'apm_treated_wood_planks', 1)
end

if mods.bobelectronics and apm_power_compat_bob then
	apm.lib.utils.recipe.ingredient.mod('electronic-circuit', 'apm_wood_board', 0)
	apm.lib.utils.recipe.ingredient.mod('repair-pack', 'basic-circuit-board', 0)
	apm.lib.utils.recipe.ingredient.mod('carbon', 'coal', 0)
	apm.lib.utils.recipe.ingredient.mod('carbon', 'apm_coke', 1, 2)
	apm.lib.utils.recipe.ingredient.mod('offshore-pump', 'basic-circuit-board', 0)
	apm.lib.utils.recipe.ingredient.mod('rail-signal', 'basic-circuit-board', 1)
	apm.lib.utils.recipe.ingredient.mod('rail-signal', 'electronic-circuit', 0)
	apm.lib.utils.recipe.ingredient.mod('rail-chain-signal', 'basic-circuit-board', 1)
	apm.lib.utils.recipe.ingredient.mod('rail-chain-signal', 'electronic-circuit', 1)
	apm.lib.utils.recipe.ingredient.replace('phenolic-board', 'wood', 'apm_wood_pellets', 2)
	apm.lib.utils.recipe.ingredient.replace('electric-mining-drill', 'basic-circuit-board', 'electronic-circuit')
end

if mods.bobassembly and apm_power_compat_bob then
	apm.lib.utils.recipe.remove('burner-assembling-machine')
	apm.lib.utils.recipe.remove('steam-assembling-machine')

	apm.power.machine_frame_addition('assembling-machine-3', 3, 3, 7, 4)
	apm.lib.utils.recipe.ingredient.replace('electronics-machine-1', 'iron-gear-wheel', 'apm_gearing')

	if apm_power_compat_bob_overhaul_machine_frames then
		apm.power.machine_frame_addition('assembling-machine-4', 3, 3, 9, 5)
		apm.power.machine_frame_addition('assembling-machine-5', 3, 3, 11, 6)
		apm.power.machine_frame_addition('assembling-machine-6', 3, 3, 13, 7)

		apm.power.machine_frame_addition('chemical-plant-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('chemical-plant-3', 3, 3, 7, 4)
		apm.power.machine_frame_addition('chemical-plant-4', 3, 3, 9, 5)

		apm.power.machine_frame_addition('electric-furnace-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('electric-furnace-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('electronics-machine-1', 3, nil, 3, nil)
		apm.power.machine_frame_addition('electronics-machine-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('electronics-machine-3', 3, 3, 7, 4)

		apm.power.machine_frame_addition('electric-chemical-mixing-furnace', 3, 3, 5, 3)
		apm.power.machine_frame_addition('electric-chemical-mixing-furnace-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('bob-distillery-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('bob-distillery-3', 3, 3, 7, 4)
		apm.power.machine_frame_addition('bob-distillery-4', 3, 3, 9, 5)
		apm.power.machine_frame_addition('bob-distillery-5', 3, 3, 11, 6)

		apm.power.machine_frame_addition('electrolyser-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('electrolyser-3', 3, 3, 6, 4)
		apm.power.machine_frame_addition('electrolyser-4', 3, 3, 9, 5)
		apm.power.machine_frame_addition('electrolyser-5', 3, 3, 12, 6)

		apm.power.machine_frame_addition('oil-refinery-2', 3, 3, 8, 5)
		apm.power.machine_frame_addition('oil-refinery-3', 3, 3, 10, 6)
		apm.power.machine_frame_addition('oil-refinery-4', 3, 3, 13, 7)
	end
end

if mods.bobtech and apm_power_compat_bob then
	if apm_power_compat_bob_overhaul_machine_frames then
		apm.power.machine_frame_addition('lab-2', 3, 3, 8, 5)
	end
end

if mods.bobgreenhouse and apm_power_compat_bob then
	apm.lib.utils.recipe.ingredient.mod('bob-seedling', 'wood', 0)
	apm.lib.utils.recipe.ingredient.mod('bob-seedling', 'apm_tree_seeds', 1)
	apm.lib.utils.recipe.result.mod('bob-seedling', 'bob-seedling', 10)
end

if not apm.lib.utils.setting.get.starup('apm_power_bob_rework') then
	if not mods.boblogistics and mods.bobelectronics and apm_power_compat_bob then
		apm.lib.utils.recipe.ingredient.mod('splitter', 'basic-circuit-board', 0)
	elseif mods.boblogistics and mods.bobelectronics and apm_power_compat_bob then
		if apm.lib.utils.setting.get.starup('bobmods-logistics-beltoverhaul') then
			apm.lib.utils.recipe.ingredient.mod('splitter', 'basic-circuit-board', 5)
		else
			apm.lib.utils.recipe.ingredient.mod('splitter', 'basic-circuit-board', 0)
		end
	end
end

if not apm.lib.utils.setting.get.starup('apm_power_bob_rework') then
	if mods.bobplates and apm_power_compat_bob and not mods.angelsrefining and not mods['aai-industry'] then
		apm.lib.utils.recipe.ingredient.mod('apm_lab_0', 'glass', 5)
		apm.lib.utils.recipe.ingredient.mod('apm_lab_1', 'glass', 10)
		apm.lib.utils.recipe.ingredient.mod('apm_greenhouse_0', 'glass', 25)
	end
end

if mods.bobelectronics and mods.angelsrefining and apm_power_compat_bob then
	apm.lib.utils.recipe.ingredient.mod('clarifier', 'electronic-circuit', 0)
	apm.lib.utils.recipe.ingredient.mod('clarifier', 'basic-circuit-board', 4)
end

if mods.bobmining and apm_power_compat_bob then
	apm.lib.utils.recipe.remove('steam-mining-drill')
end

-- angel ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.angelsrefining and apm_power_compat_angel then
	apm.lib.utils.recipe.ingredient.replace('filter-coal', 'coal', 'apm_coal_briquette', 1)

	apm.lib.utils.recipe.result.replace('apm_dry_mud_sifting_iron', 'iron-ore', 'angels-ore1')
	apm.lib.utils.recipe.result.replace('apm_dry_mud_sifting_copper', 'copper-ore', 'angels-ore3')
	apm.lib.utils.recipe.ingredient.replace('apm_steel_0', 'iron-ore', 'angels-ore1-crushed')
	apm.lib.utils.recipe.ingredient.replace('apm_steel_1', 'iron-ore', 'angels-ore1-crushed')
	apm.lib.utils.recipe.remove('burner-ore-crusher')
	apm.lib.utils.recipe.ingredient.replace('ore-crusher', 'burner-ore-crusher', 'apm_crusher_machine_1')
	-- angelsmods.functions.make_void(fluid_name, void_category) --categories: chemical (flare-stack), water(clarifier)
	angelsmods.functions.make_void('apm_sea_water', 'water')
	angelsmods.functions.make_void('apm_dirt_water', 'water')
	angelsmods.functions.make_void('apm_coal_saturated_wastewater', 'water')
	angelsmods.functions.make_void('apm_creosote', 'water')

	apm.lib.utils.recipe.ingredient.replace('ore-crusher', 'iron-gear-wheel', 'apm_gearing')
	if apm_power_compat_angel_overhaul_machine_frames then
		apm.power.machine_frame_addition('ore-crusher', 3, 2, 3, 3)
		apm.power.machine_frame_addition('ore-crusher-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('ore-crusher-3', 3, 3, 7, 4)

		apm.power.machine_frame_addition('ore-sorting-facility', 3, nil, 5, nil)
		apm.power.machine_frame_addition('ore-sorting-facility-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('ore-sorting-facility-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('ore-sorting-facility-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('ore-floatation-cell', 3, nil, 5, nil)
		apm.power.machine_frame_addition('ore-floatation-cell-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('ore-floatation-cell-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('ore-leaching-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('ore-leaching-plant-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('ore-leaching-plant-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('ore-refinery', 3, nil, 7, nil)
		apm.power.machine_frame_addition('ore-refinery-2', 3, 3, 9, 5)

		apm.power.machine_frame_addition('ore-powderizer', 3, nil, 3, nil)
		apm.power.machine_frame_addition('ore-powderizer-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('ore-powderizer-3', 3, 3, 7, 4)

		apm.power.machine_frame_addition('electro-whinning-cell', 3, nil, 5, nil)
		apm.power.machine_frame_addition('electro-whinning-cell-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('electro-whinning-cell-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('filtration-unit', 3, nil, 5, nil)
		apm.power.machine_frame_addition('filtration-unit-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('crystallizer', 3, nil, 5, nil)
		apm.power.machine_frame_addition('crystallizer-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('hydro-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('hydro-plant-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('hydro-plant-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('salination-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('salination-plant-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('washing-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('washing-plant-2', 3, 3, 7, 4)
	end
end

if mods.angelssmelting and apm_power_compat_angel then
	apm.lib.utils.recipe.result.mod('coolant-cool-steam', 'water-purified', 45)
	apm.lib.utils.recipe.result.mod('coolant-cool-100', 'steam', 100)
	apm.lib.utils.recipe.result.mod('coolant-cool-200', 'steam', 100)
	apm.lib.utils.recipe.result.mod('coolant-cool-300', 'steam', 100)

	apm.lib.utils.recipe.remove('apm_steelworks_0')
	apm.lib.utils.recipe.remove('apm_steelworks_1')
	apm.lib.utils.recipe.ingredient.mod('apm_steel_0', 'angels-ore1-crushed', 20, 30)
	apm.lib.utils.recipe.ingredient.mod('apm_steel_0', 'apm_stone_crucible', 2)
	apm.lib.utils.recipe.ingredient.mod('apm_steel_0', 'apm_coke_crushed', 5, 10)
	apm.lib.utils.recipe.result.mod('apm_steel_0', 'steel-plate', 2)
	apm.lib.utils.recipe.energy_required.mod('apm_steel_0', 24, 36)

	if apm_power_compat_angel_overhaul_machine_frames then
		apm.power.machine_frame_addition('ore-processing-machine', 3, nil, 5, nil)
		apm.power.machine_frame_addition('ore-processing-machine-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('ore-processing-machine-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('ore-processing-machine-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('pellet-press', 3, nil, 5, nil)
		apm.power.machine_frame_addition('pellet-press-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('pellet-press-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('pellet-press-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('powder-mixer', 3, nil, 5, nil)
		apm.power.machine_frame_addition('powder-mixer-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('powder-mixer-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('powder-mixer-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('blast-furnace', 1, nil, 5, nil)
		apm.power.machine_frame_addition('blast-furnace-2', 1, 1, 7, 4)
		apm.power.machine_frame_addition('blast-furnace-3', 1, 1, 9, 5)
		apm.power.machine_frame_addition('blast-furnace-4', 1, 1, 11, 6)

		apm.power.machine_frame_addition('angels-chemical-furnace', 3, nil, 5, nil)
		apm.power.machine_frame_addition('angels-chemical-furnace-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('angels-chemical-furnace-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('angels-chemical-furnace-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('induction-furnace', 3, nil, 5, nil)
		apm.power.machine_frame_addition('induction-furnace-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('induction-furnace-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('induction-furnace-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('casting-machine', 3, nil, 5, nil)
		apm.power.machine_frame_addition('casting-machine-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('casting-machine-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('casting-machine-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('strand-casting-machine', 3, nil, 5, nil)
		apm.power.machine_frame_addition('strand-casting-machine-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('strand-casting-machine-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('strand-casting-machine-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('sintering-oven', 3, nil, 5, nil)
		apm.power.machine_frame_addition('sintering-oven-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('sintering-oven-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('sintering-oven-4', 3, 3, 11, 6)
	end
end

if mods.angelspetrochem and apm_power_compat_angel then
	-- angelsmods.functions.make_void(fluid_name, void_category) --categories: chemical (flare-stack), water(clarifier)
	angelsmods.functions.make_void('apm_coke_oven_gas', 'chemical')

	apm.lib.utils.recipe.ingredient.replace('carbon-separation-2', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('solid-nitroglycerin', 'coal', 'apm_coal_crushed', 2)

	apm.lib.utils.recipe.result.mod('apm_refining_coke_oven_gas_1', 'gas-hydrogen', 20)
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_1', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_2', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_3', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_4', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_5', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.ingredient.replace('apm_coke_crushed', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.ingredient.replace('apm_coke_brick', 'apm_coke', 'solid-coke')

	apm.lib.utils.recipe.remove('solid-coke')
	apm.lib.utils.recipe.remove('solid-coke-sulfur')

    apm.lib.utils.recipe.ingredient.replace('apm_pyrolysis_coke_5', 'steam', 'water-purified')
    apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_5', 'sulfur', 'water-yellow-waste')
    apm.lib.utils.recipe.result.mod('apm_pyrolysis_coke_5', 'water-yellow-waste', 100)
    --apm.lib.utils.technology.add.recipe_for_unlock('angels-coal-processing-2', 'apm_pyrolysis_coke_5')
    apm.lib.utils.technology.add.recipe_for_unlock('angels-coal-cracking', 'apm_pyrolysis_coke_5')
    --apm.lib.utils.technology.add.prerequisites('angels-coal-processing-2', 'apm_coking_plant_2')
    --apm.lib.utils.technology.add.prerequisites('angels-coal-processing-2', 'apm_fuel-4')

	apm.lib.utils.recipe.remove('pellet-coke')
	apm.lib.utils.recipe.remove('coal-crushed')
	
	apm.lib.utils.recipe.result.mod('coal-cracking-1', 'solid-coke', 2)
	apm.lib.utils.recipe.result.mod('coal-cracking-2', 'solid-coke', 2)
	apm.lib.utils.recipe.result.mod('condensates-refining', 'solid-coke', 1)

	if apm_power_compat_angel_overhaul_machine_frames then
		apm.power.machine_frame_addition('angels-electrolyser', 3, nil, 5, nil)
		apm.power.machine_frame_addition('angels-electrolyser-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('angels-electrolyser-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('angels-electrolyser-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('liquifier', 3, nil, 5, nil)
		apm.power.machine_frame_addition('liquifier-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('liquifier-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('liquifier-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('angels-air-filter', 3, nil, 5, nil)
		apm.power.machine_frame_addition('angels-air-filter-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('separator', 3, nil, 5, nil)
		apm.power.machine_frame_addition('separator-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('separator-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('separator-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('gas-refinery-small', 3, nil, 5, nil)
		apm.power.machine_frame_addition('gas-refinery-small-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('gas-refinery-small-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('gas-refinery-small-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('angels-electric-boiler', 3, nil, 5, nil)

		apm.power.machine_frame_addition('steam-cracker', 3, nil, 5, nil)
		apm.power.machine_frame_addition('steam-cracker-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('steam-cracker-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('steam-cracker-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('gas-refinery', 3, nil, 5, nil)
		apm.power.machine_frame_addition('gas-refinery-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('gas-refinery-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('advanced-chemical-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('advanced-chemical-plant-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('angels-chemical-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('angels-chemical-plant-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('angels-chemical-plant-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('angels-chemical-plant-4', 3, 3, 11, 6)
	end
end

if mods.angelsbioprocessing and apm_power_compat_angel then
	-- wooden board from solid-paper
	local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_board')
	local item_icon_b = apm.lib.utils.icon.get.from_item('solid-paper')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, {-6, 0})
	local item_icon_c = {apm.lib.icons.dynamics.t3}
	local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b, item_icon_c})
	if mods.bobelectronics then
		apm.lib.utils.recipe.set.icons('wooden-board-paper', icons)
		apm.lib.utils.recipe.set.always_show_products('wooden-board-paper', true)
		if apm_power_always_show_made_in then
			apm.lib.utils.recipe.set.always_show_made_in('wooden-board-paper', true)
		end
		apm.lib.utils.recipe.energy_required.mod('wooden-board-paper', 1)
		apm.lib.utils.recipe.ingredient.mod('wooden-board-paper', 'solid-paper', 6)
		apm.lib.utils.recipe.result.mod('wooden-board-paper', 'apm_wood_board', 3)
		apm.lib.utils.recipe.result.mod('wooden-board-paper', 'wooden-board', 0)
		apm.lib.utils.recipe.category.change('wooden-board-paper', 'apm_press')
		apm.lib.utils.recipe.overwrite.group('wooden-board-paper', 'apm_power', 'apm_power_intermediates', 'ac_b')
	else
		local recipe = {}
		recipe.type = "recipe"
		recipe.name = "apm_wooden_board_from_paper"
		recipe.category = 'apm_press'
		recipe.group = "apm_power"
		recipe.subgroup = "apm_power_intermediates"
		recipe.order = 'ac_b'
		recipe.icons = icons
		recipe.normal = {}
		recipe.normal.enabled = false
		recipe.normal.energy_required = 1
		recipe.normal.ingredients = {
		        {type="item", name="solid-paper", amount=6}
		    }
		recipe.normal.results = { 
		        {type='item', name='apm_wood_board', amount=3}
		    }
		recipe.normal.main_product = ''
		recipe.normal.requester_paste_multiplier = 4
		recipe.normal.always_show_products = true
		recipe.normal.always_show_made_in = apm_power_always_show_made_in
		recipe.expensive = table.deepcopy(recipe.normal)
		data:extend({recipe})
		apm.lib.utils.technology.add.recipe_for_unlock('bio-paper-1', 'apm_wooden_board_from_paper')
	end

	-- wood pellets from wood
	local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_pellets')
	local item_icon_b = apm.lib.utils.icon.get.from_item('wood')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, {-8, -8})
	local item_icon_c = {apm.lib.icons.dynamics.t1}
	local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b, item_icon_c})
	apm.lib.utils.recipe.set.icons('apm_wood_pellets_1', icons)

	-- wood pellets from cellulose
	local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_pellets')
	local item_icon_b = apm.lib.utils.icon.get.from_item('cellulose-fiber')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, {-8, -8})
	local item_icon_c = {apm.lib.icons.dynamics.t1}
	local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b, item_icon_c})
	local recipe = table.deepcopy(data.raw.recipe['apm_wood_pellets_1'])
	recipe.name = 'apm_wood_pellets_cellulose'
	recipe.category = 'apm_press'
	recipe.icons = icons
    recipe.group = "apm_power"
    recipe.subgroup = "apm_power_wood"
    recipe.order = 'ac_b'
    recipe.normal.ingredients = {
		{type="item", name="cellulose-fiber", amount=8},
    }
    recipe.expensive.results = recipe.normal.results
    data:extend({recipe})
    apm.lib.utils.technology.add.recipe_for_unlock('bio-processing-brown', 'apm_wood_pellets_cellulose')

	-- wood-sawing I
	local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
	local item_icon_b = apm.lib.utils.icon.get.from_item('apm_saw_blade_iron')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, {-8, -6})
	local item_icon_c = {apm.lib.icons.dynamics.t1}
	local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b, item_icon_c})
	apm.lib.utils.recipe.set.icons('wood-sawing-1', icons)
	apm.lib.utils.recipe.ingredient.mod('wood-sawing-1', 'solid-saw', 0)
	apm.lib.utils.recipe.ingredient.mod('wood-sawing-1', 'apm_saw_blade_iron', 1)
	apm.lib.utils.recipe.result.mod('wood-sawing-1', 'solid-saw', 0)
	apm.lib.utils.recipe.result.mod('wood-sawing-1', 'apm_saw_blade_iron_used', 1)

	-- removing iron saw blades
	apm.lib.utils.recipe.remove('solid-saw')

	-- wood-sawing II
	local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
	local item_icon_b = apm.lib.utils.icon.get.from_item('solid-crystal-tipped-saw')
	if apm_power_compat_angel_overwrite_crystal_saw_blades then
		item_icon_b = apm.lib.utils.icon.get.from_item('apm_saw_blade_steel')
	end
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, {-8, -6})
	local item_icon_c = {apm.lib.icons.dynamics.t2}
	local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b, item_icon_c})
	apm.lib.utils.recipe.set.icons('wood-sawing-2', icons)
	if apm_power_compat_angel_overwrite_crystal_saw_blades then
		apm.lib.utils.recipe.ingredient.mod('wood-sawing-2', 'solid-crystal-tipped-saw', 0)
		apm.lib.utils.recipe.ingredient.mod('wood-sawing-2', 'apm_saw_blade_steel', 1)
		apm.lib.utils.recipe.result.mod('wood-sawing-2', 'solid-crystal-tipped-saw', 0)
		apm.lib.utils.recipe.result.mod('wood-sawing-2', 'apm_saw_blade_steel_used', 1)
	end

	--
	apm.lib.utils.recipe.ingredient.mod('solid-crystal-tipped-saw', 'solid-saw', 0)
	apm.lib.utils.recipe.ingredient.mod('solid-crystal-tipped-saw', 'apm_saw_blade_steel', 1)

	-- wood-sawing III
	local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
	local item_icon_b = apm.lib.utils.icon.get.from_item('solid-crystal-full-saw')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, {-8, -6})
	local item_icon_c = {apm.lib.icons.dynamics.t3}
	local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b, item_icon_c})
	apm.lib.utils.recipe.set.icons('wood-sawing-3', icons)

	if apm_power_compat_angel_overwrite_crystal_saw_blades then
		-- wood-sawing III
		apm.lib.utils.recipe.remove('wood-sawing-3')

		-- removing crystal saw blades
		apm.lib.utils.recipe.remove('solid-crystal-tipped-saw')
		apm.lib.utils.recipe.remove('solid-crystal-full-saw')
	end

	if apm_power_compat_angel_overhaul_machine_frames then
		apm.power.machine_frame_addition('algae-farm', 3, nil, 5, nil)
		apm.power.machine_frame_addition('algae-farm-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('algae-farm-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('bio-arboretum-1', 3, nil, 5, nil)

		apm.power.machine_frame_addition('bio-generator-desert-1', 3, nil, 5, nil)
		apm.power.machine_frame_addition('bio-generator-swamp-1', 3, nil, 5, nil)
		apm.power.machine_frame_addition('bio-generator-temperate-1', 3, nil, 5, nil)

		apm.power.machine_frame_addition('crop-farm', 3, nil, 5, nil)
		apm.power.machine_frame_addition('temperate-farm', 3, 3, 7, 4)
		apm.power.machine_frame_addition('desert-farm', 3, 3, 7, 4)
		apm.power.machine_frame_addition('swamp-farm', 3, 3, 7, 4)

		apm.power.machine_frame_addition('bio-press', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bio-processor', 3, nil, 5, nil)
		apm.power.machine_frame_addition('composter', 3, nil, 3, nil)
		apm.power.machine_frame_addition('nutrient-extractor', 3, nil, 3, nil)
		apm.power.machine_frame_addition('seed-extractor', 3, nil, 3, nil)

		apm.power.machine_frame_addition('bio-butchery', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bio-hatchery', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bio-refugium-biter', 3, nil, 5, nil)
		apm.power.machine_frame_addition('bio-refugium-fish', 3, nil, 5, nil)
		apm.power.machine_frame_addition('bio-refugium-puffer', 3, nil, 5, nil)
	end
end

if mods.angelsbioprocessing and mods.angelsrefining and apm_power_compat_angel then
end

-- bob only: steel fix --------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobplates and not mods.angelssmelting and apm_power_compat_bob then
	if mods.bobelectronics then
		apm.lib.utils.recipe.ingredient.replace('apm_steelworks_0', 'electronic-circuit', 'basic-circuit-board')
	end

	local item_icon_a = apm.lib.utils.icon.get.from_item('steel-plate')
	local item_icon_b = {apm.lib.icons.dynamics.t3}
	local item_icon_c = {apm.lib.icons.dynamics.smelting}
	local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b, item_icon_c})

	local recipe = {}
	recipe.type = "recipe"
	recipe.name = "apm_steel_2"
	recipe.category = 'apm_steelworks'
	recipe.group = "apm_power"
	recipe.subgroup = "apm_power_smelting"
	recipe.order = 'ab_c'
	recipe.icons = icons
	recipe.crafting_machine_tint = {
		primary = {r = 0.800, g = 0.800, b = 0.800, a = 1.000},
		secondary = {r = 0.850, g = 0.850, b = 0.850, a = 1.000},
		tertiary = {r = 0.800, g = 0.800, b = 0.800, a = 1.000},
		quaternary = {r = 0.850, g = 0.850, b = 0.850, a = 1.000},
	}
	recipe.normal = {}
	recipe.normal.enabled = false
	recipe.normal.energy_required = 15
	recipe.normal.ingredients = {
		{type="item", name="apm_stone_crucible", amount=4},
		{type="item", name="iron-ore", amount=8},
		{type="fluid", name="water", amount=100, fluidbox_index = 1},
		{type="fluid", name="oxygen", amount=40, fluidbox_index = 2}
	}
	recipe.normal.results = {
		{type='item', name='steel-plate', amount=4},
		{type="fluid", name="steam", amount=180, temperature=280}
	}
	recipe.normal.main_product = ''
	recipe.normal.requester_paste_multiplier = 4
	recipe.normal.always_show_products = true
	recipe.normal.always_show_made_in = apm_power_always_show_made_in
	--recipe.normal.allow_decomposition = false
	--recipe.normal.allow_as_intermediate = false
	--recipe.normal.allow_intermediates = false
	recipe.expensive = table.deepcopy(recipe.normal)
	recipe.expensive.energy_required = 25
	recipe.expensive.ingredients = {
		{type="item", name="apm_stone_crucible", amount=4},
		{type="item", name="iron-ore", amount=10},
		{type="fluid", name="water", amount=100, fluidbox_index = 1},
		{type="fluid", name="oxygen", amount=50, fluidbox_index = 2}
	}
	--recipe.expensive.results = {}
	data:extend({recipe})
	apm.lib.utils.technology.add.recipe_for_unlock('advanced-material-processing', recipe.name)
end

-- Valves ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if (mods.boblogistics and apm_power_compat_bob) or (mods.angelspetrochem and apm_power_compat_angel) then
	apm.lib.utils.recipe.remove('apm_valve_0')
	apm.lib.utils.recipe.remove('apm_valve_1')
	apm.lib.utils.recipe.remove('apm_valve_2')
	if not mods.angelspetrochem then
		apm.lib.utils.recipe.ingredient.mod('bob-valve', 'pipe', 1)
		apm.lib.utils.recipe.ingredient.mod('bob-valve', 'apm_mechanical_relay', 1)
		apm.lib.utils.recipe.ingredient.mod('bob-valve', 'iron-plate', 2)
		apm.lib.utils.recipe.ingredient.mod('bob-topup-valve', 'pipe', 1)
		apm.lib.utils.recipe.ingredient.mod('bob-topup-valve', 'apm_mechanical_relay', 1)
		apm.lib.utils.recipe.ingredient.mod('bob-topup-valve', 'iron-plate', 2)
		apm.lib.utils.recipe.ingredient.mod('bob-overflow-valve', 'pipe', 1)
		apm.lib.utils.recipe.ingredient.mod('bob-overflow-valve', 'apm_mechanical_relay', 1)
		apm.lib.utils.recipe.ingredient.mod('bob-overflow-valve', 'iron-plate', 2)
	elseif mods.angelspetrochem then
		apm.lib.utils.recipe.remove('bob-valve')
		apm.lib.utils.recipe.remove('bob-topup-valve')
		apm.lib.utils.recipe.remove('bob-overflow-valve')
		apm.lib.utils.recipe.ingredient.mod('valve-check', 'electronic-circuit', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-check', 'basic-circuit-board', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-check', 'pipe', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-check', 'apm_mechanical_relay', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-check', 'iron-plate', 2)
		apm.lib.utils.recipe.ingredient.mod('valve-overflow', 'electronic-circuit', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-overflow', 'basic-circuit-board', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-overflow', 'pipe', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-overflow', 'apm_mechanical_relay', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-overflow', 'iron-plate', 2)
		apm.lib.utils.recipe.ingredient.mod('valve-return', 'electronic-circuit', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-return', 'basic-circuit-board', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-return', 'pipe', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-return', 'apm_mechanical_relay', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-return', 'iron-plate', 2)
		apm.lib.utils.recipe.ingredient.mod('valve-underflow', 'electronic-circuit', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-underflow', 'basic-circuit-board', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-underflow', 'pipe', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-underflow', 'apm_mechanical_relay', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-underflow', 'iron-plate', 2)
		apm.lib.utils.recipe.ingredient.mod('valve-converter', 'electronic-circuit', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-converter', 'basic-circuit-board', 0)
		apm.lib.utils.recipe.ingredient.mod('valve-converter', 'pipe', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-converter', 'apm_mechanical_relay', 1)
		apm.lib.utils.recipe.ingredient.mod('valve-converter', 'iron-plate', 2)
	end
end

-- sctm -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.ScienceCostTweakerM and apm_power_compat_sctm then
	apm.lib.utils.recipe.ingredient.replace('sct-lab-t2', 'lab', 'apm_lab_1')
	apm.lib.utils.recipe.ingredient.replace('automation-science-pack', 'sct-t1-ironcore', 'apm_gearing', 1)
	apm.lib.utils.recipe.ingredient.replace('automation-science-pack', 'sct-t1-magnet-coils', 'apm_electromagnet', 1)
	apm.lib.utils.recipe.ingredient.replace_all('sct-t1-magnet-coils', 'apm_electromagnet')
	apm.lib.utils.recipe.remove('lab')
    apm.lib.utils.recipe.remove('sct-t1-ironcore')
    apm.lib.utils.recipe.remove('sct-t1-magnet-coils')

    -- apm.power.machine_frame_addition('xxx', 3, nil, 3, nil)
    if apm_power_compat_sct_overhaul_machine_frames then
    	apm.power.machine_frame_addition('sct-lab-t2', 3, 2, 8, 4)
    	apm.power.machine_frame_addition('sct-lab-t3', 3, 3, 8, 4)
    	apm.power.machine_frame_addition('sct-lab-t4', 3, 3, 8, 4)
    end
end

-- kingarthur -----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.PyCoalTBaA and apm_power_compat_kingarthur then
	apm.lib.utils.recipe.result.mod('coal-gas', 'solid-coke', 4)
	apm.lib.utils.recipe.result.mod('coal-gas-from-wood', 'coal', 5)
	apm.lib.utils.recipe.result.mod('coarse-coal', 'coal', 1)
	apm.lib.utils.recipe.remove('coke-coal')
	apm.lib.utils.recipe.remove('treated-wood')

	--apm.lib.utils.recipe.ingredient.mod_temperature('recipe_name', 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("sodium-chlorate", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("vpulp1", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("vpulp5", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("clay", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("fiberboard", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("fiberglass", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("stone-wool", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("benzene-aromatics", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("bone-fat", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("glycerol2", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("nylon", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("collagen", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("plastics-3", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("phosphoric-acid", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("propene", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("raw-ralesia-extract", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("al-pulp-02", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("nickel-pulp-04", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("u-pulp-01", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("u-pulp-02", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("u-rich-pulp", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("fiberboard-2", 'steam', 165, 120)
end
