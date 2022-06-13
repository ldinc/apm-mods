if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end
if apm.bob_rework.lib.tech == nil then apm.bob_rework.lib.tech = {} end

apm.bob_rework.lib.entities.titaniumAlloy = 'titanium-alloy'
apm.bob_rework.lib.tech.titaniumAlloy = 'titanium-alloy-processing'

local generateTitaniumAlloyItem = function()
    local icon = "__bobplates__/graphics/icons/plate/nitinol-plate.png"

    local item = {}
    item.type = 'item'
    item.name = apm.bob_rework.lib.entities.titaniumAlloy
    item.icon = icon
    item.icon_size = 32
    item.stack_size = 200
    item.subgroup = "bob-alloy"
    item.order = 'order = "c-b-g[titanium]",'
    data:extend({ item })
end

local generateTitaniumAlloyRecipe = function()
    local recipe = {
        type = "recipe",
        name = apm.bob_rework.lib.entities.titaniumAlloy,
        enabled = false,
        category = "mixing-furnace",
        energy_required = 16,
        ingredients =
        {
            { type = "item", name = apm.bob_rework.lib.entities.titanium, amount = 7 },
            { type = "item", name = apm.bob_rework.lib.entities.cobaltPlate, amount = 2 },
            { type = "item", name = apm.bob_rework.lib.entities.aluminium, amount = 1 },
        },
        results =
        {
            { type = "item", name = apm.bob_rework.lib.entities.titaniumAlloy, amount = 5 }
        },
        allow_decomposition = false
    }
    data:extend({ recipe })
end

local generateTitaniumAlloyTech = function()
    local tech = {
        type = "technology",
        name = apm.bob_rework.lib.tech.titaniumAlloy,
        prerequisites =
        {
            "alloy-processing",
            "cobalt-processing",
            "titanium-processing",
            "aluminium-processing",
            "production-science-pack"
        },
        effects = {},
        icon = "__bobplates__/graphics/icons/plate/nitinol-plate.png",
        icon_size = 32,
        order = "c-b-h",
        unit = (
            {
                count = 75,
                time = 30,
                ingredients =
                {
                    { "automation-science-pack", 1 },
                    { "logistic-science-pack", 1 },
                    { "chemical-science-pack", 1 },
                    { "production-science-pack", 1 },
                },
            }),
    }

    data:extend({ tech })

    apm.lib.utils.technology.add.recipe_for_unlock(apm.bob_rework.lib.tech.titaniumAlloy,
        apm.bob_rework.lib.entities.titaniumAlloy)
end

generateTitaniumAlloyItem()
generateTitaniumAlloyRecipe()
generateTitaniumAlloyTech()
