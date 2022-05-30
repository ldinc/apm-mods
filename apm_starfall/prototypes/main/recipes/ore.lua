require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/recipes/ore.lua'

APM_LOG_HEADER(self)

local apm_starfall_always_show_made_in = settings.startup["apm_starfall_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_starfall_always_show_made_in', apm_starfall_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_meteorite_crushed_1"
recipe.category = 'apm_crusher'
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_ore"
recipe.order = 'aa_a'
recipe.icons = {
    apm.starfall.icons.ore_crushed,
    apm.lib.icons.dynamics.t1
}
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2
recipe.normal.ingredients = {
        {type="item", name="apm_meteorite_ore", amount=2},
        {type="fluid", name="water", amount=40}
    }
recipe.normal.results = { 
        {type='item', name='apm_meteorite_crushed', amount=3},
        --apm.lib.utils.builder.recipe.item.simple('APM_CRUSHED_STONE', 1)
        {type="fluid", name="apm_dirt_water", amount=20}
}
recipe.normal.main_product = 'apm_meteorite_crushed'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_meteorite_crushed_2"
recipe.category = 'apm_crusher_2'
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_ore"
recipe.order = 'aa_b'
recipe.icons = {
    apm.starfall.icons.ore_crushed,
    apm.lib.icons.dynamics.t2
}
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2
recipe.normal.ingredients = {
        {type="item", name="apm_meteorite_ore", amount=2},
        {type="item", name="apm_crusher_drums", amount=1},
        {type="fluid", name="water", amount=40}
    }
recipe.normal.results = { 
        {type='item', name='apm_meteorite_crushed', amount=4},
        --apm.lib.utils.builder.recipe.item.simple('APM_CRUSHED_STONE', 1),
        {type='item', name='apm_crusher_drums_used', amount=1, catalyst_amount=1},
        {type="fluid", name="apm_dirt_water", amount=20}
}
recipe.normal.main_product = 'apm_meteorite_crushed'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_sulphurous_meteorite_solution')
local item_icon = apm.lib.utils.icon.get.from_item('sulfuric-acid')
item_icon = apm.lib.utils.icons.mod(item_icon, 0.6, {-8,-8})
local icons = apm.lib.utils.icon.merge({fluid_icon, item_icon})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_sulphurous_meteorite_solution"
recipe.category = 'chemistry'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_ore_processing"
recipe.order = 'ab_a'

local fluid = data.raw.fluid['apm_sulphurous_meteorite_solution']
recipe.crafting_machine_tint = {
  primary   = fluid.base_color,
  secondary = fluid.flow_color,
  tertiary  = fluid.base_color,
  quaternary = {r=0.780, g=0.780, b=0.047}
}
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 7.5
recipe.normal.ingredients = {
        {type="item", name="apm_meteorite_crushed", amount=10},
        {type="fluid", name="sulfuric-acid", amount=20}
    }
recipe.normal.results = { 
        {type='fluid', name='apm_sulphurous_meteorite_solution', amount=50}
    }
recipe.normal.main_product = 'apm_sulphurous_meteorite_solution'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_dissolved_meteorite_slurry')
local item_icon = apm.lib.utils.icon.get.from_item('sulfur')
item_icon = apm.lib.utils.icons.mod(item_icon, 0.5, {-8,8})
local icons = apm.lib.utils.icon.merge({fluid_icon, item_icon})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_dissolved_meteorite_slurry_desulfurize"
recipe.category = 'chemistry'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_ore_processing"
recipe.order = 'ad_a'

local fluid = data.raw.fluid['apm_sulphurous_meteorite_solution']
recipe.crafting_machine_tint = {
  primary   = fluid.base_color,
  secondary = fluid.flow_color,
  tertiary  = fluid.base_color,
  quaternary = {r=0.780, g=0.780, b=0.047}
}

recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="fluid", name="apm_sulphurous_meteorite_solution", amount=50},
        apm.lib.utils.builder.recipe.item.simple('APM_WATER', 4)
    }
recipe.normal.results = { 
        {type='fluid', name='apm_dissolved_meteorite_slurry', amount=40},
        apm.lib.utils.builder.recipe.item.simple('APM_SULFUR_RESULT', 1, 1, nil, 10)
    }
recipe.normal.main_product = 'apm_dissolved_meteorite_slurry'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_metal_catalyst_frame"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="item", name="steel-plate", amount=1},
    }
recipe.normal.results = { 
        {type='item', name='apm_metal_catalyst_frame', amount=3}
    }
recipe.normal.main_product = 'apm_metal_catalyst_frame'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon = apm.lib.utils.icon.get.from_item('apm_metal_catalyst_frame_used')
local fluid_icon = apm.lib.utils.icon.get.from_fluid('water')
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, {-8,-8})
local icons = apm.lib.utils.icon.merge({item_icon, fluid_icon})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_metal_catalyst_frame_used_maintenance"
recipe.category = 'chemistry'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_catalysts"
recipe.order = 'ad_b'

local fluid = data.raw.fluid['water']
recipe.crafting_machine_tint = {
  primary   = fluid.base_color,
  secondary = fluid.flow_color,
  tertiary  = fluid.base_color,
}
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="item", name="apm_metal_catalyst_frame_used", amount=5},
        apm.lib.utils.builder.recipe.item.simple('APM_WATER', 5)
    }
recipe.normal.results = { 
        {type='item', name='apm_metal_catalyst_frame', amount=4},
        {type="item", name="apm_metal_catalyst_frame", amount_min=1, amount_max=1, probability=0.95, catalyst_amount=1},
        {type='fluid', name='apm_dirt_water', amount=50}
    }
recipe.normal.main_product = ''
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_metal_catalyst_copper"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2
recipe.normal.ingredients = {
        {type="item", name="copper-ore", amount=1},
        {type='item', name='apm_metal_catalyst_frame', amount=3}
    }
recipe.normal.results = { 
        {type='item', name='apm_metal_catalyst_copper', amount=3}
    }
recipe.normal.main_product = 'apm_metal_catalyst_copper'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_meteorite_copper_solution')
local item_icon = apm.lib.utils.icon.get.from_item('apm_metal_catalyst_copper')
item_icon = apm.lib.utils.icons.mod(item_icon, 0.6, {-8,-8})
local icons = apm.lib.utils.icon.merge({fluid_icon, item_icon})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_meteorite_copper_solution_catalyse"
recipe.category = 'chemistry'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_ore_processing"
recipe.order = 'ac_a'

local fluid = data.raw.fluid['apm_meteorite_copper_solution']
recipe.crafting_machine_tint = {
  primary   = fluid.base_color,
  secondary = fluid.flow_color,
  tertiary  = fluid.base_color,
  quaternary = {r=0.792, g=0.988, b=0.011}
}
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="item", name="apm_metal_catalyst_copper", amount=1},
        {type="fluid", name="apm_dissolved_meteorite_slurry", amount=40}
    }
recipe.normal.results = { 
        {type='item', name='apm_metal_catalyst_frame_used', amount=1, catalyst_amount=1},
        {type='fluid', name='apm_meteorite_copper_solution', amount=40}
    }
recipe.normal.main_product = 'apm_meteorite_copper_solution'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})
 
 -- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe('basic-oil-processing')
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_meteorite_copper_solution')
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, {-8,-8})
local icons = apm.lib.utils.icon.merge({recipe_icon, fluid_icon})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_meteorite_copper_solution_centrifuging"
recipe.category = 'apm_centrifuge_0'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_centrifuging"
recipe.order = 'aa_a'

recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="fluid", name="apm_meteorite_copper_solution", amount=15}
    }
recipe.normal.results = { 
        {type='item', name='copper-ore', amount_min=1, amount_max=1, probability=0.78},
        apm.lib.utils.builder.recipe.item.probability('APM_SLAG', 1, 1, 0.22)
    }
recipe.normal.main_product = ''
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_metal_catalyst_iron"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2
recipe.normal.ingredients = {
        {type="item", name="iron-ore", amount=1},
        {type='item', name='apm_metal_catalyst_frame', amount=3}
    }
recipe.normal.results = { 
        {type='item', name='apm_metal_catalyst_iron', amount=3}
    }
recipe.normal.main_product = 'apm_metal_catalyst_iron'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_meteorite_iron_solution')
local item_icon = apm.lib.utils.icon.get.from_item('apm_metal_catalyst_iron')
item_icon = apm.lib.utils.icons.mod(item_icon, 0.6, {-8,-8})
local icons = apm.lib.utils.icon.merge({fluid_icon, item_icon})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_meteorite_iron_solution_catalyse"
recipe.category = 'chemistry'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_ore_processing"
recipe.order = 'ac_b'

local fluid = data.raw.fluid['apm_meteorite_iron_solution']
recipe.crafting_machine_tint = {
  primary   = fluid.base_color,
  secondary = fluid.flow_color,
  tertiary  = fluid.base_color,
  quaternary = {r=0.792, g=0.988, b=0.011}
}
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="item", name="apm_metal_catalyst_iron", amount=1},
        {type="fluid", name="apm_dissolved_meteorite_slurry", amount=40},
    }
recipe.normal.results = { 
        {type='item', name='apm_metal_catalyst_frame_used', amount=1, catalyst_amount=1},
        {type='fluid', name='apm_meteorite_iron_solution', amount=40}
    }
recipe.normal.main_product = 'apm_meteorite_iron_solution'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})
 
 -- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe('basic-oil-processing')
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_meteorite_iron_solution')
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, {-8,-8})
local icons = apm.lib.utils.icon.merge({recipe_icon, fluid_icon})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_meteorite_iron_solution_centrifuging"
recipe.category = 'apm_centrifuge_0'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_centrifuging"
recipe.order = 'ab_a'

recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="fluid", name="apm_meteorite_iron_solution", amount=15}
    }
recipe.normal.results = { 
        {type='item', name='iron-ore', amount_min=1, amount_max=1, probability=0.78},
        apm.lib.utils.builder.recipe.item.probability('APM_SLAG', 1, 1, 0.22)
    }
recipe.normal.main_product = ''
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local fluid_icon_a = apm.lib.utils.icon.get.from_fluid('apm_mixed_meteorite_slurry')
local fluid_icon_b = apm.lib.utils.icon.get.from_fluid('apm_meteorite_iron_solution')
local fluid_icon_c = apm.lib.utils.icon.get.from_fluid('apm_meteorite_copper_solution')
fluid_icon_b = apm.lib.utils.icons.mod(fluid_icon_b, 0.5, {-8,-9})
fluid_icon_c = apm.lib.utils.icons.mod(fluid_icon_c, 0.5, {-3,-9})
local icons = apm.lib.utils.icon.merge({fluid_icon_a, fluid_icon_b, fluid_icon_c})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_mixed_meteorite_slurry"
recipe.category = 'chemistry'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_ore_processing"
recipe.order = 'ad_a'

local fluid = data.raw.fluid['apm_mixed_meteorite_slurry']
recipe.crafting_machine_tint = {
  primary   = fluid.base_color,
  secondary = fluid.base_color,
  tertiary  = fluid.base_color,
  quaternary = {r=0.706, g=0.024, b=0.812}
}
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="fluid", name="apm_meteorite_iron_solution", amount=20},
        {type="fluid", name="apm_meteorite_copper_solution", amount=20}
    }
recipe.normal.results = { 
        {type='fluid', name='apm_mixed_meteorite_slurry', amount=40}
    }
recipe.normal.main_product = 'apm_mixed_meteorite_slurry'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe('basic-oil-processing')
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_mixed_meteorite_slurry')
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, {-8,-8})
local item_icon_c = {apm.lib.icons.dynamics.t1}
local icons = apm.lib.utils.icon.merge({recipe_icon, fluid_icon, item_icon_c})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_mixed_meteorite_slurry_centrifuging_1"
recipe.category = 'apm_centrifuge_0'
recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_centrifuging"
recipe.order = 'ac_a'

recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="fluid", name="apm_mixed_meteorite_slurry", amount=10}
    }
recipe.normal.results = { 
        {type='item', name='iron-ore', amount_min=1, amount_max=1, probability=0.42},
        {type='item', name='copper-ore', amount_min=1, amount_max=1, probability=0.42},
        apm.lib.utils.builder.recipe.item.probability('APM_SLAG', 1, 1, 0.16)
    }
recipe.normal.main_product = ''
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe('basic-oil-processing')
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_mixed_meteorite_slurry')
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, {-8,-8})
local item_icon_c = {apm.lib.icons.dynamics.t2}
local icons = apm.lib.utils.icon.merge({recipe_icon, fluid_icon, item_icon_c})

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_mixed_meteorite_slurry_centrifuging_2"
recipe.category = 'apm_centrifuge_0'

recipe.icons = icons
recipe.group = "apm_starfall"
recipe.subgroup = "apm_starfall_centrifuging"
recipe.order = 'ac_b'

recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 2.5
recipe.normal.ingredients = {
        {type="fluid", name="apm_mixed_meteorite_slurry", amount=10}
    }
recipe.normal.results = { 
        {type='item', name='iron-ore', amount_min=1, amount_max=1, probability=0.42},
        {type='item', name='copper-ore', amount_min=1, amount_max=1, probability=0.42},
        {type='item', name='uranium-ore', amount_min=1, amount_max=1, probability=0.1, show_details_in_recipe_tooltip=false},
        apm.lib.utils.builder.recipe.item.probability('APM_THORIUM', 1, 1, 0.05),
        apm.lib.utils.builder.recipe.item.probability('APM_SLAG', 1, 1, 0.01)
    }
recipe.normal.main_product = ''
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_starfall_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
data:extend({recipe})
