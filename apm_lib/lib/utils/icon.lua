require "util"
require("lib.log")

local self = "lib.utils.icon"

if not apm.lib.utils.icons then apm.lib.utils.icons = {} end
if not apm.lib.utils.icon.get then apm.lib.utils.icon.get = {} end
if not apm.lib.utils.icon.set then apm.lib.utils.icon.set = {} end
if not apm.lib.utils.icon.dynamics then apm.lib.utils.icon.dynamics = {} end
if not apm.lib.utils.icon.static then apm.lib.utils.icon.static = {} end
if not apm.lib.utils.icon.signal then apm.lib.utils.icon.signal = {} end
if not apm.lib.utils.icon.layer then apm.lib.utils.icon.layer = {} end
if not apm.lib.utils.icon.path then apm.lib.utils.icon.path = {} end
if not apm.lib.utils.icon.generate then apm.lib.utils.icon.generate = {} end

--- Safe data.raw indexing. Returns nil if the type subtable doesn't exist,
--- otherwise returns data.raw[type_name][object_name] (which may itself be nil).
--- Guards against Factorio dropping a previously-guaranteed prototype type
--- (e.g. 2.1 removing all vanilla "tool" prototypes).
---@param type_name string
---@param object_name string
---@return table?
local function raw_get(type_name, object_name)
	local subtable = data.raw[type_name]
	return subtable and subtable[object_name] or nil
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function get_icon_size(object)
	local size = defines.constant.default_icon_size --[[@as number]]

	if object.icon_size then
		size = object.icon_size
	elseif object.size then
		size = object.size
	end

	return size
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function get_icon(object_name, type_name)
	local prototype_list = {}

	local function item_types()
		local list = { "item" }

		for item_type in pairs(defines.prototypes and defines.prototypes.item or {}) do
			if item_type ~= "item" then table.insert(list, item_type) end
		end

		table.sort(list, function(a, b)
			if a == "item" or b == "item" then return a == "item" and b ~= "item" end
			return a < b
		end)

		return list
	end

	if type_name == "fluid" then
		prototype_list = item_types()

		table.insert(prototype_list, 1, "fluid")
	elseif type_name == "item" or type_name == "item-with-entity-data" or type_name == "tool" then
		prototype_list = item_types()

		table.insert(prototype_list, "fluid")
	elseif type_name and type_name ~= "" then
		prototype_list = { type_name }
	end

	for _, prototype in ipairs(prototype_list) do
		local object = raw_get(prototype, object_name)

		if object then
			if type(object.icons) == "table" and #object.icons > 0 then
				return table.deepcopy(object.icons)
			end

			if type(object.icon) == "string" and object.icon ~= "" then
				return { { icon = object.icon, icon_size = get_icon_size(object) } }
			end
		end
	end

	return { table.deepcopy(apm.lib.icons.dummy) }
end

---@param value any
---@return boolean
local function is_layer(value)
	return type(value) == "table" and type(value.icon) == "string"
end

---@param value any
---@param caller string for the log
---@return IconData[]
local function layers_of(value, caller)
	if is_layer(value) then return { value } end
	local layers = {}
	if type(value) ~= "table" then
		log(APM_MSG_WARNING(caller, "not an icon layer or a list of layers: " .. tostring(value)))

		return layers
	end

	local count = 0

	for _, entry in ipairs(value) do
		count = count + 1

		if is_layer(entry) then table.insert(layers, entry) end
	end

	for key, entry in pairs(value) do
		local in_list = type(key) == "number" and key >= 1 and key <= count and key % 1 == 0

		if not (in_list and is_layer(entry)) then
			log(APM_MSG_WARNING(caller, "ignored entry [" .. tostring(key) .. "] = " .. tostring(entry) ..
				" (not an icon layer)"))
		end
	end

	return layers
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.icon.get.from_item(object_name)
	return get_icon(object_name, "item")
end

function apm.lib.utils.icon.get.from(object_type, object_name)
	return get_icon(object_name, object_type)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.icon.get.from_fluid(object_name)
	return get_icon(object_name, "fluid")
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.icon.get.from_recipe(object_name)
	return get_icon(object_name, "recipe")
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
--- DEPRICATED
function apm.lib.utils.icon.get.from_tool(object_name)
	return get_icon(object_name, "tool")
end

-- Function -------------------------------------------------------------------
--
-- t_icon: an icon layer -> {icon=...}; a list of layers ({{icon=...}, ...}, what the get
-- functions return) is changed layer by layer (apm.lib.utils.icons.mod)

--- Note (google/Gemini): an item or recipe icon is 32 units wide, (0, 0) is its centre, so
-- shifts between -16 and 16 stay inside it. With the default base_size 32, scale is the part
-- of the icon's width the layer takes: 0.5 = half the icon. The usual corner badge is
-- scale 0.5, shift {-8, -8} (top left). A layer reaching past the icon makes the game shrink
-- the whole icon until everything fits (shift {-32, -32} draws all layers at about half size).

--- NOTE (my): seems legit, it works and scale works after using fix with ^^^.

-- ----------------------------------------------------------------------------
---@param t_icon IconData|IconData[]
---@param scale number?
---@param shift Vector?
---@param base_size number? size the scale refers to (default 32)
---@return IconData|IconData[] a copy
function apm.lib.utils.icon.mod(t_icon, scale, shift, base_size)
	if not is_layer(t_icon) then
		return apm.lib.utils.icons.mod(t_icon, scale, shift, base_size)
	end


	if base_size == nil then
		base_size = 32
	end

	local new_icon = table.deepcopy(t_icon)

	if scale then
		local icon_size = get_icon_size(new_icon)
		new_icon.scale = scale * (base_size / icon_size)
	end

	if shift then
		if new_icon.shift then
			new_icon.shift = { new_icon.shift[1] + shift[1], new_icon.shift[2] + shift[2] }
		else
			new_icon.shift = { shift[1], shift[2] }
		end
	end

	return new_icon
end

-- Function -------------------------------------------------------------------
--
-- t_icons: a table of icons tables -> {{icon=...},...} (a single layer works too)
-- ----------------------------------------------------------------------------
---@param t_icons IconData[]|IconData
---@param scale number?
---@param shift Vector?
---@param base_size number? size the scale refers to (default 32)
---@return IconData[] copies
function apm.lib.utils.icons.mod(t_icons, scale, shift, base_size)
	local icons = {}

	for _, icon in ipairs(layers_of(t_icons, "apm.lib.utils.icons.mod")) do
		table.insert(icons, apm.lib.utils.icon.mod(icon, scale, shift, base_size))
	end

	return icons
end

-- Function -------------------------------------------------------------------
--
-- icon_tables: a list whose entries are lists of layers ({{icon=...},...}, what the get
-- functions return) or single layers ({icon=...})
-- ----------------------------------------------------------------------------
---@param icon_tables (IconData|IconData[])[]
---@return IconData[]
function apm.lib.utils.icon.merge(icon_tables)
	local layers = {}

	for _, entry in ipairs(icon_tables) do
		for _, layer in ipairs(layers_of(entry, "apm.lib.utils.icon.merge")) do
			table.insert(layers, table.deepcopy(layer))
		end
	end


	local min_size = 1024

	for _, layer in ipairs(layers) do
		local size = get_icon_size(layer)

		if size < min_size then min_size = size end
	end

	log(serpent.block(icon_tables))

	for _, layer in ipairs(layers) do
		local scale = min_size / get_icon_size(layer)
		if layer.scale == nil and scale ~= 1.0 then
			layer.scale = scale
		end
	end

	return layers
end

---@param prototype table
---@return boolean has_layers
local function to_layers(prototype)
	if type(prototype.icons) == "table" and #prototype.icons > 0 then return true end

	if type(prototype.icon) ~= "string" then return false end

	prototype.icons = { { icon = prototype.icon, icon_size = get_icon_size(prototype) } }
	prototype.icon = nil
	prototype.icon_size = nil

	return true
end

---@param old_layer IconData
---@param new_size number
---@return number?
local function kept_scale(old_layer, new_size)
	if old_layer.scale == nil then return nil end

	return old_layer.scale * get_icon_size(old_layer) / new_size
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.icon.generate.chemical(tint_1, tint_2, tint_3, tint_4, symbol, scale, shift)
	local icons = {}
	if tint_2 == nil then
		tint_2 = table.deepcopy(tint_1)
	end

	table.insert(icons, {
		icon = apm.lib.icons.path.chemical_flame_1,
		tint = tint_1,
		icon_size = 64,
		scale = scale,
		shift =
				shift
	})

	table.insert(icons, {
		icon = apm.lib.icons.path.chemical_flame_2,
		tint = tint_2,
		icon_size = 64,
		scale = scale,
		shift =
				shift
	})

	table.insert(icons, {
		icon = apm.lib.icons.path.chemical_flame_3,
		tint = tint_3,
		icon_size = 64,
		scale = scale,
		shift =
				shift
	})

	table.insert(icons, {
		icon = apm.lib.icons.path.chemical_flame_4,
		tint = tint_4,
		icon_size = 64,
		scale = scale,
		shift =
				shift
	})

	if symbol then
		symbol = table.deepcopy(symbol)

		symbol.scale = scale
		symbol.shift = shift

		table.insert(icons, symbol)
	end

	return icons
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.icon.generate.fluid(tint_1, tint_2, symbol, background_tint, background_alpha)
	local icons = {}

	if background_alpha == nil then
		background_alpha = 0.65
	end

	local inner_tint = table.deepcopy(tint_2)
	local bg_tint = table.deepcopy(background_tint or tint_2)

	bg_tint.a = background_alpha

	if background_tint == nil then
		inner_tint.a = background_alpha
	end

	table.insert(icons,
		{ icon = "__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_fluid_drop_background.png", tint = bg_tint, icon_size = 64 })
	table.insert(icons,
		{ icon = "__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_fluid_drop_inner.png", tint = inner_tint, icon_size = 64 })
	table.insert(icons,
		{ icon = "__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_fluid_drop_body.png", tint = table.deepcopy(tint_1), icon_size = 64 })

	if symbol then
		table.insert(icons, table.deepcopy(symbol))
	end

	return icons
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@param base_dn table a prototype
---@param layer integer? position of the new layer (1 = bottom, nil = top)
---@param icon_path string
---@param icon_size number? default 32
---@param scale number?
---@param shift Vector?
---@param tint Color?
function apm.lib.utils.icon.layer.insert(base_dn, layer, icon_path, icon_size, scale, shift, tint)
	if not base_dn or not icon_path then return end

	if not to_layers(base_dn) then return end

	local new_layer = { icon = icon_path, icon_size = icon_size or 32, scale = scale, shift = shift, tint = tint }

	if layer == nil or layer > #base_dn.icons then
		table.insert(base_dn.icons, new_layer)
	else
		table.insert(base_dn.icons, math.max(1, layer), new_layer)
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@param icon_path_old string
---@param icon_path_new string
---@param icon_size number?
---@param scale number?
---@param shift Vector?
---@param tint Color?
function apm.lib.utils.icon.replace(icon_path_old, icon_path_new, icon_size, scale, shift, tint)
	local type_list = { "item", "recipe" }
	for _, obj_type in pairs(type_list) do
		for _, obj in pairs(data.raw[obj_type] or {}) do
			if obj.icons then
				for _, layer in pairs(obj.icons) do
					if layer.icon == icon_path_old then
						local new_size = icon_size or get_icon_size(layer)
						layer.scale = scale or kept_scale(layer, new_size)
						layer.icon = icon_path_new
						layer.icon_size = new_size

						if shift then layer.shift = shift end

						layer.tint = tint
					end
				end
			elseif obj.icon == icon_path_old then
				obj.icon = icon_path_new

				if icon_size then obj.icon_size = icon_size end

				if scale or shift or tint then
					to_layers(obj)

					obj.icons[1].scale = scale
					obj.icons[1].shift = shift
					obj.icons[1].tint = tint
				end
			end
		end
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@param base_dn table a prototype
---@param layer integer
---@param icon_path string?
---@param icon_size number? default 32
---@param scale number?
---@param shift Vector?
---@param tint Color?
function apm.lib.utils.icon.layer.replace(base_dn, layer, icon_path, icon_size, scale, shift, tint)
	if not base_dn then return end

	if not to_layers(base_dn) then return end

	if not icon_size then icon_size = 32 end

	local old = base_dn.icons[layer]

	if not old then
		log(APM_MSG_WARNING("layer.replace()",
			'"' .. tostring(base_dn.name) .. '" has no icon layer ' .. tostring(layer)))
		return
	end

	if icon_path == nil then
		if #base_dn.icons == 1 then
			log(APM_MSG_WARNING("layer.replace()",
				'"' .. tostring(base_dn.name) .. '": the only icon layer is not removed'))

			return
		end
		table.remove(base_dn.icons, layer)
		return
	end

	base_dn.icons[layer] = {
		icon = icon_path,
		icon_size = icon_size,
		scale = scale or kept_scale(old, icon_size),
		shift = shift or old.shift,
		tint = tint,
	}

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"layer.replace()",
			'in: "' ..
			tostring(base_dn.name) ..
			'" type: "' ..
			tostring(base_dn.type) ..
			'" on layer: "' ..
			tostring(layer) ..
			'" new icon: "' ..
			tostring(icon_path) ..
			'" with size: "' ..
			tostring(icon_size) ..
			'" with scale: "' ..
			tostring(scale) .. '" with shift: "' .. tostring(shift) .. '" with tint: "' .. tostring(tint) .. '"'
		))
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function get_tier_icon(level)
	if level == 1 then
		return apm.lib.icons.dynamics.t1
	elseif level == 2 then
		return apm.lib.icons.dynamics.t2
	elseif level == 3 then
		return apm.lib.icons.dynamics.t3
	elseif level == 4 then
		return apm.lib.icons.dynamics.t4
	elseif level == 5 then
		return apm.lib.icons.dynamics.t5
	else
		return nil
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.icon.add_tier_lable(name, level)
	local prototypes = {
		"item",
		"item-with-entity-data",
		"fluid",
		"recipe",
		"assembling-machine",
		"boiler",
		"logistic-robot",
		"construction-robot",
		"inserter",
		"lab",
		"locomotive",
		"mining-drill",
		"module",
		"reactor",
		"ammo-turret",
		"car",
		"generator",
	}

	local tier_icon = get_tier_icon(level)

	if not tier_icon then return end

	for _, prototype in pairs(prototypes) do
		local item = raw_get(prototype, name)
		if item ~= nil then
			if to_layers(item) then
				local has_label = false

				for _, existing in pairs(item.icons) do
					if existing.icon == tier_icon.icon then has_label = true end
				end

				if not has_label then
					table.insert(item.icons, table.deepcopy(tier_icon))
				end
			end
		end
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@param object table a prototype
---@param t_icons IconData[]|IconData a list of layers (a single layer works too)
function apm.lib.utils.icon.set.icons(object, t_icons)
	if is_layer(t_icons) then t_icons = { t_icons } end

	object.icon = nil
	object.icon_size = nil
	object.icons = t_icons

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"set.icons()",
			'icons set for type: "' .. tostring(object.type) .. '" name: "' .. tostring(object.name) .. '"'
		))
	end
end
