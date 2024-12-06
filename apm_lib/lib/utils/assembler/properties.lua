require 'util'
require('lib.log')

if apm.lib.utils.assembler.burner == nil then apm.lib.utils.assembler.burner = {} end

--- [assembler.update_description]
---@param assembler_name string
function apm.lib.utils.assembler.update_description(assembler_name)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	if not assembler.energy_source then return end

	local fuel_categories = apm.lib.utils.assembler.get.fuel_categories(assembler_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(assembler, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(assembler, fuel_categories)
	end
end

--- [assembler.mod.category.add]
---@param assembler_name string
---@param category data.RecipeCategoryID
function apm.lib.utils.assembler.mod.category.add(assembler_name, category)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	apm.lib.utils.entity.add.crafting_category(assembler, category)
end

--- [assembler.mod.crafting_speed]
---@param assembler_name any
---@param value any
function apm.lib.utils.assembler.mod.crafting_speed(assembler_name, value)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	assembler.crafting_speed = value
end

--- [assembler.mod.module_specification]
---@param assembler_name string
---@param value integer?
---@param allowed_effects data.EffectTypeLimitation?
function apm.lib.utils.assembler.mod.module_specification(assembler_name, value, allowed_effects)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	local default_allowed_effects = { "consumption", "speed", "productivity", "pollution" }

	assembler.module_slots = value

	if not assembler.allowed_effects and not allowed_effects then
		assembler.allowed_effects = default_allowed_effects
	elseif allowed_effects then
		assembler.allowed_effects = allowed_effects
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'mod.module_specification()',
			'changed module_specification for: "' .. tostring(assembler_name) .. '"'
		))
	end
end

--- [assembler.set.hidden]
---@param assembler_name string
function apm.lib.utils.assembler.set.hidden(assembler_name)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	assembler.hidden = true
end

--- Append crafting categoty without duplicates
---@param assembler_name string
---@param crafting_categories string[]
function apm.lib.utils.assembler.add.crafting_categories(assembler_name, crafting_categories)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	if not assembler.crafting_categories then
		assembler.crafting_categories = {}
	end

	for _, crafting_category in ipairs(crafting_categories) do
		if not apm.lib.utils.category.exists(crafting_category, assembler.crafting_categories) then
			table.insert(assembler.crafting_categories, crafting_category)
		end
	end
end
