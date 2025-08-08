local strings = require("lib.containers.strings")

local init = {}

function init.alloc_defenitions()
	if not storage.apm then storage.apm = {} end
	if not storage.apm.lib then storage.apm.lib = {} end
	if not storage.apm.lib.technologies then storage.apm.lib.technologies = {} end
	if not storage.apm.lib.technologies.list then
		---@type table<string, boolean>
		storage.apm.lib.technologies.list = {}
	end
	if not storage.apm.lib.technologies.conditional then storage.apm.lib.technologies.conditional = {} end
	if not storage.apm.lib.technologies.conditional_recipes then storage.apm.lib.technologies.conditional_recipes = {} end
end

---@param unlock_technology string
---@param parent_technologies data.TechnologyPrototype | string
function init.add_technology_conditional(unlock_technology, parent_technologies)
	local p_techs = {}

	if type(parent_technologies) == "table" then
		p_techs = parent_technologies
	elseif type(parent_technologies) == "string" then
		p_techs = { parent_technologies }
	end

	if not storage.apm.lib.technologies.conditional[unlock_technology] then
		storage.apm.lib.technologies.conditional[unlock_technology] = p_techs
	else
		for _, p_tech in pairs(p_techs) do
			table.insert(storage.apm.lib.technologies.conditional[unlock_technology], p_tech)
		end
	end
end

---@return boolean
local function storage_state_is_valid()
	if
			not storage.apm or
			not storage.apm.lib or
			not storage.apm.lib.technologies or
			not storage.apm.lib.technologies.conditional_recipes then
		return true
	end

	return false
end

---@param unlock_technology string
---@param cond_recipes string[]|string
function init.add_technology_conditional_recipe(unlock_technology, cond_recipes)
	if storage_state_is_valid then
		return
	end

	---@type string[]
	local p_recipes = {}

	if type(cond_recipes) == "table" then
		p_recipes = cond_recipes
	elseif type(cond_recipes) == "string" then
		p_recipes = { cond_recipes }
	end

	if not storage.apm.lib.technologies.conditional_recipes[unlock_technology] then
		storage.apm.lib.technologies.conditional_recipes[unlock_technology] = p_recipes
	else
		for _, p_recipe in pairs(p_recipes) do
			table.insert(storage.apm.lib.technologies.conditional_recipes[unlock_technology], p_recipe)
		end
	end
end

---@param technology_name string
function init.add_technology(technology_name)
	storage.apm.lib.technologies.list[technology_name] = true
end

---@param force LuaForce
local function activate_technologies_conditional(force)
	if storage_state_is_valid then
		return
	end


	log("Info: execute: activate_technologies_conditional() for force: " .. tostring(force.name))

	local technologies = force.technologies

	for technology, cond_technologies in pairs(storage.apm.lib.technologies.conditional) do
		local c_tech = technologies[technology]

		if c_tech and not c_tech.researched then
			for _, cond_tech in pairs(cond_technologies) do
				local cond_technology = technologies[cond_tech]

				if cond_technology and cond_technology.researched then
					c_tech.researched = true

					log("-> for force: " ..
						tostring(force.name) .. " state for technology: \"" ..
						tostring(c_tech.name) .. "\" changed to \"enabled\"")
					break
				end
			end
		end
	end

	log("Info: finished: activate_technologies_conditional() for force: " .. tostring(force.name))
end

---@param force LuaForce
local function activate_technologies_conditional_recipes(force)
	log("Info: execute: activate_technologies_conditional_recipes() for force: " .. tostring(force.name))

	local technologies = force.technologies
	local recipes = force.recipes

	if storage_state_is_valid then
		return
	end


	for technology, cond_recipes in pairs(storage.apm.lib.technologies.conditional_recipes) do
		local tech = technologies[technology]

		if tech and not tech.researched then
			for _, p_recipe in pairs(cond_recipes) do
				local cond_recipe = recipes[p_recipe]

				if cond_recipe.enabled then
					tech.researched = true

					log("-> for force: " ..
						tostring(force.name) ..
						" state for technology: \"" .. tostring(tech.name) .. "\" changed to \"enabled\"")
					break
				end
			end
		end
	end

	log("Info: finished: activate_technologies_conditional_recipes() for force: " .. tostring(force.name))
end

---@param force LuaForce
local function check_technologies(force)
	if storage_state_is_valid then
		return
	end


	log("Info: execute: check_technologies() for force: " .. tostring(force.name))

	local technologies = force.technologies
	local recipes = force.recipes

	for _, technology in pairs(technologies) do
		if strings.has_suffix(technology.name, "apm_") or storage.apm.lib.technologies.list[technology.name] then
			technology.reload()

			local is_researched = technology.researched
			local is_enabled = technology.prototype.enabled

			if not technology.enabled and is_enabled then
				technology.enabled = true

				log("-> for force: " ..
					tostring(force.name) ..
					" state for: \"" .. tostring(technology.name) .. "\" changed to \"true\", technology is enabled.")
			end

			for _, effect in pairs(technology.prototype.effects) do
				if effect.type == "unlock-recipe" then
					local recipe = recipes[effect.recipe]

					if recipe.enabled ~= is_researched and is_enabled then
						recipe.enabled = is_researched

						log("-> for force: " ..
							tostring(force.name) ..
							" state for recipe: \"" ..
							tostring(recipe.name) .. "\" changed to \"" .. tostring(is_researched) .. "\"")
					elseif not is_enabled then
						recipe.enabled = false

						log("-> for force: " ..
							tostring(force.name) ..
							" state for recipe: \"" .. tostring(recipe.name) ..
							"\" changed to \"false\", technology is disabled.")
					end
				end
			end

			if is_researched and not is_enabled then
				technology.researched = false
				technology.enabled = false

				log("-> for force: " ..
					tostring(force.name) ..
					" state for: \"" .. tostring(technology.name) .. "\" changed to \"false\", technology is disabled.")
			end
		end
	end

	log("Info: finished: check_technologies() for force: " .. tostring(force.name))
end

---@param force LuaForce
local function check_recipes(force)
	log("Info: execute: check_recipes() for force: " .. tostring(force.name))

	for _, surface in pairs(game.surfaces) do
		local entities = surface.find_entities_filtered({ force = force, type = { "assembling-machine", "furnace" } })

		for _, entity in pairs(entities) do
			local recipe = entity.get_recipe()

			if recipe and not recipe.enabled and not strings.has_suffix(recipe.name, "creative-") then
				log("-> removed recipe: \"" ..
					tostring(recipe.name) ..
					"\" from \"" ..
					tostring(entity.name) ..
					"\" at position: " .. tostring(entity.position.x) .. "," .. tostring(entity.position.y))

				entity.set_recipe(nil)
			end
		end
	end

	log("Info: finished: check_recipes() for force: " .. tostring(force.name))
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function init.run()
	log("-------------------------------------------------------------")
	log("initial and update scripts")
	log("-------------------------------------------------------------")

	local force = game.forces.player

	force.reset_recipes()
	force.reset_technologies()

	activate_technologies_conditional_recipes(force)
	activate_technologies_conditional(force)
	check_technologies(force)
	check_recipes(force)
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
return init
