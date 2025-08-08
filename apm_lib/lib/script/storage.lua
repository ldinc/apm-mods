local storage_script = {}

-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local core = require("lib.script.core")

-- Definitions ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type boolean
local apm_lib_storage_spit_out = false
local v = settings.global["apm_lib_storage_spit_out"].value
if type(v) == "boolean" then
	apm_lib_storage_spit_out = v
end

---@type boolean
local apm_lib_storage_spit_out_mark_deconstruct = false
v = settings.global["apm_lib_storage_spit_out_mark_deconstruct"].value

if type(v) == "boolean" then
	apm_lib_storage_spit_out_mark_deconstruct = v
end

local function get_config()
	v = settings.global["apm_lib_storage_spit_out"].value

	if type(v) == "boolean" then
		apm_lib_storage_spit_out = v
	end


	v = settings.global["apm_lib_storage_spit_out_mark_deconstruct"].value

	if type(v) == "boolean" then
		apm_lib_storage_spit_out_mark_deconstruct = v
	end
end

function storage_script.on_init()
	get_config()
end

function storage_script.on_load()
	get_config()
end

function storage_script.on_update()
	get_config()
end

---@param entity LuaEntity
---@return LuaForce|string|integer?
local function get_force(entity)
	local force = nil

	if apm_lib_storage_spit_out_mark_deconstruct then
		force = entity.force
	end

	return force
end

---@param entity LuaEntity
---@param cause LuaEntity?
local function container(entity, cause)
	if entity.valid ~= true then
		return
	end

	if entity.type ~= "container" then
		return
	end

	local inventory = entity.get_inventory(defines.inventory.chest)

	if inventory == nil then
		return
	end

	if inventory.is_empty() then
		return
	end


	local position = entity.position
	local entity_force = get_force(entity) -- will return nil if apm_lib_storage_spit_out_mark_deconstruct == false

	---@type LuaSurface.spill_inventory_param
	local param = {
		position = position,
		inventory = inventory,
		force = entity_force,
	}

	entity.surface.spill_inventory(param)

	if cause ~= nil then
		if cause.type == "character" or cause.type == "player" then
			local force = cause.player.force
			local player_name = cause.player.name
			local msg = { "apm_msg_storage_died", player_name }

			core.send_msg_to_force(force, msg)
		end
	end
end


---@param event EventData.on_entity_died
function storage_script.died(event)
	if not apm_lib_storage_spit_out then
		return
	end

	local entity = event.entity
	local cause = event.cause

	container(entity, cause)
end

return storage_script
