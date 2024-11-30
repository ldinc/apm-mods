require 'util'
require('lib.log')

if not apm.lib.utils.technology.unit then apm.lib.utils.technology.unit = {} end
if not apm.lib.utils.technology.unit.set then apm.lib.utils.technology.unit.set = {} end

--- Construct new unit for technology
---@param ingredients string[]
---@param count uint64
---@param time double
---@param formula? data.MathExpression
---@return data.TechnologyUnit
function apm.lib.utils.technology.unit.new(ingredients, count, time, formula)
	---@type data.TechnologyUnit[]
	local list = {}

	for _, value in ipairs(ingredients) do
		table.insert(list, { value, 1 })
	end

	---@type data.TechnologyUnit
	local unit = {
		ingredients = list,
		count = count,
		count_formula = formula,
		time = time,
	}

	return unit
end

--- Delete all research units
---@param technology_name string
function apm.lib.utils.technology.unit.clear_all(technology_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	technology.unit = nil
end

--- Delete all research units
---@param technology data.TechnologyPrototype
function apm.lib.utils.technology.unit.clear_all_by_ref(technology)
	if technology then
		technology.unit = nil
	end
end
