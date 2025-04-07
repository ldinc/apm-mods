for name, _ in pairs(data.raw["pipe"]) do
	if not apm.lib.utils.recipe.has.ingredient(name, "apm_sealing_rings") then
		apm.lib.utils.recipe.ingredient.mod(name, "apm_sealing_rings", 1)
	end
end

if not apm.lib.features.frames_recycling then
	apm.lib.utils.recipe.remove('apm_machine_frame_basic_maintenance')
	apm.lib.utils.recipe.remove('apm_machine_frame_steam_maintenance')
	apm.lib.utils.recipe.remove('apm_machine_frame_advanced_maintenance')
end


local eEngine = 'electric-engine'
local eGenerator = 'apm_egen_unit'
local eMagnet = 'apm_electromagnet'

local recipe = ""

--- [concrete]
recipe = 'concrete'
apm.lib.utils.recipe.ingredient.remove_all(recipe)
apm.lib.utils.recipe.ingredient.mod(recipe, 'water', 100)
apm.lib.utils.recipe.ingredient.mod(recipe, 'stone-brick', 5)

--- [refined-concrete]
recipe = 'refined-concrete'
apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-stick', 0)
apm.lib.utils.recipe.ingredient.mod(recipe, 'steel-plate', 2)

--- [steam-engine]
-- assuming one eGenerator ~ 400 kW
recipe = 'steam-engine'
apm.lib.utils.recipe.ingredient.mod(recipe, eGenerator, 2)
apm.lib.utils.recipe.ingredient.mod(recipe, eMagnet, 0)

--- [apm_steam_engine_2]
recipe = 'apm_steam_engine_2'
apm.lib.utils.recipe.ingredient.mod(recipe, eGenerator, 4)
apm.lib.utils.recipe.ingredient.mod(recipe, eMagnet, 0)

--- [apm_gun_powder]
if not apm.lib.utils.resource.exist('sulfur') then
	apm.lib.utils.recipe.ingredient.mod('apm_gun_powder', 'sulfur', 0)
end

--- [piercing-rounds-magazine]
recipe = 'piercing-rounds-magazine'
apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)
apm.lib.utils.recipe.ingredient.mod(recipe, 'firearm-magazine', 0)

--- [piercing-shotgun-shell]
recipe = 'piercing-shotgun-shell'
apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)
apm.lib.utils.recipe.ingredient.mod(recipe, 'shotgun-shell', 0)