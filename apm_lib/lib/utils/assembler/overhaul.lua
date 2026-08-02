require "util"
require("lib.log")

if apm.lib.utils.assembler.burner == nil then apm.lib.utils.assembler.burner = {} end
if apm.lib.utils.assembler.centrifuge == nil then apm.lib.utils.assembler.centrifuge = {} end

---@param assembler_name string
---@param only_refined boolean?
function apm.lib.utils.assembler.burner.overhaul(assembler_name, only_refined)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	if assembler.energy_source.type == "burner" then
		assembler.energy_source.burnt_inventory_size = 1
		-- assembler.energy_source.effectivity = 0.42
		if only_refined then
			apm.lib.utils.entity.set.fuel_category(assembler, "apm_refined_chemical")
		else
			apm.lib.utils.entity.set.fuel_category(assembler, { "chemical", "apm_refined_chemical" })
		end

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"assembler.burner.overhaul()",
				'assembler with name: "' .. assembler_name .. '" changed'
			))
		end

		return
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			"assembler.burner.overhaul()",
			'assembler with name: "' .. tostring(assembler_name) .. '" has not energy_source.type = "burner"'
		))
	end
end

---@param centrifuge_name string
---@param level number
function apm.lib.utils.assembler.centrifuge.overhaul(centrifuge_name, level)
	local centrifuge, ok = apm.lib.utils.assembler.get.by_name(centrifuge_name)

	if not ok then
		return
	end

	centrifuge.flags = { "placeable-neutral", "placeable-player", "player-creation" }

	centrifuge.fluid_boxes = {
		apm.lib.utils.builders.fluid_box.new(
			"input",
			1000,
			apm.lib.utils.pipecovers.nuclear_centrifuge_pipepictures(),
			defines.direction.north,
			{ 0, -1 }
		),
		apm.lib.utils.builders.fluid_box.new(
			"output",
			1000,
			apm.lib.utils.pipecovers.nuclear_centrifuge_pipepictures(),
			defines.direction.south,
			{ -1, 1 }
		),
		apm.lib.utils.builders.fluid_box.new(
			"output",
			1000,
			apm.lib.utils.pipecovers.nuclear_centrifuge_pipepictures(),
			defines.direction.south,
			{ 1, 1 }
		),
	}

	local idle_animation = centrifuge.graphics_set and centrifuge.graphics_set.idle_animation

	if idle_animation and idle_animation.layers then
		---@cast idle_animation Animation
		local south_animation = table.deepcopy(idle_animation)

		south_animation.layers[1] = {
			filename = "__apm_resource_pack_ldinc__/graphics/entities/nuclear_centrifuge/centrifuge-ABC-integration-S.png",
			priority = "high",
			width = 246,
			height = 250,
			shift = util.by_pixel(0.5, 3.0),
			line_length = 1,
			scale = 0.5,
			frame_count = 1,
			repeat_count = 64,
		}

		-- extra shadow for the custom south integration sprite
		table.insert(south_animation.layers, 2, {
			filename = "__apm_resource_pack_ldinc__/graphics/entities/nuclear_centrifuge/centrifuge-ABC-integration-S-shadow.png",
			priority = "high",
			width = 246,
			height = 250,
			shift = util.by_pixel(0.5, 3.0),
			line_length = 1,
			scale = 0.5,
			frame_count = 1,
			repeat_count = 64,
			draw_as_shadow = true,
		})

		centrifuge.graphics_set.idle_animation = {
			north = idle_animation,
			east = idle_animation,
			south = south_animation,
			west = idle_animation,
		}
	end

	centrifuge.fast_replaceable_group = "centrifuge"
	centrifuge.allowed_effects = { "consumption", "speed", "pollution" }

	if mods["space-age"] then
		for _, fluid_box in ipairs(centrifuge.fluid_boxes) do
			fluid_box.pipe_picture_frozen = apm.lib.utils.assembler.pipe_picture_frozen()
		end
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"assembler.centrifuge.overhaul",
			'centrifuge with name: "' .. tostring(centrifuge_name) .. '" changed'
		))
	end
end
