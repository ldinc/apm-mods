local technologies = {}

local technologyUtils = require("utils/TechnologyUtils")

local makeTechnology = technologyUtils.makeTechnology

function technologies.enable()

    makeTechnology({
        name = "stone-walls-3",
        icon="__base__/graphics/technology/stone-wall.png",
        iconSize=256,
        iconMipmaps=4,            
        prerequisites = {"military-4", "concrete", "stone-wall", "gate"},
        effects = {},
        count = 400,
        ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1}
        },
        time = 30}
    )

end

return technologies
