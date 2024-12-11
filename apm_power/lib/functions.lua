require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/lib/functions.lua'

APM_LOG_HEADER(self)

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
--- [apm.power.machine_frame_addition]
---@param recipe_name string
---@param level_in number
---@param level_out number?
---@param amount_in number
---@param amount_out number?
---@param ov boolean?
function apm.power.machine_frame_addition(recipe_name, level_in, level_out, amount_in, amount_out, ov)
	if not apm.lib.utils.setting.get.starup('apm_power_overhaul_machine_frames') and not ov then return end

	local frame_in = {
		[1] = 'apm_machine_frame_basic',
		[2] = 'apm_machine_frame_steam',
		[3] = 'apm_machine_frame_advanced'
	}
	local frame_out = {
		[1] = 'apm_machine_frame_basic_used',
		[2] = 'apm_machine_frame_steam_used',
		[3] = 'apm_machine_frame_advanced_used'
	}

	-- apm.lib.utils.recipe.ingredient.mod(recipe_name, frame_in[level_in], amount_in, amount_in+2)

	apm.lib.utils.recipe.ingredient.mod(recipe_name, frame_in[level_in], amount_in)

	local used_flag = apm.lib.utils.setting.get.starup('apm_power_machine_frames_recycling')

	if amount_out and used_flag then
		apm.lib.utils.recipe.result.mod(recipe_name, frame_out[level_out], amount_out)
	end
end

---@param recipe data.RecipePrototype
---@return string
---@return number
---@return boolean
local function find_frames_type_and_count(recipe)
	local try_get_count = apm.lib.utils.recipe.ingredient.get.count_by_ref

	for _, ingredient in ipairs(recipe.ingredients) do
		if ingredient.name ~= "apm_machine_frame_basic" and
			ingredient.name ~= "apm_machine_frame_steam" and
			ingredient.name ~= "apm_machine_frame_advanced"
		then
			local ingredient_recipe, ok = apm.lib.utils.recipe.get.by_name(ingredient.name)


			if ok then
				local count, ok = try_get_count(ingredient_recipe, "apm_machine_frame_basic")

				if ok then
					return "apm_machine_frame_basic", count, true
				end

				count, ok = try_get_count(ingredient_recipe, "apm_machine_frame_steam")

				if ok then
					return "apm_machine_frame_steam", count, true
				end

				count, ok = try_get_count(ingredient_recipe, "apm_machine_frame_advanced")

				if ok then
					return "apm_machine_frame_advanced", count, true
				end
			end
		end
	end

	return "", 0, false
end

--- [try_set_frames_to_recipe]
---@param target string
function apm.power.try_set_frames_to_recipe_results(target)
	local target_recipe, ok = apm.lib.utils.recipe.get.by_name(target)

	if not ok then
		return
	end

	local frame_name, count, ok = find_frames_type_and_count(target_recipe)

	if not ok then
		return
	end

	local used_frame = frame_name .. "_used"

	apm.lib.utils.recipe.result.mod(target, used_frame, count)
end
