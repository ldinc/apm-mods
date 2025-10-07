require "util"
require("lib.log")

local self = "lib.utils.item"

if not apm.lib.utils.item.add then apm.lib.utils.item.add = {} end
if not apm.lib.utils.item.set then apm.lib.utils.item.set = {} end
if not apm.lib.utils.item.has then apm.lib.utils.item.has = {} end
if not apm.lib.utils.item.mod then apm.lib.utils.item.mod = {} end
if not apm.lib.utils.item.replace then apm.lib.utils.item.replace = {} end
if not apm.lib.utils.item.overwrite then apm.lib.utils.item.overwrite = {} end

--- [item.dummy]
---@return data.ItemPrototype
function apm.lib.utils.item.dummy()
	return { type = "item", name = "apm_dummy", amount = 1 }
end

local types_list = {
	"item",
	"fluid",
	"module",
	"capsule",
	"rail-planner",
	"ammo",
	"tool"
}

--- [item.get_types_list]
---@return string[]
function apm.lib.utils.item.get_types_list()
	return types_list
end

--- [item.exist]
---@param item_name string
---@return boolean
function apm.lib.utils.item.exist(item_name)
	local types_list = apm.lib.utils.item.get_types_list()

	for _, type_name in pairs(types_list) do
		if data.raw[type_name][item_name] then
			return true
		end
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('item/fluid/module with name: "' .. tostring(item_name) .. '" doesnt exist.'))
	end

	return false
end

--- [item.get_by_name]
---@param item_name string
---@param only_item boolean?
---@return any
---@return boolean
function apm.lib.utils.item.get_by_name(item_name, only_item)
	local types_list = apm.lib.utils.item.get_types_list()

	---? DOES WE NEED NOT USE ONLY data.raw.item ???

	if only_item then
		local item = data.raw["item"][item_name]

		if item then
			return item, true
		end

		return {}, false
	end

	for _, type_name in pairs(types_list) do
		local item = data.raw[type_name][item_name]

		if item then
			return item, true
		end
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING("exist()", 'item/fluid/module with name: "' .. tostring(item_name) .. '" doesnt exist.'))
	end

	return {}, false
end

--- [item.create_simple]
---@param module string
---@param item_name string
---@param item_sub_group string?
---@param item_order string?
function apm.lib.utils.item.create_simple(module, item_name, item_sub_group, item_order)
	--todo remove this function?

	---@type data.ItemPrototype
	local item = {
		type = "item",
		name = item_name,
		icon = "__" .. module .. "__/graphics/icons/" .. item_name .. ".png",
		--- maybe change to 64?
		icon_size = 32,
		subgroup = item_sub_group,
		order = item_order,
		stack_size = 50,
	}

	data:extend({ item })
end

--- [item.get_type]
---@param item_name string
---@param prefer_item boolean?
---@return string?
function apm.lib.utils.item.get_type(item_name, prefer_item)
	local types_list = apm.lib.utils.item.get_types_list()
	local result
	local count = 0

	for _, type_name in pairs(types_list) do
		if data.raw[type_name][item_name] then
			result = type_name
			count = count + 1

			if type_name ~= "item" and type_name ~= "fluid" then
				return "item"
			end
		end
	end

	if count > 1 then
		if prefer_item then
			result = "item"
		else
			result = "fluid"
		end

		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"get_type()",
				'found item and fluid with same name: "' .. tostring(item_name) .. '", return ' .. tostring(result)
			))
		end
	end

	if result then
		return result
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			"get_type()", 'item/fluid with name: "' .. tostring(item_name) .. '" doesnt exist, return nil'
		))
	end

	return nil
end

--- [item.add.radioactive_description]
---@param item_name string
---@param level number?
function apm.lib.utils.item.add.radioactive_description(item_name, level)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	local item = data.raw.item[item_name]

	local loc_string = "apm_radioactive_item"

	if level then
		loc_string = "apm_radioactive_item_" .. level
	end

	--- TODO: rework ... seems strange
	if item.localised_description then
		if type(item.localised_description) == "string" then
			local old = item.localised_description

			item.localised_description = { old }
		elseif type(item.localised_description) == "table" then
			if #item.localised_description > 0 and type(item.localised_description[1]) == string then
				table.insert(item.localised_description, loc_string)
			else
				table.insert(item.localised_description, { loc_string })
			end
		end
	else
		item.localised_description = { loc_string }
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"add.radioactive_description()",
			'add radioactive description to item: "' ..
			tostring(item_name) .. '" with level: "' .. tostring(level) .. '"'
		))
	end
end

--- [item.set.icons]
---@param item_name string
---@param icons any
function apm.lib.utils.item.set.icons(item_name, icons)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	apm.lib.utils.icon.set.icons(item, icons)
end

--- [item.is_type]
---@param item_name string
---@param item_type string
---@return boolean
function apm.lib.utils.item.is_type(item_name, item_type)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return false
	end

	if item.type == item_type then
		return true
	end

	return false
end

--- [item.mod.stack_size]
---@param item_name string
---@param value number
---@param b_overwrite boolean
function apm.lib.utils.item.mod.stack_size(item_name, value, b_overwrite)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	-- if not apm.lib.utils.item.is_type(item_name, 'item') then
	-- 	APM_LOG_WARN(self, 'mod.stack_size()', 'item: "' .. tostring(item_name) .. '" has not type="item" (its a fluid?)')

	-- 	return
	-- end

	if item.stack_size >= value and not b_overwrite then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"mod.stack_size()",
				'stack_size for item: "' ..
				tostring(item_name) ..
				'" is higer then "' .. tostring(value) .. '" and b_overwrite is not set, no changes'
			))
		end

		return
	end

	item.stack_size = value

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"mod.stack_size()", 'for item: "' .. tostring(item_name) .. '" to "' .. tostring(value) .. '"'
		))
	end
end

--- [item.delete_hard]
---@param item_name string
function apm.lib.utils.item.delete_hard(item_name)
	if not apm.lib.utils.item.exist(item_name) then return end

	data.raw.item[item_name] = nil

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"delete_hard()",
			'item/fluid with name: "' .. tostring(item_name) .. '" deleted hard (set to nil)'
		))
	end
end

---[item.remove]
---@param item_name string
function apm.lib.utils.item.remove(item_name)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		log(APM_MSG_ERROR("remove", "item '" .. item_name .. "' was not found to be removed."))

		return
	end

	item.hidden = true
	item.hidden_in_factoriopedia = true

	item.flags = { "hide-from-bonus-gui", "hide-from-fuel-tooltip" }

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO("remove()", 'item/fluid with name: "' .. tostring(item_name) .. '" set flag "hidden".'))
	end
end

--- [item.mod.remove_fuel_value]
---@param item_name string
function apm.lib.utils.item.mod.remove_fuel_value(item_name)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	item.fuel_category                = nil
	item.fuel_value                   = nil
	item.fuel_acceleration_multiplier = nil
	item.fuel_top_speed_multiplier    = nil
	item.fuel_emissions_multiplier    = nil

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"remove_fuel_value()",
			'item/fluid with name: "' .. tostring(item_name) .. '" set fuel related attributes to nil.'
		))
	end
end

--- [item.mod.fuel_category]
---@param item_name string
---@param fuel_category data.FuelCategoryID
function apm.lib.utils.item.mod.fuel_category(item_name, fuel_category)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	item.fuel_category = fuel_category

	if APM_LOG_INFO then
		log(APM_MSG_INFO(
			"mod.fuel_category()",
			'item/fluid with name: "' ..
			tostring(item_name) .. '" set fuel category to "' .. tostring(fuel_category) .. '"'
		))
	end
end

--- []
---@param item_name string
---@param burnt_result string
---@return boolean
function apm.lib.utils.item.has.burnt_result(item_name, burnt_result)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return false
	end

	if item.burnt_result == burnt_result then
		return true
	end

	return false
end

--- [item.replace.burnt_result]
---@param item_name string
---@param old_burnt_result string
---@param new_burnt_result string
function apm.lib.utils.item.replace.burnt_result(item_name, old_burnt_result, new_burnt_result)
	if not apm.lib.utils.item.exist(item_name) then return end

	if apm.lib.utils.item.has.burnt_result(item_name, old_burnt_result) then
		apm.lib.utils.item.mod.burnt_result(item_name, new_burnt_result)
	end
end

--- [item.replace.burnt_results]
---@param old_burnt_result string
---@param new_burnt_result string
function apm.lib.utils.item.replace.burnt_results(old_burnt_result, new_burnt_result)
	for _, item in pairs(data.raw.item) do
		if apm.lib.utils.item.has.burnt_result(item.name, old_burnt_result) then
			apm.lib.utils.item.mod.burnt_result(item.name, new_burnt_result)
		end
	end
end

--- [item.mod.burnt_result]
---@param item_name string
---@param burnt_result string
function apm.lib.utils.item.mod.burnt_result(item_name, burnt_result)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	if item.fuel_value then
		item.burnt_result = burnt_result

		local check_category = {
			["chemical"] = true,
			["apm_refined_chemical"] = true,
			["apm_petrol"] = true,
			["apm_vehicle_only"] = true
		}

		if check_category[item.fuel_category] then
			if burnt_result then
				item.localised_description = {
					"",
					{ "apm_info_burnt_result_0" },
					"\n",
					{
						"apm_info_fuel_tier",
						{ "fuel-category-name." .. tostring(item.fuel_category) },
					}
				}
			else
				item.localised_description = {
					"",
					{ "apm_info_burnt_result_1" },
					"\n",
					{
						"apm_info_fuel_tier",
						{ "fuel-category-name." .. tostring(item.fuel_category) }
					}
				}
			end
		end

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"mod.burnt_result()",
				'item/fluid with name: "' .. tostring(item_name) .. '" set burnt_result to: ' .. tostring(burnt_result)
			))
		end

		return
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			"mod.burnt_result()",
			'item/fluid with name: "' .. tostring(item_name) .. '" cant set burnt_result, has no fuel_value.'
		))
	end
end

--- [item.overwrite.localised_name]
---@param item_name string
---@param localised_name string
function apm.lib.utils.item.overwrite.localised_name(item_name, localised_name)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	item.localised_name = localised_name
end

--- [item.overwrite.localised_description]
---@param item_name string
---@param localised_description string
function apm.lib.utils.item.overwrite.localised_description(item_name, localised_description)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	item.localised_description = localised_description
end

--- [item.overwrite.battery]
---@param level number
---@param item_name string
---@param fuel_value data.Energy
---@param burnt_result string
function apm.lib.utils.item.overwrite.battery(level, item_name, fuel_value, burnt_result)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	local base_acceleration_multiplier = 1.0
	local base_top_speed_multiplier    = 1.0
	local new_acceleration_multiplier  = apm.lib.utils.math.round(base_acceleration_multiplier + (0.2 * level), 2)
	local new_top_speed_multiplier     = apm.lib.utils.math.round(base_top_speed_multiplier + (0.1 * level), 2)

	item.fuel_category                 = "apm_electrical"
	item.fuel_value                    = fuel_value
	item.fuel_acceleration_multiplier  = new_acceleration_multiplier
	item.fuel_top_speed_multiplier     = new_top_speed_multiplier
	item.burnt_result                  = burnt_result
	item.fuel_emissions_multiplier     = 0

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"overwrite.battery()", 'item with name: "' .. tostring(item_name) .. '" changed.'
		))
	end
end

-- Function -------------------------------------------------------------------
-- Todo lookup for 'item-with-entity-data' or make a new function?
--
-- ----------------------------------------------------------------------------

--- [item.overwrite.group]
---@param item_name string
---@param subgroup string?
---@param order string?
function apm.lib.utils.item.overwrite.group(item_name, subgroup, order)
	local item, ok = apm.lib.utils.item.get_by_name(item_name, true)

	if not ok then
		return
	end

	item.subgroup = subgroup
	item.order = order

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO("overwrite.group()", 'item with name: "' .. tostring(item_name) .. '" changed.'))
	end
end

--- [item.mod.overwrite_weight_for_science_packs]
---@param w data.Weight?
function apm.lib.utils.item.mod.overwrite_weight_for_science_packs(w)
	if w == nil or w <= 0 then
		w = apm.lib.utils.constants.value.weight.science_pack
	end

	for key, value in pairs(data.raw["tool"]) do
		if value ~= nil then
			data.raw["tool"][key].weight = w
		end
	end
end

--- [item.overwrite.weight]
---@param name string
---@param w data.Weight?
function apm.lib.utils.item.overwrite.weight(name, w)
	local item, ok = apm.lib.utils.item.get_by_name(name, true)

	if not ok then
		return
	end

	if w == nil then
		w = apm.lib.utils.constants.value.weight.default
	end

	item.weight = w
end
