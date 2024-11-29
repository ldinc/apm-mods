require 'util'
require('lib.log')

local self = 'lib.utils.modules'

if apm.lib.utils.modules.create == nil then apm.lib.utils.modules.create = {} end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.modules.exist(module_name)
	if data.raw.module[module_name] then
		return true
	end
	APM_LOG_WARN(self, 'exist()', 'module: "' .. tostring(module_name) .. '" dosent exist.')
	return false
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.modules.has_productivity(module_name)
	if not apm.lib.utils.modules.exist(module_name) then return false end

	local p_module = data.raw.module[module_name]

	return apm.lib.utils.modules.has_productivity_ref(p_module)
end

--- Check if moduele has productivity effect
---@param module data.ModulePrototype
---@return boolean
function apm.lib.utils.modules.has_productivity_ref(module)
	if not module then
		return false
	end

	if module.effect then
		if module.effect.productivity then
			return true
		end
	end

	return false
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---TODO: Seems to be removed with 2.0 - limitation has been moved to recipe prototype

---@param recipe_name string
function apm.lib.utils.modules.remove_recipe_from_limitations(recipe_name)
	APM_LOG_INFO(self, "remove_recipe_from_limitations", "pls remove code for 2.0")
	-- if not apm.lib.utils.recipe.exist(recipe_name) then return end

	-- for _, mod in pairs(data.raw['module']) do
	-- 	if mod.limitation then
	-- 		for i, limit in pairs(mod.limitation) do
	-- 			if limit == recipe_name then
	-- 				table.remove(mod.limitation, i)
	-- 				APM_LOG_INFO(self, 'remove_recipe_from_limitations()',
	-- 					'recipe with name: "' ..
	-- 					tostring(recipe_name) .. '" from limitations of "' .. tostring(mod.name) .. '" removed.')
	-- 			end
	-- 		end
	-- 	end
	-- end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.modules.create.category(category_name)
	local module_category = {}

	module_category.type = "module-category"
	module_category.name = category_name

	data:extend({ module_category })

	APM_LOG_INFO(self, 'create.category()', 'created category with name: "' .. tostring(category_name) .. '"')
end
