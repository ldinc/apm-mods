if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

require('lib.utils.debug')
require('lib.utils.grid')

local setNewGridSizeAndHPToWagon = function (recipe, hp, w, h)
    local wagon = data.raw["cargo-wagon"][recipe]
    if wagon then
		wagon.max_health = hp
        local equipmentGridName = wagon.equipment_grid
        apm.bob_rework.lib.utils.grid.set(equipmentGridName, w, h)
    end
end

local buildCargoWagon  = function (recipe, tier, hp, w,h, armoured)
    setNewGridSizeAndHPToWagon(recipe, hp, w, h)

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if armoured then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 30)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12)
end

buildCargoWagon('cargo-wagon', apm.bob_rework.lib.tier.brass, 1000, 8, 6, false)
buildCargoWagon('bob-cargo-wagon-2', apm.bob_rework.lib.tier.steel2, 2000, 10, 6, false)
buildCargoWagon('bob-cargo-wagon-3', apm.bob_rework.lib.tier.titanium, 3000, 12, 6, false)
buildCargoWagon('bob-armoured-cargo-wagon', apm.bob_rework.lib.tier.steel2, 2500, 14, 6, true)
buildCargoWagon('bob-armoured-cargo-wagon-2', apm.bob_rework.lib.tier.titanium, 4000, 16, 6, true)

-------------------------------------------------------------------------------

local setNewGridSizeAndHPToFluidWagon = function (recipe, hp, w, h)
    local wagon = data.raw["fluid-wagon"][recipe]
    if wagon then
		wagon.max_health = hp
        local equipmentGridName = wagon.equipment_grid
        apm.bob_rework.lib.utils.grid.set(equipmentGridName, w, h)
    end
end

local buildFluidWagon  = function (recipe, tier, hp, w,h, armoured)
    setNewGridSizeAndHPToFluidWagon(recipe, hp, w, h)

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if armoured then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 40)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12)
end

buildFluidWagon('fluid-wagon', apm.bob_rework.lib.tier.brass, 1000, 8, 6, false)
buildFluidWagon('bob-fluid-wagon-2', apm.bob_rework.lib.tier.steel2, 2000, 10, 6, false)
buildFluidWagon('bob-fluid-wagon-3', apm.bob_rework.lib.tier.titanium, 3000, 12, 6, false)
buildFluidWagon('bob-armoured-fluid-wagon', apm.bob_rework.lib.tier.steel2, 2500, 14, 6, true)
buildFluidWagon('bob-armoured-fluid-wagon-2', apm.bob_rework.lib.tier.titanium, 4000, 16, 6, true)

-------------------------------------------------------------------------------

local setNewGridSizeAndHPToLocomotive = function (recipe, hp, w, h)
    local locomotive = data.raw.locomotive[recipe]
    if locomotive then
		locomotive.max_health = hp
        local equipmentGridName = locomotive.equipment_grid
        apm.bob_rework.lib.utils.grid.set(equipmentGridName, w, h)
    end
end

local fixNulcearLocomotive = function (recipe)
    local locomotive = data.raw.locomotive[recipe]
	if locomotive then
		locomotive.burner.fuel_category = ''
		locomotive.burner.fuel_categories = {'apm_nuclear_uranium', 'apm_nuclear_mox', 'apm_nuclear_neptunium', 'apm_nuclear_thorium'}
		locomotive.max_speed = 1.5
        locomotive.max_power = '3.67MW'
        locomotive.weight = 20000
	end

	local generator = data.raw['generator-equipment']['nuclear-generator-rampant-arsenal']
	if generator then
		generator.burner.fuel_category = ''
		generator.burner.fuel_categories = {'apm_nuclear_uranium', 'apm_nuclear_mox', 'apm_nuclear_neptunium', 'apm_nuclear_thorium'}
	end
end

local buildNuclearLocomotive = function (recipe, tier, armoured)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if armoured then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 40)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 36)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'nuclear-reactor', 1)
    local engine = apm.bob_rework.lib.entities.steamEngineUnit
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 20 + 5*tier.level)

    fixNulcearLocomotive(recipe)
end

local buildLocomotive = function (recipe, tier, hp, w, h, armoured)
    setNewGridSizeAndHPToLocomotive(recipe, hp, w, h)
    if recipe == 'nuclear-train-vehicle-rampant-arsenal' then
        buildNuclearLocomotive(recipe, tier, armoured)
        return
    end

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if armoured then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 40)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 36)
    local engine = apm.bob_rework.lib.entities.engineUnit
    if tier.level <= 1 then 
        engine = apm.bob_rework.lib.entities.simpleEngineUnit
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 20 + 5*tier.level)
end


buildLocomotive('locomotive', apm.bob_rework.lib.tier.brass, 1000, 8, 6, false)
buildLocomotive('bob-locomotive-2', apm.bob_rework.lib.tier.steel2, 2000, 10, 6, false)
buildLocomotive('bob-locomotive-3', apm.bob_rework.lib.tier.titanium, 3000, 12, 6, false)
buildLocomotive('bob-armoured-locomotive', apm.bob_rework.lib.tier.steel2, 2500, 14, 8, true)
buildLocomotive('bob-armoured-locomotive-2', apm.bob_rework.lib.tier.titanium, 4000, 16, 8, true)
buildLocomotive('nuclear-train-vehicle-rampant-arsenal', apm.bob_rework.lib.tier.titanium, 7000, 18, 8, true)

-------------------------------------------------------------------------------

local setNewGridSizeAndHPToArtillery = function (recipe, hp, w, h)
    local wagon = data.raw['artillery-wagon'][recipe]
    if wagon then
		wagon.max_health = hp
        local equipmentGridName = wagon.equipment_grid
        apm.bob_rework.lib.utils.grid.set(equipmentGridName, w, h)
    end
end

local buildArtilleryWagon = function (recipe, tier, hp, w, h)
    setNewGridSizeAndHPToArtillery(recipe, hp, w, h)

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 60)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 36)
    local engine = apm.bob_rework.lib.entities.engineUnit
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 40 + 10*tier.level)
end

buildArtilleryWagon('artillery-wagon', apm.bob_rework.lib.tier.steel2, 3000, 12, 8)
buildArtilleryWagon('bob-artillery-wagon-2', apm.bob_rework.lib.tier.aluminium, 3500, 14, 8)
buildArtilleryWagon('bob-artillery-wagon-3', apm.bob_rework.lib.tier.titanium, 4000, 16, 8)