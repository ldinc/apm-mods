local name = "muluna-vacuum-heating-tower"
local fuel_categories = { "chemical", "apm_refined_chemical" }

local entity = apm.lib.utils.entity.get.by_name(name, "assembling-machine")

if entity then
	apm.lib.utils.entity.set.fuel_category(entity, fuel_categories)
end
