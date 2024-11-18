require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_nuclear/prototypes/main/equipment/rtg.lua'

APM_LOG_HEADER(self)

---@type data.GeneratorEquipmentPrototype
local rtg = {
  type = "generator-equipment",
  name = "apm_rtg_radioisotope_thermoelectric_generator",
  sprite = {
    filename = apm.nuclear.icons.rtg.icon,
    width = apm.nuclear.icons.rtg.icon_size,
    height = apm.nuclear.icons.rtg.icon_size,
    priority = "medium",
  },
  shape = {
    width = 1,
    height = 1,
    type = "full",
  },
  energy_source = {
    type = "electric",
    usage_priority = "primary-output",
  },
  power = "35kW",
  categories = { "armor" },
}

data:extend({ rtg })
