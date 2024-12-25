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
				'add.science_pack()',
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
				'add.science_pack()',
				'technology: "' .. tostring(technology_name) .. '" skipped due empty "unit" field'
			))
		end

		return
	end

	table.insert(technology.unit.ingredients, { science_pack, science_amount })

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'add.science_pack()',
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

	---@type data.ResearchIngredient[]
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
				'set.science_packs_from_prerequisites()',
				'prerequisite: "' .. tostring(technology_name.name) .. '"does not have a prerequisites property'
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
						'set.science_packs_from_prerequisites()',
						'prerequisite: "' .. tostring(required_technology.name) .. '"does not have an unit property'
					))
				end
			end
		end
	end

	if not collected_science then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'set.science_packs_from_prerequisites()',
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
