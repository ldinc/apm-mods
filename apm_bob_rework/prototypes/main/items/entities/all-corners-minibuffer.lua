require('util')
local graphics = require('lib.entities.graphics')

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'minibuffer-allcorners'
item.icons = {
    graphics.enitity.minibuffer.allcorners.icon,
}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "storage"
item.order = 'ad_a'
item.place_result = "minibuffer-allcorners"
data:extend({item})