if not apm.lib.utils.technology then apm.lib.utils.technology = {} end
if not apm.lib.utils.technology.has then apm.lib.utils.technology.has = {} end
if not apm.lib.utils.technology.get then apm.lib.utils.technology.get = {} end

--- [technology.has.prerequisites]
---@param technology_name string
---@param prerequisites_name string
---@return boolean
function apm.lib.utils.technology.has.prerequisites(technology_name, prerequisites_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok or technology == nil then
		return false
	end

	if technology.prerequisites then
		for _, prerequisite in pairs(technology.prerequisites) do
			if prerequisite == prerequisites_name then
				return true
			end
		end
	end

	return false
end

---@param technology TechnologyPrototype
---@param set table<ItemID, TechnologyID[]>
---@return table<ItemID, TechnologyID[]>, boolean
function apm.lib.utils.technology.has.one_of_product(technology, set)
	local has_changes = false


	if not technology.effects or #technology.effects == 0 then
		return set, has_changes
	end

	for _, v in pairs(technology.effects) do
		if v.type == "unlock-recipe" then
			local recipe, ok = apm.lib.utils.recipe.get.by_name(v.recipe)

			if ok then
				if recipe.results then
					for _, result in ipairs(recipe.results) do
						if set[result.name] then
							table.insert(set[result.name], technology.name)

							has_changes = true
						end
					end
				end
			end
		end
	end

	return set, has_changes
end

--- [technology.get.prerequisites]
---@param technology_name string
---@return string[]?
function apm.lib.utils.technology.get.prerequisites(technology_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok or not technology then
		return nil
	end


	if technology.prerequisites then
		return technology.prerequisites
	end

	return nil
end

--- [technology.prerequisite.has.science_pack]
---@param technology_name string
---@param science_pack_name string
---@return boolean
function apm.lib.utils.technology.prerequisite.has.science_pack(technology_name, science_pack_name)
	local prerequisites = apm.lib.utils.technology.get.prerequisites(technology_name)

	if not prerequisites then
		return false
	end

	for _, prerequisite in pairs(prerequisites) do
		if apm.lib.utils.technology.has.science_pack(prerequisite, science_pack_name) then
			return true
		end
	end

	return false
end

--- [technology.add.prerequisites]
---@param technology_name string
---@param prerequisites_name string
function apm.lib.utils.technology.add.prerequisites(technology_name, prerequisites_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok or not technology then
		return nil
	end

	if not apm.lib.utils.technology.exist(prerequisites_name) then
		return
	end

	if technology.prerequisites == nil then
		technology.prerequisites = {}
	end

	if not apm.lib.utils.technology.has.prerequisites(technology_name, prerequisites_name) then
		table.insert(technology.prerequisites, prerequisites_name)

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"add.prerequisites()",
				'added: "' .. tostring(prerequisites_name) .. '" to "' .. tostring(technology_name) .. '"'
			))
		end
	else
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"add.prerequisites()",
				'"' ..
				tostring(technology_name) .. '" allready has "' .. tostring(prerequisites_name) .. '" as prerequisites'
			))
		end
	end
end

--- [technology.remove.prerequisites]
---@param technology_name string
---@param prerequisites_name string
function apm.lib.utils.technology.remove.prerequisites(technology_name, prerequisites_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok or not technology then
		return
	end

	if not apm.lib.utils.technology.exist(prerequisites_name) then
		return
	end

	if not technology.prerequisites then
		return
	end

	for k, prerequisite in pairs(technology.prerequisites) do
		if prerequisite == prerequisites_name then
			table.remove(technology.prerequisites, k)

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					"remove.prerequisites()",
					'removed prerequisites: "' ..
					tostring(prerequisites_name) .. '" from technology: "' .. tostring(technology_name) .. '"'
				))
			end
		end
	end
end

--- [technology.remove.prerequisites_all]
---@param technology_name string
function apm.lib.utils.technology.remove.prerequisites_all(technology_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok or not technology then
		return
	end

	if not technology.prerequisites then
		return
	end

	technology.prerequisites = {}
end

--- [technology.force.prerequisites]
--- This function forces the prerequisites of a technologie.
--- prerequisites_names: table{string, string, ...} or string.
---@param technology_name string
---@param prerequisites_names string|string[]
function apm.lib.utils.technology.force.prerequisites(technology_name, prerequisites_names)
	if not apm.lib.utils.technology.exist(technology_name) then return end

	local prerequisites = apm.lib.utils.technology.get.prerequisites(technology_name)

	if prerequisites then
		for i = #prerequisites, 1, -1 do
			p_tech_name = prerequisites[i]
			apm.lib.utils.technology.remove.prerequisites(technology_name, p_tech_name)
		end
	end

	if prerequisites_names == nil then
		return
	end

	if type(prerequisites_names) == "table" then
		for _, p_tech_name in pairs(prerequisites_names) do
			apm.lib.utils.technology.add.prerequisites(technology_name, p_tech_name)
		end
	elseif type(prerequisites_names) == "string" then
		apm.lib.utils.technology.add.prerequisites(technology_name, prerequisites_names)
	end
end

---@param names string[]
---@return table<string, table<string, true>>
local function chains_of(names)
	local technologies = data.raw.technology
	local chains = {}

	for _, name in ipairs(names) do
		if not chains[name] then
			local chain = {}

			local function walk(current)
				for _, prerequisite in pairs(technologies[current] and technologies[current].prerequisites or {}) do
					if not chain[prerequisite] then
						chain[prerequisite] = true

						walk(prerequisite)
					end
				end
			end

			walk(name)

			chains[name] = chain
		end
	end

	return chains
end

---@param technologies string[]
---@return string[]
local function unique(technologies)
	local list, seen = {}, {}

	for _, name in ipairs(technologies) do
		if not seen[name] then
			seen[name] = true

			table.insert(list, name)
		end
	end

	return list
end

---@param technologies string[] technology names
---@return string[]
function apm.lib.utils.technology.find.predecessors_from(technologies)
	local list = unique(technologies)
	local chains = chains_of(list)
	local result = {}

	for _, name in ipairs(list) do
		local later = false

		for _, other in ipairs(list) do
			if other ~= name and chains[name][other] then
				later = true

				break
			end
		end

		if not later then table.insert(result, name) end
	end

	return result
end

---@param technologies string[] technology names
---@return string[]
function apm.lib.utils.technology.find.successors_from(technologies)
	local list = unique(technologies)
	local chains = chains_of(list)
	local result = {}
	for _, name in ipairs(list) do
		local earlier = false

		for _, other in ipairs(list) do
			if other ~= name and chains[other][name] then
				earlier = true

				break
			end
		end

		if not earlier then table.insert(result, name) end
	end

	return result
end
