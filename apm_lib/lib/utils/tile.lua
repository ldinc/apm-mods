require 'util'
require('lib.log')

local self = 'lib.utils.tile'

if apm.lib.utils.tile.get == nil then apm.lib.utils.tile.get = {} end
if apm.lib.utils.tile.set == nil then apm.lib.utils.tile.set = {} end

--- [tile.exist]
---@param tile_name string
---@return boolean
function apm.lib.utils.tile.exist(tile_name)
	if data.raw.tile[tile_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'tile with name: "' .. tostring(tile_name) .. '" dosent exist.'))
	end

	return false
end

--- [tile.get.by_name]
---@param tile_name string
---@return data.TilePrototype
---@return boolean
function apm.lib.utils.tile.get.by_name(tile_name)
	local tile = data.raw.tile[tile_name]

	if tile then
		return tile, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'tile with name: "' .. tostring(tile_name) .. '" dosent exist.'))
	end

	return {}, false
end

--- [tile.get.layer]
---@param tile_name string
---@return integer?
function apm.lib.utils.tile.get.layer(tile_name)
	local tile, ok = apm.lib.utils.tile.get.by_name(tile_name)

	if not ok then
		return nil
	end

	return tile.layer
end

--- [tile.set.layer]
---@param tile_name string
---@param layer integer
function apm.lib.utils.tile.set.layer(tile_name, layer)
	local tile, ok = apm.lib.utils.tile.get.by_name(tile_name)

	if not ok then
		return
	end

	tile.layer = layer

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'set.layer()',
			'tile with name: "' .. tostring(tile_name) .. '" set to layer: "' .. tostring(layer) .. '"'
		))
	end
end

--- [tile.unification]
---@param old_tile_name string
---@param new_tile_name string
function apm.lib.utils.tile.unification(old_tile_name, new_tile_name)
	local old_tile, ok = apm.lib.utils.tile.get.by_name(old_tile_name)

	if not ok then
		return
	end

	if not apm.lib.utils.tile.exist(new_tile_name) then return end

	local old_minable = old_tile.minable

	if old_minable then
		local old_minable_item_name = old_minable.result

		if old_minable_item_name then
			if apm.lib.utils.item.exist(old_minable_item_name) then
				local item = data.raw.item[old_minable_item_name]
				---@type data.CollisionMaskConnector
				local cond = {
					layers = {
						water_tile = true
					},
				}

				item.place_as_tile = { result = new_tile_name, condition_size = 1, condition = cond }
			end
		end
	end


	local new_tile = data.raw.tile[new_tile_name]

	data.raw.tile[old_tile_name] = table.deepcopy(new_tile)
	data.raw.tile[old_tile_name].name = old_tile_name

	apm.lib.utils.tile.set.relation(old_tile_name, new_tile_name, 0)

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'unification()',
			'tile with name: "' .. tostring(old_tile_name) .. '" unification with: "' .. tostring(new_tile_name) .. '"'
		))
	end
end

--- [tile.set.relation]
---@param tile_name string
---@param base_tile_name string
---@param relation integer
function apm.lib.utils.tile.set.relation(tile_name, base_tile_name, relation)
	if not apm.lib.utils.tile.exist(tile_name) then
		return
	end

	if not apm.lib.utils.tile.exist(base_tile_name) then
		return
	end

	local base_layer = apm.lib.utils.tile.get.layer(base_tile_name)

	if not base_layer then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'set.layer()',
				'base_tile with name: "' .. tostring(tile_name) .. ' dosent have a layer attribute'
			))
		end
		return
	end

	local new_level = base_layer + relation

	apm.lib.utils.tile.set.layer(tile_name, new_level)
end
