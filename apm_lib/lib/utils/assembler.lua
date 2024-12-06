require 'util'
require('lib.log')

local self = 'lib.utils.assembler'

if apm.lib.utils.assembler.add == nil then apm.lib.utils.assembler.add = {} end
if apm.lib.utils.assembler.mod == nil then apm.lib.utils.assembler.mod = {} end
if apm.lib.utils.assembler.mod.category == nil then apm.lib.utils.assembler.mod.category = {} end
if apm.lib.utils.assembler.burner == nil then apm.lib.utils.assembler.burner = {} end
if apm.lib.utils.assembler.centrifuge == nil then apm.lib.utils.assembler.centrifuge = {} end
if apm.lib.utils.assembler.get == nil then apm.lib.utils.assembler.get = {} end
if apm.lib.utils.assembler.set == nil then apm.lib.utils.assembler.set = {} end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.assembler.exist(assembler_name)
	if data.raw['assembling-machine'][assembler_name] then
		return true
	end
	APM_LOG_WARN(self, 'exist()', 'assembler with name: "' .. tostring(assembler_name) .. '" dosent exist.')
	return false
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.assembler.update_description(assembler_name)
	if not apm.lib.utils.assembler.exist(assembler_name) then return end
	local assembler = data.raw['assembling-machine'][assembler_name]

	if not assembler.energy_source then return end

	local fuel_categories = apm.lib.utils.assembler.get.fuel_categories(assembler_name)
	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(assembler, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(assembler, fuel_categories)
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.assembler.mod.category.add(assembler_name, category)
	if not apm.lib.utils.assembler.exist(assembler_name) then return end

	local assembler = data.raw['assembling-machine'][assembler_name]
	apm.lib.utils.entity.add.crafting_category(assembler, category)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.assembler.mod.crafting_speed(assembler_name, value)
	if not apm.lib.utils.assembler.exist(assembler_name) then return end

	local assembler = data.raw['assembling-machine'][assembler_name]
	assembler.crafting_speed = value
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.assembler.mod.module_specification(assembler_name, value, allowed_effects)
	if not apm.lib.utils.assembler.exist(assembler_name) then return end

	local default_allowed_effects = { "consumption", "speed", "productivity", "pollution" }

	local assembler = data.raw['assembling-machine'][assembler_name]

	assembler.module_slots = value

	if not assembler.allowed_effects and not allowed_effects then
		assembler.allowed_effects = default_allowed_effects
	elseif allowed_effects then
		assembler.allowed_effects = allowed_effects
	end
	APM_LOG_INFO(self, 'mod.module_specification()',
		'changed module_specification for: "' .. tostring(assembler_name) .. '"')
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.assembler.add.fluid_connections(assembler_name, level)
	if not apm.lib.utils.assembler.exist(assembler_name) then return end

	local assembler = data.raw['assembling-machine'][assembler_name]
	local pipe_picture

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
			production_type = "output",
			pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
			pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
			volume = 1000,
			pipe_connections = { { flow_direction = "input", direction = defines.direction.east, position = { 1, 0 } } },
			secondary_draw_orders = { north = -1 },
		},
		{
			production_type = "input",
			pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
			pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
			volume = 1000,
			pipe_connections = { { flow_direction = "output", direction = defines.direction.west, position = { -1, 0 } } },
			secondary_draw_orders = { north = -1 },
		},
	}

	assembler.fluid_boxes_off_when_no_fluid_recipe = true
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.assembler.set.hidden(assembler_name)
	if not apm.lib.utils.assembler.exist(assembler_name) then return end

	local assembler = data.raw['assembling-machine'][assembler_name]

	assembler.hidden = true
end

--- Append crafting categoty without duplicates
---@param assembler_name string
---@param crafting_categories string[]
function apm.lib.utils.assembler.add.crafting_categories(assembler_name, crafting_categories)
	if not apm.lib.utils.assembler.exist(assembler_name) then return end

	local assembler = data.raw['assembling-machine'][assembler_name]

	if not assembler.crafting_categories then
		assembler.crafting_categories = {}
	end

	for _, crafting_category in ipairs(crafting_categories) do
		if not apm.lib.utils.category.exists(crafting_category, assembler.crafting_categories) then
			table.insert(assembler.crafting_categories, crafting_category)
		end
	end
end

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
