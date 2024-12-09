if not apm.lib.utils.technology then apm.lib.utils.technology = {} end
if not apm.lib.utils.technology.find then apm.lib.utils.technology.find = {} end

--- [technology.find.technology_by_recipe]
---@param recipe_name string
---@return string?
function apm.lib.utils.technology.find.technology_by_recipe(recipe_name)
	for technology_name, _ in pairs(data.raw.technology) do
		if apm.lib.utils.technology.check_if_recipe_is_in_unlock(technology_name, recipe_name) then
			return technology_name
		end
	end

	return nil
end

--- [technology.new]
--- Adding new technology to game
---@param mod_name string
---@param technology string
---@param t_prerequisites data.TechnologyID[]
---@param t_recipes string[]
---@param t_trigger? data.TechnologyTrigger
---@param t_unit?  data.TechnologyUnit
---@paran t_icon? string
---@param t_icon_size? uint64
---@param t_is_essential? boolean
function apm.lib.utils.technology.new(
		mod_name,
		technology,
		t_prerequisites,
		t_recipes,
		t_trigger,
		t_unit,
		t_icon,
		t_icon_size,
		t_is_essential
)
	if not mod_name then
		mod_name = "undefined_mod_name"
	end

	if not t_is_essential then
		t_is_essential = true
	end

	if not t_icon then
		t_icon = "__apm_resource_pack_ldinc__/graphics/technologies/" .. technology .. ".png"
	end

	if not t_icon_size then
		t_icon_size = 128
	end

	if not t_unit and not t_trigger then
		log(APM_MSG_ERROR("apm.lib.utils.technology.new", "technology '" .. technology .. "' without any trigger or units"))

		return
	end

	if t_unit then
		t_trigger = nil
	end

	local effects = {}

	for _, name in ipairs(t_recipes) do
		table.insert(effects, { type = 'unlock-recipe', recipe = name })
	end

	---@type data.TechnologyPrototype
	local new = {
		type = "technology",
		name = technology,
		icon = t_icon,
		icon_size = t_icon_size,
		prerequisites = t_prerequisites,
		effects = effects,
		essential = t_is_essential,
		unit = t_unit,
		research_trigger = t_trigger,
		order = "a-a-a",
	}

	data:extend({ new })

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('new()', 'create new technology: "' .. tostring(new.name) .. '"'))
	end
end

--- [technology.mod.unit_time]
---@param technology_name string
---@param time number
function apm.lib.utils.technology.mod.unit_time(technology_name, time)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok or not technology.unit then
		return
	end

	technology.unit.time = time

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'mod.unit_time()',
			'for: "' .. tostring(technology_name) .. '" set unit_time to: "' .. tostring(time) .. '"'
		))
	end
end

--- [technology.mod.unit_count]
---@param technology_name string
---@param count integer
function apm.lib.utils.technology.mod.unit_count(technology_name, count)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok or not technology.unit then
		return
	end

	technology.unit.count = count

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'mod.unit_count()',
			'for: "' .. tostring(technology_name) .. '" set unit_count to: "' .. tostring(count) .. '"'
		))
	end
end

--- [technology.mod.order]
---@param technology_name string
---@param order string
function apm.lib.utils.technology.mod.order(technology_name, order)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	technology.order = order

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('mod.order()', 'for: "' .. tostring(technology_name) .. '" set order: "' .. tostring(order) .. '"'))
	end
end

--- [technology.mod.icon]
---@param technology_name string
---@param icon any
function apm.lib.utils.technology.mod.icon(technology_name, icon)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	technology.icon = icon

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'mod.icon()', 'for: "' .. tostring(technology_name) .. '" set icon: "' .. tostring(icon) .. '"'
		))
	end
end

--- [technology.disable]
---@param technology_name string
function apm.lib.utils.technology.disable(technology_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	technology.enabled = false
	technology.hidden = true
	technology.hidden_in_factoriopedia = true

	if apm.lib.utils.technology.trigger.get(technology_name) then
		apm.lib.utils.technology.trigger.remove(technology_name, true)
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('disable()', 'set: enabled = false for:"' .. tostring(technology_name) .. '"'))
	end
end

--- [technology.delete]
---@param technology_name string
function apm.lib.utils.technology.delete(technology_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('delete()', 'technology: "' .. tostring(technology_name) .. '"'))
	end

	technology.enabled = false
	technology.hidden = true
	technology.hidden_in_factoriopedia = true

	technology.prerequisites = {}

	-- let us find who is linked to this technology and remove the prerequisites
	for technology, _ in pairs(data.raw.technology) do
		if technology ~= technology_name then
			if apm.lib.utils.technology.has.prerequisites(technology, technology_name) then
				apm.lib.utils.technology.remove.prerequisites(technology, technology_name)
			end
		end
	end

	if apm.lib.utils.technology.trigger.get(technology_name) then
		apm.lib.utils.technology.trigger.remove(technology_name, true)
	end
end

--- [technology.overwrite.localised_name]
---@param technology_name string
---@param localised_name string
function apm.lib.utils.technology.overwrite.localised_name(technology_name, localised_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	technology.localised_name = localised_name
end

--- [technology.overwrite.localised_description]
---@param technology_name string
---@param localised_description string
function apm.lib.utils.technology.overwrite.localised_description(technology_name, localised_description)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	technology.localised_description = localised_description
end