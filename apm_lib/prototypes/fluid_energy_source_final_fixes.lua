---@param fluid FluidPrototype
---@return number lowest, number highest
local function range_of(fluid)
	local lowest = fluid.default_temperature
	local highest = fluid.max_temperature or lowest

	return lowest, highest
end

---@param source table FluidEnergySource
---@param fluid FluidPrototype
---@param where string for the log
local function fit(source, fluid, where)
	local lowest, highest = range_of(fluid)
	local max_t = source.maximum_input_temperature

	if max_t and max_t > highest then
		source.maximum_input_temperature = highest
		log("apm: " .. where .. ": maximum_input_temperature " .. max_t .. " -> " .. highest ..
			" (" .. fluid.name .. " max_temperature)")
	end

	local min_t = source.minimum_input_temperature

	if min_t and min_t < lowest then
		source.minimum_input_temperature = lowest
	end

	min_t = source.minimum_input_temperature

	if min_t and min_t > highest then
		source.minimum_input_temperature = highest
	end
end

for type_name, prototypes in pairs(data.raw) do
	for name, prototype in pairs(prototypes) do
		local source = type(prototype) == "table" and prototype.energy_source or nil

		if type(source) == "table" and source.type == "fluid" and source.fluid_box and source.fluid_box.filter then
			---@cast source table
			local fluid = data.raw.fluid[source.fluid_box.filter]

			if fluid then
				fit(source, fluid, type_name .. "/" .. name)
			end
		end
	end
end
