require "util"
require("lib.log")

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
			pipe_connections = {
				{
					flow_direction = "input",
					---@diagnostic disable-next-line: assign-type-mismatch
					direction = defines.direction.east,
					position = { 1, 0 }
				}
			},
			secondary_draw_orders = { north = -1 },
		},
		{
			production_type = "output",
			pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
			pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
			volume = 1000,
			pipe_connections = {
				{
					flow_direction = "output",
					---@diagnostic disable-next-line: assign-type-mismatch
					direction = defines.direction.west,
					position = { -1, 0 }
				}
			},
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

	-- Read from vanilla so sprite dimensions track Wube's asset changes automatically.
	-- Hardcoding width/height here breaks any time Space Age reshapes its frozen pipe sprites
	-- (which happened in 2.1: east sprite went from 42x76 to 32x62, etc.).
	local source = data.raw["assembling-machine"] and data.raw["assembling-machine"]["assembling-machine-2"]
	if source and source.fluid_boxes then
		for _, fb in pairs(source.fluid_boxes) do
			if fb.pipe_picture_frozen then
				return table.deepcopy(fb.pipe_picture_frozen)
			end
		end
	end

	-- Fallback: try the chemical plant if assembling-machine-2 isn't available for some reason
	local chem = data.raw["assembling-machine"] and data.raw["assembling-machine"]["chemical-plant"]
	if chem and chem.fluid_boxes then
		for _, fb in pairs(chem.fluid_boxes) do
			if fb.pipe_picture_frozen then
				return table.deepcopy(fb.pipe_picture_frozen)
			end
		end
	end

	-- Nothing to copy from — return nil. Callers should be prepared for this.
	return nil
end
