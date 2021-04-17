if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end

require('lib.enities.base')

apm.bob_rework.lib.override.buff = function ()
    apm.lib.utils.recipe.energy_required.mod('apm_stone_brick_raw_with_crushed', 1, 1.5)
    apm.lib.utils.recipe.energy_required.mod('apm_stone_brick_raw_with_ash', 0.75, 1.25)
    apm.lib.utils.recipe.energy_required.mod('apm_stone_brick_raw_with_wed_mud', 0.75, 1.25)
end