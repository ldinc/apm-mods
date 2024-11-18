require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/waste.lua"

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
    type = "item",
    name = "apm_radioactive_waste",
    icons = {
        apm.nuclear.icons.waste_radioactive
    },
    stack_size = 2000,
    subgroup = "apm_nuclear_waste_products",
    order = "ac_b",
}

data:extend({ item })
