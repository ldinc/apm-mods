require('util')
require('lib.log')

local self = 'apm_lib/prototypes/sounds/radiation.lua'

APM_LOG_HEADER(self)

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ExplosionPrototype
local sound = {
  animations = {},
}
sound.type = "explosion"
sound.name = "radioactive_a_1"
sound.flags = {"not-on-map"}
sound.hidden_in_factoriopedia = true

sound.animations[1] = {}
sound.animations[1].filename = "__apm_lib_ldinc__/graphics/null.png"
sound.animations[1].priority = "low"
sound.animations[1].width = 32
sound.animations[1].height = 32
sound.animations[1].frame_count = 1
sound.animations[1].line_length = 1
sound.animations[1].animation_speed = 1
sound.light = {intensity = 0, size = 0}
sound.sound = {
  {
    filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_a_1.ogg",
    volume = 0.9,
  },
}

data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "radioactive_a_2"
sound.sound[1].filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_a_2.ogg"
data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "radioactive_a_3"
sound.sound[1].filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_a_3.ogg"
data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "radioactive_b_1"
sound.sound[1].filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_b_1.ogg"
data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "radioactive_b_2"
sound.sound[1].filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_b_2.ogg"
data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "radioactive_b_3"
sound.sound[1].filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_b_3.ogg"
data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "radioactive_c_1"
sound.sound[1].filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_c_1.ogg"
data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "radioactive_c_2"
sound.sound[1].filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_c_2.ogg"
data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "radioactive_c_3"
sound.sound[1].filename = "__apm_lib_ldinc__/sounds/radiation/radioactive_c_3.ogg"
data:extend({sound})