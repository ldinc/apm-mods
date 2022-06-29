if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end
if apm.bob_rework.lib.tech == nil then apm.bob_rework.lib.tech = {} end
if apm.bob_rework.lib.pipe == nil then apm.bob_rework.lib.pipe = {} end
if apm.bob_rework.lib.pipe.toGround == nil then apm.bob_rework.lib.pipe.toGround = {} end

local alloy = require('lib.entities.alloys')
local pipe = require('lib.entities.pipes')
local plate = require('lib.entities.plates')
local p = require('lib.entities.product')
local tech = require('lib.entities.tech')
local science = require('lib.entities.science')

local generateTitaniumAlloyItem = function()
  local icon = "__bobplates__/graphics/icons/plate/nitinol-plate.png"

  local item = {}
  item.type = 'item'
  item.name = alloy.titanium
  item.icon = icon
  item.icon_size = 32
  item.stack_size = 200
  item.subgroup = "bob-alloy"
  item.order = 'order = "c-b-g[titanium]",'
  data:extend({ item })

  icon = '__boblogistics__/graphics/icons/pipe/nitinol-pipe.png'
  item = {}
  item.type = 'item'
  item.name = pipe.base.titaniumAlloy
  item.icon = icon
  item.icon_size = 32
  item.stack_size = 200
  item.subgroup = "pipe"
  item.order = 'order = "c-b-g[titanium]",'
  item.place_result = pipe.base.titaniumAlloy
  data:extend({ item })

  icon = '__boblogistics__/graphics/icons/pipe/nitinol-pipe-to-ground.png'
  item = {}
  item.type = 'item'
  item.name = pipe.under.titaniumAlloy
  item.icon = icon
  item.icon_size = 32
  item.stack_size = 200
  item.subgroup = "pipe-to-ground"
  item.order = 'order = "c-b-g[titanium]",'
  item.place_result = pipe.under.titaniumAlloy
  data:extend({ item })
end

local generateTitaniumAlloyRecipe = function()
  local recipe = {
    type = "recipe",
    name = alloy.titanium,
    enabled = false,
    category = "mixing-furnace",
    energy_required = 16,
    ingredients =
    {
      { type = "item", name = plate.titanium, amount = 7 },
      { type = "item", name = plate.cobalt, amount = 2 },
      { type = "item", name = plate.aluminium, amount = 1 },
    },
    results =
    {
      { type = "item", name = alloy.titanium, amount = 5 }
    },
    allow_decomposition = false
  }
  data:extend({ recipe })

  recipe = {
    type = "recipe",
    name = pipe.base.titaniumAlloy,
    enabled = false,
    category = "crafting",
    energy_required = 0.5,
    ingredients =
    {
      { type = "item", name = alloy.titanium, amount = 1 },
      { type = "item", name = p.sealing.rings, amount = 1 }
    },
    results =
    {
      { type = "item", name = pipe.base.titaniumAlloy, amount = 1 }
    },
    allow_decomposition = true
  }
  data:extend({ recipe })

  recipe = {
    type = "recipe",
    name = pipe.under.titaniumAlloy,
    enabled = false,
    category = "crafting",
    energy_required = 0.5,
    ingredients =
    {
      { type = "item", name = pipe.base.titaniumAlloy, amount = 18 },
      { type = "item", name = alloy.titanium, amount = 5 }
    },
    results =
    {
      { type = "item", name = pipe.under.titaniumAlloy, amount = 1 }
    },
    allow_decomposition = true
  }
  data:extend({ recipe })
end

local generateTitaniumAlloyTech = function()
  local techBody = {
    type = "technology",
    name = tech.processing.titaniumAlloy,
    prerequisites =
    {
      tech.processing.alloy,
      tech.processing.cobalt,
      tech.processing.titanium,
      tech.processing.aluminium,
      tech.science.production,
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
            { science.automation, 1 },
            { science.logistics, 1 },
            { science.chemical, 1 },
            { science.production, 1 },
          },
        }),
  }

  data:extend({ techBody })

  local unlock = apm.lib.utils.technology.add.recipe_for_unlock

  unlock(tech.processing.titaniumAlloy, alloy.titanium)
  unlock(tech.processing.titaniumAlloy, pipe.base.titaniumAlloy)
  unlock(tech.processing.titaniumAlloy, pipe.under.titaniumAlloy)
end

local generateTitaniumAlloyPipes = function()
  local target = data.raw.pipe[pipe.base.nitinol]
  if target then
    local item = table.deepcopy(target)
    item.name = pipe.base.titaniumAlloy
    data:extend({ item })
  end
  local target = data.raw["pipe-to-ground"][pipe.under.nitinol]
  if target then
    local item = table.deepcopy(target)
    item.name = pipe.under.titaniumAlloy
    data:extend({ item })
  end
end

generateTitaniumAlloyItem()
generateTitaniumAlloyPipes()
generateTitaniumAlloyRecipe()
generateTitaniumAlloyTech()
