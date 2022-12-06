local entityPath = "__apm_bob_rework_resource_pack_ldinc__/graphics/equipments/krastorio/"
local iconPath = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/krastorio/equipments/"
local constants = require("scripts.constants")

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = "energy-absorber"
item.icon = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/krastorio/equipments/energy-absorber.png"
item.icon_size = 64
item.icon_mipmaps = 4
item.subgroup = "equipment"
item.order = "a1[energy-source]-a1[energy-absorber]"
item.placed_as_equipment_result = "energy-absorber"
item.stack_size = 10
data:extend({item})

-- Equipment ------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local equipment = {
    type = "battery-equipment",
    name = "energy-absorber",
    sprite = {
      filename =  "__apm_bob_rework_resource_pack_ldinc__/graphics/equipments/krastorio/energy-absorber.png",
      width = 128,
      height = 128,
      scale = 0.55,
      priority = "medium",
      hr_version = {
        filename = "__apm_bob_rework_resource_pack_ldinc__/graphics/equipments/krastorio/hr-energy-absorber.png",
        width = 256,
        height = 256,
        priority = "medium",
        scale = 0.275,
      },
    },
    shape = {
      width = 2,
      height = 2,
      type = "full",
    },
    energy_source = {
      type = "electric",
      buffer_capacity = "5MJ",
      input_flow_limit = "50000kW",
      output_flow_limit = util.format_number(
        constants.tesla_coil.charging_rate * constants.tesla_coil.simultaneous_allowed,
        true
      ) .. "W",
      usage_priority = "primary-output",
    },
    categories = { "armor" },
  }
data:extend({equipment})