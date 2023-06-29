local pipes = require "lib.entities.pipes"
local iconPath = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/krastorio/entities/"

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

local item_icon_a = apm.lib.utils.icon.get.from_item(pipes.under.iron)
local item_icon_b = {apm.lib.icons.dynamics.cooling}
local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})

local item = {}
item.type = 'item'
item.name = pipes.sinkhole.small
item.icons = icons
item.group = "apm_power"
item.subgroup = "apm_power_machines_3"
item.order = 'ad_a'
item.place_result = pipes.sinkhole.small
item.stack_size = 50
data:extend({item})
