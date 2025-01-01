require 'util'
require('lib.log')

if apm.lib.utils.assembler.add == nil then apm.lib.utils.assembler.add = {} end

---@param assembler_name string
---@param level number
function apm.lib.utils.assembler.add.fluid_connections(assembler_name, level)
	local assembler, ok = apm.lib.utils.assembler.get.by_name(assembler_name)

	if not ok then
		return
	end

	---@type (data.Sprite | data.Sprite4Way)?
	local pipe_picture = nil

	if level == 1 then
		pipe_picture = apm.lib.utils.pipecovers.assembler1pipepictures()
	elseif level == 2 then
		pipe_picture = assembler2pipepictures()
	elseif level == 3 then
		pipe_picture = assembler3pipepictures()
	elseif level == 4 then
		pipe_picture = apm.lib.utils.pipecovers.assembler4pipepictures()
	else
		return
	end

	assembler.fluid_boxes = {
		{
			production_type = "input",
			pipe_picture = pipe_picture,
			pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
			volume = 1000,
			pipe_connections = { { flow_direction = "input", direction = defines.direction.east, position = { 1, 0 } } },
			secondary_draw_orders = { north = -1 },
		},
		{
			production_type = "output",
			pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
			pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
			volume = 1000,
			pipe_connections = { { flow_direction = "output", direction = defines.direction.west, position = { -1, 0 } } },
			secondary_draw_orders = { north = -1 },
		},
	}

	assembler.fluid_boxes_off_when_no_fluid_recipe = true
end

---@return (data.Sprite | data.Sprite4Way)?
function apm.lib.utils.assembler.pipe_picture_frozen()
	if not mods["space-age"] then
		return {}
	end

	return
	{
		north =
		{
			filename = "__space-age__/graphics/entity/frozen/assembling-machine/assembling-machine-pipe-N-frozen.png",
			priority = "extra-high",
			width = 71,
			height = 38,
			shift = util.by_pixel(2.25, 13.5),
			scale = 0.5
		},
		east =
		{
			filename = "__space-age__/graphics/entity/frozen/assembling-machine/assembling-machine-pipe-E-frozen.png",
			priority = "extra-high",
			width = 42,
			height = 76,
			shift = util.by_pixel(-24.5, 1),
			scale = 0.5
		},
		south =
		{
			filename = "__space-age__/graphics/entity/frozen/assembling-machine/assembling-machine-pipe-S-frozen.png",
			priority = "extra-high",
			width = 88,
			height = 61,
			shift = util.by_pixel(0, -31.25),
			scale = 0.5
		},
		west =
		{
			filename = "__space-age__/graphics/entity/frozen/assembling-machine/assembling-machine-pipe-W-frozen.png",
			priority = "extra-high",
			width = 39,
			height = 73,
			shift = util.by_pixel(25.75, 1.25),
			scale = 0.5
		}
	}
end
