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
buildCargoWagon('bob-cargo-wagon-2', apm.bob_rework.lib.tier.monel, 2000, 10, 6, false)
buildCargoWagon('bob-cargo-wagon-3', apm.bob_rework.lib.tier.steel, 3000, 12, 6, false)
buildCargoWagon('bob-armoured-cargo-wagon', apm.bob_rework.lib.tier.aluminium, 4000, 14, 6, true)
buildCargoWagon('bob-armoured-cargo-wagon-2', apm.bob_rework.lib.tier.titanium, 5000, 16, 6, true)

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
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 30)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.enities.rubber, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12)
end

buildFluidWagon('fluid-wagon', apm.bob_rework.lib.tier.brass, 1000, 8, 6, false)
buildFluidWagon('bob-fluid-wagon-2', apm.bob_rework.lib.tier.monel, 2000, 10, 6, false)
buildFluidWagon('bob-fluid-wagon-2', apm.bob_rework.lib.tier.steel, 3000, 12, 6, false)
buildFluidWagon('bob-armoured-fluid-wagon', apm.bob_rework.lib.tier.aluminium, 4000, 14, 6, true)
buildFluidWagon('bob-armoured-fluid-wagon-2', apm.bob_rework.lib.tier.titanium, 5000, 16, 6, true)