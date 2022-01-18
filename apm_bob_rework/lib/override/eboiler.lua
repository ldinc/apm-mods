if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.eboiler = function ()
    local tech = data.raw.technology['electric-boiler']
    if tech then
        tech.icon = "__apm_bob_rework_ldinc__/graphics/icons/eboiler.png"
        tech.icon_size = 144
    end

    local recipe = 'electric-boiler'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron, 20)

    local rm = apm.lib.utils.recipe.remove
    rm('electric-boiler-2')
    rm('electric-boiler-3')
    rm('electric-boiler-4')
    rm('electric-boiler-5')
end