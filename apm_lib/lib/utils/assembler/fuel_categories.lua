require 'util'
require('lib.log')

if apm.lib.utils.assembler.get == nil then apm.lib.utils.assembler.get = {} end

---@return data.FuelCategory
function apm.lib.utils.assembler.get.default_fuel_category()
	return { { name = "chemical", type = "fuel-category" } }
end

---@return data.FuelCategory
function apm.lib.utils.assembler.get.default_fluid_fuel_category()
	return { { name = "apm_petrol", type = "fuel-category" } }
end

---@param assembler_name string
---@return data.FuelCategory[]?
function apm.lib.utils.assembler.get.fuel_categories(assembler_name)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return nil
	end

	if not assembler.energy_source then
		return nil
	end

	if assembler.energy_source.type == "burner" then
		if assembler.energy_source.fuel_categories then
			---@type data.FuelCategory[]
			local categories = {}

			for _, category in pairs(assembler.energy_source.fuel_categories) do
				table.insert(categories, { name = category, type = "fuel-category" })
			end

			return categories
		end

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"assembler.get.fuel_categories",
				"set default \"burner\" for: " .. assembler_name
			))
		end

		return apm.lib.utils.assembler.get.default_fuel_category()
	end

	if assembler.energy_source.type == "fluid" then
		if assembler.energy_source.fluid_box.filter ~= nil then
			if assembler.energy_source.fluid_box.filter == 'steam' then
				return nil
			end

			return {
				{
					name = assembler.energy_source.fluid_box.filter,
					type = 'fluid',
				},
			}
		end

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"assembler.get.fuel_categories",
				"set default \"fluid\" for: " .. assembler_name
			))
		end

		return apm.lib.utils.assembler.get.default_fluid_fuel_category()
	end

	return nil
end

---@param assembler_name string
---@param category data.FuelCategoryID
function apm.lib.utils.assembler.burner.add_fuel_category(assembler_name, category)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	apm.lib.utils.entity.add.fuel_category(assembler, category)
end
