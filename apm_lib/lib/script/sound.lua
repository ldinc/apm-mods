local sound = {}

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@param sound_name string
---@param character LuaPlayer
function sound.create_on_character_position(sound_name, character)
	character.surface.create_entity({ name = sound_name, position = character.position })
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
return sound
