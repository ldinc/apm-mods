if DIR == nil then DIR = {} end

DIR.base = "__apm_bob_rework_resource_pack_ldinc__/graphics/"

DIR.icon_path = DIR.base.."icons"
DIR.icon_size = 64
DIR.default_belt_speed = 15 -- yellow belt items/s
DIR.base_energy_unit = 4 -- MJ
DIR.belt_energy_value = DIR.base_energy_unit * DIR.default_belt_speed -- MW
DIR.machines_per_belt = 12 -- how many furnaces/assemblers should saturate a yellow belt at speed 1 with a recipe speed of 1
DIR.machine_to_belt_ratio = DIR.machines_per_belt / DIR.default_belt_speed -- with default numbers, 0.8
DIR.clusters_per_energy_belt = 10 -- how many "arrays of machines_per_belt" uses up one "energy belt" (a yellow belt full of coal) at crafting speed 1
DIR.smelting_to_crafting_ratio = 4

-- TODO: rework local
DIR.sprite_paths_lookup = {
	["assemblers"] = DIR.entities_path_1,
	["bots"] = DIR.entities_path_2,
	["decorative"] = DIR.entities_path_2,
	["inserters"] = DIR.entities_path_2,
	["particles"] = DIR.entities_path_2,
	["pipes"] = DIR.entities_path_2,
	["projectiles"] = DIR.entities_path_2,
	["resources"] = DIR.entities_path_2,
	["tiles"] = DIR.entities_path_2,
	["vehicles"] = DIR.entities_path_2,
	["walls"] = DIR.entities_path_2,
	["furnaces"] = DIR.entities_path_2,
	["grinders"] = DIR.entities_path_2,
	["washers"] = DIR.entities_path_2,
	["fluids"] = DIR.entities_path_3,
	["forestry"] = DIR.entities_path_3,
	["misc"] = DIR.entities_path_3,
	["power"] = DIR.entities_path_3,
	["storage"] = DIR.entities_path_3,
	["turrets"] = DIR.entities_path_3,
	["drills"] = DIR.entities_path_4,
	["labs"] = DIR.entities_path_4,	
}

function DIR.get_icon_path(name, icon_size, path)
	return string.format("%s/%s/%s.png", path or DIR.icon_path, tostring(icon_size or DIR.icon_size), name)
end

function DIR.get_standard_speed(multiplier)
	return (1/DIR.machine_to_belt_ratio) * multiplier
end

function DIR.get_scaled_energy_usage(speed, drain_ratio)
	if not drain_ratio then drain_ratio = 0 end
	local total = (DIR.belt_energy_value / (DIR.machines_per_belt * DIR.clusters_per_energy_belt * DIR.smelting_to_crafting_ratio)) * speed
	return {
		active = tostring(total * (1-drain_ratio)) .. "MW",
		passive = drain_ratio and (tostring(total * (drain_ratio)) .. "MW") or nil,
		total_as_numeric_MW = total,
	}
end

function DIR.get_layer(name, frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, tw, th, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode, scale, sequence, sprite_path) 
	if shift then
		shift = DIR.offset(shift, DIR.shift_calc(x,y,tw,th,width,height))
	end
	
	local sprite = DIR.get_sprite_def(name, frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, scale or 0.5, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode, sequence, sprite_path)
	return sprite
end

function DIR.offset(shift1, shift2)
	return ({shift1[1]-shift2[1], shift1[2]-shift2[2]})
end

function DIR.shift_calc(x,y,tw,th,w,h)
	return {((tw/2) - (x + (w/2)))/64, ((th/2) - (y + (h/2)))/64}
end

function DIR.get_sprite_def(name, frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, scale, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode, sequence, sprite_path) 
	local variation_count = nil
	if frame_count and frame_count < 0 then
		variation_count = math.abs(frame_count)
		frame_count = nil
	end
	if shadow == true then shadow = "shadow" elseif shadow == false then shadow = nil end
	return {
		draw_as_shadow = (shadow == "shadow"),
		draw_as_light = (shadow == "light"),
		draw_as_glow = (shadow == "glow"),
		filename = string.format("%s/%s.png", sprite_path or DIR.get_sprites_path_from_name(name), name),
		blend_mode = blend_mode,
		animation_speed = animation_speed,
		repeat_count = repeat_count,
		frame_count = frame_count,
		direction_count = direction_count,
		line_length = line_length,
		height = height,
		width = width,
		x = x,
		y = y,
		scale = scale,
		shift = shift,
		tint = tint,
		apply_runtime_tint = apply_runtime_tint,
		run_mode = run_mode,
		priority = "high",
		flags = flags,
		variation_count = variation_count,
		frame_sequence = sequence,
	}
end


function DIR.get_multi_sprite_def(name, files, frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, scale, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode, sprite_path) 
	local stripes = {}
	for i=1,files do
		table.insert(stripes, { filename = string.format("%s/%s-%d.png", sprite_path or DIR.get_sprites_path_from_name(name), name, i), width_in_frames = frame_count, height_in_frames = direction_count / files })
	end
	if shadow == true then shadow = "shadow" elseif shadow == false then shadow = nil end
	return {
		draw_as_shadow = (shadow == "shadow"),
		draw_as_light = (shadow == "light"),
		draw_as_glow = (shadow == "glow"),
		stripes = stripes, 
		blend_mode = blend_mode,
		animation_speed = animation_speed,
		repeat_count = repeat_count,
		frame_count = frame_count,
		direction_count = direction_count,
		line_length = line_length,
		height = height,
		width = width,
		x = x,
		y = y,
		scale = scale,
		shift = shift,
		tint = tint,
		apply_runtime_tint = apply_runtime_tint,
		run_mode = run_mode,
		priority = "high",
		flags = flags,
		max_advance = 1, -- caps vehicle wheel animation
	}
end

-- patched for local needs
local fluids = '__apm_bob_rework_resource_pack_ldinc__/graphics/entities/ir3/fluids/'
local path_map = {
	['air-compressor-base'] = fluids,
	['air-compressor-base-yellow'] = fluids,
	['air-compressor-working'] = fluids,
	['air-compressor-shadow'] = fluids,
	['air-compressor-status'] = fluids,
	['barrelling-machine-base'] = fluids,
	['barrelling-machine-shadow'] = fluids,
	['barrelling-machine-barrel'] = fluids,
	['barrelling-machine-barrel-shadow'] = fluids,
	['barrelling-machine-canister'] = fluids,
	['barrelling-machine-canister-shadow'] = fluids,
	['barrelling-machine-status'] = fluids,
}

function DIR.get_sprites_path_from_name(name)
	local path = path_map[name]
	if path then
		return path
	end
	error("not implemented "..name)

	for substring,path in pairs(DIR.sprite_paths_lookup) do
		if string.find(name,substring.."/",1,true) then return path end
	end
	error("Could not identify mod/folder for sprite "..name)
end

return DIR
