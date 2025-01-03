if not apm.lib.features.power.compat.safthelamb then
	return
end


apm.lib.utils.assembler.add.fluid_connections("lumber-mill", 3)
local assembler, ok = apm.lib.utils.assembler.get.by_name("lumber-mill")

if not ok then
	return
end

assembler.fluid_boxes[1].pipe_connections[1].position = { 2.69, 0.5 }

if mods["aai-loaders"] and apm.lib.features.power.compat.earendel then
	local loader = "aai-wood-loader"



	local lubricant_enabled = settings.startup["aai-loaders-mode"].value == "lubricated"

	if lubricant_enabled then
		local loader_entity = data.raw["loader-1x1"][loader]

		--- update description
		local fpm = 0.05

		local localised_description = true and
				{ "entity-description.aai-loader-lubricated-shared", tostring(fpm), "lubricant" } or
				{ "entity-description.aai-loader-expensive-shared" }

		loader_entity.localised_description = localised_description

		--- hack to change lubricated recipe and entities
		local hidden_pipe = loader .. "-pipe"

		local entity = data.raw["storage-tank"][hidden_pipe]

		if entity then

			local function get_consumption()
				return math.ceil(math.max(0.1, fpm or 1) * 100) / 100
			end

			if entity.fluid_box then
				entity.fluid_box.filter = "lubricant"
				entity.fluid_box.volume = 100 + get_consumption()
			end
		end

		local item = data.raw["item"][loader]

		if item then
			item.localised_description = localised_description
		end

		local tech = data.raw["technology"][loader]

		if tech then
			tech.localised_description = localised_description
		end

	end
end
