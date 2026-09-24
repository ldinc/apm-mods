require("util")
require("lib.log")

local self = "lib.utils.tips"

if not apm.lib.utils.tips then apm.lib.utils.tips = {} end

--- [tips.add]
---@param tip TipsAndTricksItem
---@param requires table<string, string[]>? prototype type -> names, e.g. { recipe = { "apm_sinkhole" } }
---@return boolean added
function apm.lib.utils.tips.add(tip, requires)
	for prototype_type, names in pairs(requires or {}) do
		for _, name in pairs(names) do
			if not (data.raw[prototype_type] and data.raw[prototype_type][name]) then
				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						"tips.add()",
						'tip "' .. tostring(tip.name) .. '" skipped: ' .. prototype_type .. ' "' .. name .. '" does not exist'
					))
				end

				return false
			end
		end
	end

	data:extend({ tip })

	return true
end

--- [tips.simulation]
--- A simulation definition. Built here (with a typed return) instead of as a table literal at
--- each tip: LuaLS reports every optional SimulationDefinition field missing from a literal.
---@param init_file string
---@param mods string[]? mods whose runtime scripts run in the simulation
---@param extra table? more SimulationDefinition fields, e.g. { hide_health_bars = false }
---@return SimulationDefinition
function apm.lib.utils.tips.simulation(init_file, mods, extra)
	local simulation = { init_file = init_file, mods = mods }

	for key, value in pairs(extra or {}) do
		simulation[key] = value
	end

	return simulation
end

--- [tips.unlock_trigger]
--- A trigger that fires when the recipe is unlocked.
---@param recipe_name string
---@return UnlockRecipeTipTrigger
function apm.lib.utils.tips.unlock_trigger(recipe_name)
	return { type = "unlock-recipe", recipe = recipe_name }
end
