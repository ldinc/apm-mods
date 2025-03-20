if not rampant_heavy_wall then rampant_heavy_wall = {} end
if not rampant_heavy_wall.lib then rampant_heavy_wall.lib = {} end
if not rampant_heavy_wall.lib.const then rampant_heavy_wall.lib.const = {} end

---@type Color
local tint = {r = 155, g = 155, b = 160}

rampant_heavy_wall.lib.const.wall = {
	name = "heavy-wall-rampant-arsenal",
	tint = tint,
}

rampant_heavy_wall.lib.const.gate = {
	name = "heavy-gate-rampant-arsenal",
	tint = tint,
}
