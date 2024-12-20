require 'util'

--- [math.round]
---@param num number
---@param numDecimalPlaces number
---@return integer
function apm.lib.utils.math.round(num, numDecimalPlaces)
	local mult = 10 ^ (numDecimalPlaces or 0)

	return math.floor(num * mult + 0.5) / mult
end
