if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.utils.recipe')

local update = function ()
    local dp = apm.bob_rework.lib.utils.disable_productivity
    local recipes = {}
    local push = function (recipe)
        recipes[recipe] = true
    end
    push('water-electrolysis')
    dp(recipes)
end

update()
