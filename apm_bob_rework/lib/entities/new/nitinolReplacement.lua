if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end
if apm.bob_rework.lib.tech == nil then apm.bob_rework.lib.tech = {} end
if apm.bob_rework.lib.pipe == nil then apm.bob_rework.lib.pipe = {} end
if apm.bob_rework.lib.pipe.toGround == nil then apm.bob_rework.lib.pipe.toGround = {} end

require('lib.entities.pipes')
require('lib.entities.new.plate')

apm.bob_rework.lib.entities.titaniumAlloy = 'titanium-alloy'
apm.bob_rework.lib.tech.titaniumAlloy = 'titanium-alloy-processing'
apm.bob_rework.lib.pipe.titaniumAlloy = 'titanium-alloy-pipe'
apm.bob_rework.lib.pipe.toGround.titaniumAlloy = 'titanium-alloy-pipe-to-ground'

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

  icon = '__boblogistics__/graphics/icons/pipe/nitinol-pipe.png'
  item = {}
  item.type = 'item'
  item.name = apm.bob_rework.lib.pipe.titaniumAlloy
  item.icon = icon
  item.icon_size = 32
  item.stack_size = 200
  item.subgroup = "pipe"
  item.order = 'order = "c-b-g[titanium]",'
  item.place_result = apm.bob_rework.lib.pipe.titaniumAlloy
  data:extend({ item })

  icon = '__boblogistics__/graphics/icons/pipe/nitinol-pipe-to-ground.png'
  item = {}
  item.type = 'item'
  item.name = apm.bob_rework.lib.pipe.toGround.titaniumAlloy
  item.icon = icon
  item.icon_size = 32
  item.stack_size = 200
  item.subgroup = "pipe-to-ground"
  item.order = 'order = "c-b-g[titanium]",'
  item.place_result = apm.bob_rework.lib.pipe.toGround.titaniumAlloy
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

  recipe = {
    type = "recipe",
    name = apm.bob_rework.lib.pipe.titaniumAlloy,
    enabled = false,
    category = "crafting",
    energy_required = 0.5,
    ingredients =
    {
      { type = "item", name = apm.bob_rework.lib.entities.titaniumAlloy, amount = 1 },
      { type = "item", name = apm.bob_rework.lib.entities.sealingRings, amount = 1 }
    },
    results =
    {
      { type = "item", name = apm.bob_rework.lib.pipe.titaniumAlloy, amount = 1 }
    },
    allow_decomposition = true
  }
  data:extend({ recipe })

  recipe = {
    type = "recipe",
    name = apm.bob_rework.lib.pipe.toGround.titaniumAlloy,
    enabled = false,
    category = "crafting",
    energy_required = 0.5,
    ingredients =
    {
      { type = "item", name = apm.bob_rework.lib.pipe.titaniumAlloy, amount = 18 },
      { type = "item", name = apm.bob_rework.lib.entities.titaniumAlloy, amount = 5 }
    },
    results =
    {
      { type = "item", name = apm.bob_rework.lib.pipe.toGround.titaniumAlloy, amount = 1 }
    },
    allow_decomposition = true
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
  apm.lib.utils.technology.add.recipe_for_unlock(apm.bob_rework.lib.tech.titaniumAlloy,
    apm.bob_rework.lib.pipe.titaniumAlloy)
  apm.lib.utils.technology.add.recipe_for_unlock(apm.bob_rework.lib.tech.titaniumAlloy,
    apm.bob_rework.lib.pipe.toGround.titaniumAlloy)
end

local generateTitaniumAlloyPipes = function()
  local pipe = data.raw.pipe[apm.bob_rework.lib.entities.nitinolPipe]
  if pipe then
    local item = table.deepcopy(pipe)
    item.name = apm.bob_rework.lib.pipe.titaniumAlloy
    data:extend({ item })
  end
  local underPipe = data.raw["pipe-to-ground"][apm.bob_rework.lib.pipe.toGround.nitinol]
  if underPipe then
    local item = table.deepcopy(underPipe)
    item.name = apm.bob_rework.lib.pipe.toGround.titaniumAlloy
    data:extend({ item })
  end
end

generateTitaniumAlloyItem()
generateTitaniumAlloyPipes()
generateTitaniumAlloyRecipe()
generateTitaniumAlloyTech()
