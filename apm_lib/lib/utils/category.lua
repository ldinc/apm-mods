require 'util'
require('lib.log')

local self = 'lib.utils.category'

if not apm.lib.utils.category.create then apm.lib.utils.category.create = {} end

--- [category.create.group]
---@param name string
---@param icon string
---@param order string?
function apm.lib.utils.category.create.group(name, icon, order)
	name = tostring(name)
	icon = tostring(icon)
	order = tostring(order)

	---@type data.ItemGroup
	local new = {
		type = "item-group",
		name = name,
		icon = icon,
		icon_size = 64,
		order = order,
	}

	data:extend({ new })

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('create.group()', 'new category group created: "' .. tostring(name) .. '"'))
	end
end

--- [category.create.subgroup]
---@param group string
---@param subgroup string
---@param order string?
function apm.lib.utils.category.create.subgroup(group, subgroup, order)
	group = tostring(group)
	subgroup = tostring(subgroup)
	order = tostring(order)

	---@type data.ItemSubGroup
	local new = {
		type = 'item-subgroup',
		name = subgroup,
		group = group,
		order = order,
	}

	if data.raw['item-group'][group] == nil then
		return
	end

	data:extend({ new })

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'create.group()',
			'new subgroup created: "' .. tostring(subgroup) .. '" in group: "' .. tostring(group) .. '"'
		))
	end
end

---@return string[]
function apm.lib.utils.category.prototype_list()
	return { 'item', 'fluid', 'recipe', 'tool' }
end

--- NOTE: not used

--- [utils.category.change]
---@param group string
---@param subgroup string
---@param new_group string
---@param new_subgroup string
function apm.lib.utils.category.change(group, subgroup, new_group, new_subgroup)
	local prototypes = apm.lib.utils.category.prototype_list()

	for _, prototype in pairs(prototypes) do
		local object = data.raw[prototype][prototype]

		if object ~= nil then
			if object.group == group and object.subgroup == subgroup then
				object.group = new_group
				object.subgroup = new_subgroup

				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						'change()',
						'for "' ..
						tostring(prototype) ..
						'": "' ..
						tostring(object.name) ..
						'": group:"' ..
						tostring(group) ..
						'" -> "' ..
						tostring(new_group) ..
						'", subgroup:"' .. tostring(subgroup) .. '" -> "' .. tostring(new_subgroup) .. '"'
					))
				end
			end
		end
	end
end

--- Check is category in crafting categories exists
---@param category string
---@param categories string[]
---@return boolean
function apm.lib.utils.category.exists(category, categories)
	for _, candidate in ipairs(categories) do
		if candidate == category then
			return true
		end
	end

	return false
end
