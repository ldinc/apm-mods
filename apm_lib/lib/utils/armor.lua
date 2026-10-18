require "util"
require("lib.log")

local self = "lib.utils.armor"

apm.lib.utils.armor.damage_type = {
	radiation = "apm_radiation",
}

--- [armor.add_resistance]
---@param armor_name string
---@param damage_type string
---@param decrease number?
---@param percent number?
---@return boolean ok
function apm.lib.utils.armor.add_resistance(armor_name, damage_type, decrease, percent)
	local armor = data.raw.armor and data.raw.armor[armor_name]

	if not armor then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING("add_resistance()", 'armor: "' .. tostring(armor_name) .. '" does not exist.'))
		end

		return false
	end

	if not (data.raw["damage-type"] and data.raw["damage-type"][damage_type]) then
		log(APM_MSG_ERROR("add_resistance()", 'damage type: "' .. tostring(damage_type) .. '" does not exist.'))

		return false
	end

	decrease = math.max(decrease or 0, 0)
	percent = math.min(math.max(percent or 0, 0), 100)

	armor.resistances = armor.resistances or {}

	for _, resistance in pairs(armor.resistances) do
		if resistance.type == damage_type then
			resistance.decrease = decrease
			resistance.percent = percent

			return true
		end
	end

	table.insert(armor.resistances, { type = damage_type, decrease = decrease, percent = percent })

	return true
end
