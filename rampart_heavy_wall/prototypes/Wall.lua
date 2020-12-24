local walls = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local wallUtils = require("utils/WallUtils")

local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeWall = wallUtils.makeWall
local addResistance = wallUtils.addResistance
local makeGate = wallUtils.makeGate

function walls.enable()

    local wallIngredients = {
        {name="refined-concrete", amount=5},
        {name="steel-plate", amount=20},
    }
 
    local gateIngredients = {
        {name="todo", amount=1},
        {name="steel-plate", amount=20},
        {name="advanced-circuit", amount=45},
    }

    local bobPlateTuning = settings.startup["rampart-heavy-wall-bobs-plates"].value
    local bobETuning = settings.startup["rampart-heavy-wall-bobs-electronics"].value

    local hp = settings.startup["wall-hp"].value
    local amount = math.ceil(hp / 100) * settings.startup["wall-k"].value
    local concrete = math.ceil(hp / 300)
    local heavyWall,heavyWallItem = makeWall(
        {
            name = "heavy",
            icon = "__rampart_heavy_wall__/graphics/icons/wall.png",
            health = hp,
            tint = {r=0.5,g=0.5,b=0.40,a=1},
            order = "a[stone-wall]-a[ztitanium-wall]",
            resistances = {
                {
                    type = "physical",
                    decrease = 6,
                    percent = 50
                },
                {
                    type = "impact",
                    decrease = 45,
                    percent = 90
                },
                {
                    type = "explosion",
                    decrease = 20,
                    percent = 70
                },
                {
                    type = "acid",
                    percent = 80
                },
                {
                    type = "fire",
                    percent = 100
                },
                {
                    type = "laser",
                    percent = 80
                },
                {
                    type = "electric",
                    percent = 80
                },
                {
                    type = "poison",
                    percent = 80
                }
            }
        }
    )

    local heavyGate,heavyGateItem = makeGate(
        {
            name = "heavy",
            icon = "__rampart_heavy_wall__/graphics/icons/gate.png",
            health = hp,
            tint = {r=0.5,g=0.5,b=0.4,a=1},
            order = "a[wall]-b[gatezzz]",
            resistances = {
                {
                    type = "physical",
                    decrease = 6,
                    percent = 50
                },
                {
                    type = "impact",
                    decrease = 45,
                    percent = 90
                },
                {
                    type = "explosion",
                    decrease = 20,
                    percent = 70
                },
                {
                    type = "acid",
                    percent = 80
                },
                {
                    type = "fire",
                    percent = 100
                },
                {
                    type = "laser",
                    percent = 80
                },
                {
                    type = "electric",
                    percent = 80
                },
                {
                    type = "poison",
                    percent = 70
                }
            }
        }
    )

    -- prepare recipes
    -- patch gates
    gateIngredients[1].name = heavyWallItem
    gateIngredients[1].amount = 1
    -- tune recipes with settings
    wallIngredients[2].amount = amount
    -- change for bobs mods
    if bobPlateTuning then
        local cobalt = amount * 0.05 
        local iron = amount * 0.03
        wallIngredients = {
            {name="refined-concrete", amount=concrete},
            {name="tungsten-plate", amount=amount},
            {name="cobalt-plate", amount=cobalt},
        }
        -- tungsten-plate + cobalt-plate
        -- advanced-processing-unit
        gateIngredients = {
            {name=heavyWallItem, amount=1},
            {name="aluminium-plate", amount=2},
            {name="advanced-circuit", amount=45},
        }
    end
    if bobETuning and gateIngredients[3] ~= nil then 
        gateIngredients[3].name = "advanced-processing-unit"
        gateIngredients[3].amount = 5
    end
    --

    makeRecipe({
            name = heavyWallItem,
            icon = "__rampart_heavy_wall__/graphics/icons/wall.png",
            enabled = false,
            category = "crafting",
            ingredients = wallIngredients,
            result = heavyWallItem
    })

    makeRecipe({
            name = heavyGateItem,
            icon = "__rampart_heavy_wall__/graphics/icons/gate.png",
            enabled = false,
            category = "crafting",
            ingredients = gateIngredients,
            result = heavyGateItem
    })

    addEffectToTech("stone-walls-3",
                    {
                        {
                            type = "unlock-recipe",
                            recipe = heavyWallItem
                        },
                        {
                            type = "unlock-recipe",
                            recipe = heavyGateItem
                        }
    })
end

return walls
