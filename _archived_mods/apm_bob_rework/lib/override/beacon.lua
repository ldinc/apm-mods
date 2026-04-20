if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local b = require('lib.entities.buildings.beacons')
local tier = require('lib.tier.base')

local gen = function(name, t, count)
    apm.lib.utils.recipe.ingredient.remove_all(name)
    apm.lib.utils.recipe.ingredient.mod(name, t.frame, count)
    apm.lib.utils.recipe.ingredient.mod(name, t.wire, count * 4)
    apm.lib.utils.recipe.ingredient.mod(name, t.logic, 20)

    if t.extraLogic then
        apm.lib.utils.recipe.ingredient.mod(name, t.extraLogic, 20)
    end
    
    apm.lib.utils.recipe.ingredient.mod(name, t.constructionAlloy, 5)
end

local fixIcon = function()
    apm.lib.utils.recipe.set.icons(b.basic, {
        [1] = {
            icon = '__classic-beacon__/graphics/icon/beacon.png',
            icon_size = 64,
            icon_mipmaps = 4,
        },
        [2] = {
            icon = '__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_tier_1.png',
            icon_size = 64
        },
    })

    apm.lib.utils.recipe.set.icons(b.advance, {
        [1] = {
            icon = '__classic-beacon__/graphics/icon/beacon.png',
            icon_size = 64,
            icon_mipmaps = 4,
        },
        [2] = {
            icon = '__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_tier_2.png',
            icon_size = 64
        },
    })

    apm.lib.utils.item.set.icons(b.advance, {
        [1] = {
            icon = '__classic-beacon__/graphics/icon/beacon.png',
            icon_size = 64,
            icon_mipmaps = 4,
        },
    })
end

local tune = function ()
    local beacon = data.raw.beacon[b.advance]

    beacon.module_specification.module_slots = 4
    beacon.module_specification.distribution_effectivity = 1.0

    local beacon = data.raw.beacon[b.basic]

    beacon.module_specification.module_slots = 4
    beacon.module_specification.distribution_effectivity = 0.5
end

apm.bob_rework.lib.override.beacon = function()
    gen(b.basic, tier.red, 9)
    -- gen(b.extra, tier.blue, 16)
    gen(b.advance, tier.blue, 16)

    fixIcon()
    tune()
end
