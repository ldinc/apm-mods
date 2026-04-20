require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/items/ore.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_meteorite_ore'
item.icons = {
    {icon=apm.starfall.icons.meteorite_ore.filename, icon_size=apm.starfall.icons.meteorite_ore.icon_size, tint=apm.starfall.icons.meteorite_ore.tint}
}
item.icon_mipmaps = apm.starfall.icons.meteorite_ore.icon_mipmaps
item.pictures = {
      apm.starfall.icons.meteorite_ore,
      apm.starfall.icons.meteorite_ore_1,
      apm.starfall.icons.meteorite_ore_2,
      apm.starfall.icons.meteorite_ore_3
}
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_ore"
item.order = 'aa_a'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_meteorite_crushed'
item.icons = {
        apm.starfall.icons.ore_crushed
    }
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_ore"
item.order = 'ab_a'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_metal_catalyst_frame'
item.icons = {
        apm.starfall.icons.metal_catalyst_frame
    }
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_catalysts"
item.order = 'aa_a'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_metal_catalyst_frame_used'
item.icons = {
        apm.starfall.icons.metal_catalyst_frame_used
    }
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_catalysts"
item.order = 'ad_a'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_metal_catalyst_iron'
item.icons = {
        apm.starfall.icons.metal_catalyst_frame,
        apm.starfall.icons.metal_catalyst_iron
    }
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_catalysts"
item.order = 'ab_a'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_metal_catalyst_copper'
item.icons = {
        apm.starfall.icons.metal_catalyst_frame,
        apm.starfall.icons.metal_catalyst_copper
    }
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_catalysts"
item.order = 'ac_a'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_starfall_target_marker'
item.icons = {
    apm.starfall.icons.target_marker
}
item.flags = {"hidden"}
item.stack_size = 1
item.group = "apm_starfall"
item.subgroup = "apm_starfall_other"
item.order = 'aa_a'
data:extend({item})
