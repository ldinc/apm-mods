require('util')
local graphics = require('lib.entities.graphics')

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item =   {
    type = "item",
    name = "burner-pumpjack",
    icon = graphics.enitity.pumpjack.burner.icon,
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "extraction-machine",
    order = "b[fluids]-b[pumpjack]",
    place_result = "burner-pumpjack",
    stack_size = 20
  }
data:extend({item})