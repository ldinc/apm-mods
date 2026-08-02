if not apm.lib.utils.technology then apm.lib.utils.technology = {} end
if not apm.lib.utils.technology.add then apm.lib.utils.technology.add = {} end
if not apm.lib.utils.technology.has then apm.lib.utils.technology.has = {} end
if not apm.lib.utils.technology.get then apm.lib.utils.technology.get = {} end
if not apm.lib.utils.technology.remove then apm.lib.utils.technology.remove = {} end

--- [technology.has.science_pack]
---@param technology_name string
---@param science_pack_name string
---@return boolean
function apm.lib.utils.technology.has.science_pack(technology_name, science_pack_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return false
	end

	if not technology.unit then
		return false
	end

	if not technology.unit.ingredients then
		return false
	end

	for _, ingredient in pairs(technology.unit.ingredients) do
		if ingredient[1] == science_pack_name then
			return true
		end
	end

	return false
end

--- [technology.add.science_pack]
---@param technology_name string
---@param science_pack string
---@param science_amount number?
function apm.lib.utils.technology.add.science_pack(technology_name, science_pack, science_amount)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	if not science_amount then
		science_amount = 1
	end

	if apm.lib.utils.technology.has.science_pack(technology_name, science_pack) then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"add.science_pack()",
				'technology: "' ..
				tostring(technology_name) .. '" allready has science_pack: "' .. tostring(science_pack) .. '"'
			))
		end

		return
	end

	if technology.unit == nil then
		-- TODO: or create new value or skip?

		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"add.science_pack()",
				'technology: "' .. tostring(technology_name) .. '" skipped due empty "unit" field'
			))
		end

		return
	end

	table.insert(technology.unit.ingredients, { science_pack, science_amount })

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"add.science_pack()",
			'science_pack: "' ..
			tostring(science_pack) ..
			'" added to: "' .. tostring(technology_name) .. '" with amount: "' .. tostring(science_amount) .. '"'
		))
	end
end

--- [technology.remove.science_pack]
---@param technology_name string
---@param science_pack string
function apm.lib.utils.technology.remove.science_pack(technology_name, science_pack)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	if technology.unit == nil then
		-- TODO: can be with "research_trigger"

		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"remove.science_pack()", 'technology "' .. technology_name ..
				'" skipped due to empty "unit" field'
			))
		end

		return
	end

	for k, i in pairs(technology.unit.ingredients) do
		if i[1] == science_pack then
			table.remove(technology.unit.ingredients, k)

			return
		end
	end
end

--- [technology.force.update_science_packs]
---@param technology_name string
function apm.lib.utils.technology.force.update_science_packs(technology_name)
	apm.lib.utils.technology.remove.science_packs_except(technology_name, {})
	apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites(technology_name)
end

--- [technology.remove.science_packs_except]
---@param technology_name string
---@param science_pack_list string[]
function apm.lib.utils.technology.remove.science_packs_except(technology_name, science_pack_list)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok or not science_pack_list or not technology.unit then
		return
	end

	---@type table<string, boolean>
	local skip_list = {}

	for _, sp in ipairs(science_pack_list) do
		skip_list[sp] = true
	end

	---@type ResearchIngredient[]
	local new_set = {}

	for _, sp in ipairs(technology.unit.ingredients) do
		if sp then
			local key = sp[1]
			if skip_list[key] then
				table.insert(new_set, sp)
			end
		end
	end

	technology.unit.ingredients = new_set
end

apm.lib.utils.technology.basic_science_packs = {
	["apm_industrial_science_pack"] = true,
	["apm_steam_science_pack"] = true,
}

--- @param tech TechnologyPrototype?
function apm.lib.utils.technology.remove.apms_if_has_others_by_ref(tech)
	if not tech then
		return
	end

	local ok = apm.lib.utils.technology.has.science_packs(tech, apm.lib.utils.technology.basic_science_packs, false)

	if not ok then
		for sp_name, _ in pairs(apm.lib.utils.technology.basic_science_packs) do
			apm.lib.utils.technology.remove.science_pack(tech.name, sp_name)
		end
	end
end

---@param tech TechnologyPrototype
---@param map { [string]: string }
---@param any_mode boolean?
---@return boolean
function apm.lib.utils.technology.has.science_packs(tech, map, any_mode)
	if not tech.unit or #tech.unit.ingredients == 0 then
		return false
	end

	for _, ingredients in ipairs(tech.unit.ingredients) do
		if any_mode and map[ingredients[1]] then
			return true
		end

		if not any_mode and not map[ingredients[1]] then
			return false
		end
	end

	return true
end

--- [technology.add.science_pack_conditional]
---@param science_pack_name string
---@param cond_science_pack_name string
function apm.lib.utils.technology.add.science_pack_conditional(science_pack_name, cond_science_pack_name, skiplist)
	if not skiplist then
		for _, technology in pairs(data.raw.technology) do
			if apm.lib.utils.technology.has.science_pack(technology.name, cond_science_pack_name) then
				apm.lib.utils.technology.add.science_pack(technology.name, science_pack_name)
			end
		end
	else
		for _, technology in pairs(data.raw.technology) do
			if not skiplist[technology.name] then
				if apm.lib.utils.technology.has.science_pack(technology.name, cond_science_pack_name) then
					apm.lib.utils.technology.add.science_pack(technology.name, science_pack_name)
				end
			end
		end
	end
end

--- [technology.set.heritage_science_packs_from_prerequisites]
---@param technology_name string
function apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites(technology_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	local collected_science = {}
	local hash = {}

	if not technology.prerequisites then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"set.science_packs_from_prerequisites()",
				'prerequisite: "' .. tostring(technology_name) .. '"does not have a prerequisites property'
			))
		end

		return
	end

	for _, prerequisite in pairs(technology.prerequisites) do
		local required_technology = data.raw.technology[prerequisite]
		if required_technology then
			if required_technology.unit then
				for _, science in pairs(required_technology.unit.ingredients) do
					table.insert(collected_science, science[1])
				end
			else
				if APM_CAN_LOG_WARN then
					log(APM_MSG_WARNING(
						"set.science_packs_from_prerequisites()",
						'prerequisite: "' .. tostring(required_technology.name) .. '"does not have an unit property'
					))
				end
			end
		end
	end

	if not collected_science then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"set.science_packs_from_prerequisites()",
				'No inheritance possible for: "' .. tostring(technology_name) .. '"!'
			))
		end

		return
	end

	for _, science_pack in pairs(collected_science) do
		if not hash[science_pack] then
			if not technology.unit then
				technology.unit = {
					ingredients = {},
					time = 50,
					count = 50,
				}
			end

			apm.lib.utils.technology.add.science_pack(technology_name, science_pack, 1)

			hash[science_pack] = true
		end
	end
end

--- Active science pack order map: science pack name -> tier (integer).
--- Applied to the science pack items by [technology.overwrite.science_pack_order_strings]
--- and to the lab inputs by [technology.overwrite.lab_science_pack_order];
--- packs are sorted by tier, then by name. Tiers use gaps of 10, so other mods
--- can slot packs between the default ones via [technology.set.science_pack_order]
--- and [technology.set.science_pack_order_after] depending on their mod set
--- (e.g. from their overwrites/integrations stage, before the map is applied).
---@type table<string, integer>
apm.lib.utils.technology.science_pack_order = {
	["apm_industrial_science_pack"] = 10,
	["apm_steam_science_pack"] = 20,
	["automation-science-pack"] = 30,
	["logistic-science-pack"] = 40,
	["military-science-pack"] = 50,
	["chemical-science-pack"] = 60,
	["production-science-pack"] = 70,
	["utility-science-pack"] = 80,
	["apm_nuclear_science_pack"] = 90,
	["space-science-pack"] = 100,
	["electromagnetic-science-pack"] = 110,
	["metallurgic-science-pack"] = 120,
	["agricultural-science-pack"] = 130,
	["cryogenic-science-pack"] = 140,
	["promethium-science-pack"] = 150,
}

--- Formats the order string used on the science pack item prototypes for a tier.
---@param tier number
---@param science_pack_name string
---@return string
local function format_science_pack_order(tier, science_pack_name)
	if tier % 1 == 0 then
		return string.format("%03d[%s]", tier, science_pack_name)
	end

	return string.format("%09.4f[%s]", tier, science_pack_name)
end

--- [technology.set.science_pack_order]
--- Sets or overrides the tier of a single science pack.
---@param science_pack_name string
---@param tier number
function apm.lib.utils.technology.set.science_pack_order(science_pack_name, tier)
	apm.lib.utils.technology.science_pack_order[science_pack_name] = tier
end

--- [technology.set.science_pack_orders]
--- Merges the given map of science pack name -> tier into the active order map.
---@param orders table<string, number>
function apm.lib.utils.technology.set.science_pack_orders(orders)
	for science_pack_name, tier in pairs(orders) do
		apm.lib.utils.technology.set.science_pack_order(science_pack_name, tier)
	end
end

--- [technology.set.science_pack_order_after]
--- Places a science pack right after another one (its tier + 1), e.g. to slot a
--- modded pack into the progression without renumbering the map.
--- Does nothing (with a warning) if the target pack is not in the order map.
---@param science_pack_name string
---@param after_science_pack_name string
function apm.lib.utils.technology.set.science_pack_order_after(science_pack_name, after_science_pack_name)
	local after_tier = apm.lib.utils.technology.science_pack_order[after_science_pack_name]

	if not after_tier then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"set.science_pack_order_after()",
				'target science pack: "' .. tostring(after_science_pack_name) .. '" is not in the order map'
			))
		end

		return
	end

	apm.lib.utils.technology.science_pack_order[science_pack_name] = after_tier + 1
end

--- [technology.remove.science_pack_order]
--- Removes a single science pack from the order map (e.g. when an overhaul mod
--- like Krastorio2 or Space Exploration replaces the vanilla science packs).
---@param science_pack_name string
function apm.lib.utils.technology.remove.science_pack_order(science_pack_name)
	apm.lib.utils.technology.science_pack_order[science_pack_name] = nil
end

--- [technology.remove.science_pack_orders]
--- Removes the given science packs from the order map.
---@param science_pack_names string[]
function apm.lib.utils.technology.remove.science_pack_orders(science_pack_names)
	for _, science_pack_name in ipairs(science_pack_names) do
		apm.lib.utils.technology.remove.science_pack_order(science_pack_name)
	end
end

--- [technology.overwrite.science_pack_order_strings]
--- Applies the tiers of [apm.lib.utils.technology.science_pack_order] to the order
--- strings of the science pack item prototypes. The game sorts the science packs of
--- a technology in the technology GUI by item group, subgroup and this order string,
--- not by the ingredients array (the lab GUI follows the lab's inputs array instead,
--- see [technology.overwrite.lab_science_pack_order]).
--- Packs without an item prototype (not part of the current mod set) are skipped.
--- Note: for vanilla packs the map holds the APM progression order, so applying it
--- rewrites their order strings (affects inventory sorting as well).
--- Best called at the end of data-final-fixes.lua, after all mods have created
--- their science packs.
---@param subgroup string? # also set the item subgroup of the science packs (e.g. "science-pack")
function apm.lib.utils.technology.overwrite.science_pack_order_strings(subgroup)
	local count = 0

	for pack_name, tier in pairs(apm.lib.utils.technology.science_pack_order) do
		local item = data.raw["item"][pack_name] or (data.raw["tool"] and data.raw["tool"][pack_name])

		if item then
			item.order = format_science_pack_order(tier, pack_name)

			if subgroup then
				item.subgroup = subgroup
			end

			count = count + 1
		end
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"overwrite.science_pack_order_strings()",
			"order string updated for " .. tostring(count) .. " science packs"
		))
	end
end

--- [technology.overwrite.lab_science_pack_order]
--- Sorts the inputs of all labs by [apm.lib.utils.technology.science_pack_order].
--- The lab GUI shows the science packs of a lab in the order of its inputs array,
--- unlike the technology GUI, which sorts by item group, subgroup and order string.
--- Packs missing from the order map keep their relative order and are placed
--- after the mapped packs.
--- Best called at the end of data-final-fixes.lua, after all mods have added
--- their science packs to the labs.
function apm.lib.utils.technology.overwrite.lab_science_pack_order()
	local order_map = apm.lib.utils.technology.science_pack_order
	local count = 0

	for _, lab in pairs(data.raw["lab"] or {}) do
		if lab.inputs then
			---@type { name: string, index: uint64 }[]
			local decorated = {}

			for index, pack_name in ipairs(lab.inputs) do
				---@cast pack_name string
				decorated[index] = { name = pack_name, index = index }
			end

			---@param a { name: string, index: uint64 }
			---@param b { name: string, index: uint64 }
			---@return boolean
			local function by_science_pack_order(a, b)
				local order_a = order_map[a.name]
				local order_b = order_map[b.name]

				if order_a and order_b then
					if order_a ~= order_b then
						return order_a < order_b
					end

					return a.name < b.name
				end

				if order_a and not order_b then
					return true
				end

				if order_b and not order_a then
					return false
				end

				return a.index < b.index
			end

			table.sort(decorated, by_science_pack_order)

			for index, entry in ipairs(decorated) do
				lab.inputs[index] = entry.name
			end

			count = count + 1
		end
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"overwrite.lab_science_pack_order()",
			"science pack inputs sorted for " .. tostring(count) .. " labs"
		))
	end
end
