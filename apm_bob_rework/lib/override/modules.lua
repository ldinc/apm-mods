if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local gems                          = require "lib.entities.gems"
local modules                       = require "lib.entities.modules"

apm.bob_rework.lib.override.modules = function()
    -- update V tier to used amethyst
    local upV = function(name)
        apm.lib.utils.recipe.ingredient.replace(name, gems.ruby.polished, gems.amethyst.polished, 1)
    end

    upV(modules.speed.V)
    upV(modules.speed.pure.V)
    upV(modules.effectivity.V)
    upV(modules.productivity.V)
    upV(modules.productivity.pure.V)
    upV(modules.pollution.V)
    upV(modules.pollution.clean.V)
    upV(modules.green.V)
end
