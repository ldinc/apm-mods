---@diagnostic disable-next-line: different-requires
require("lib.features.migrations")

if not apm.lib.features.power.migrations_patches_enabled then
	return
end

---@param tech LuaTechnology
---@return boolean
local function try_research_technology(tech)
	for _, pred in pairs(tech.prerequisites) do
		if not pred.researched then
			return false
		end
	end

	for _, succ in pairs(tech.successors) do
		if succ.researched then
			tech.researched = true

			return true
		end
	end

	return false
end

---@param technologies table<string, LuaTechnology>
local function research_technologies(technologies)
	for key, tech in pairs(technologies) do
		if not tech.researched then
			local force_researched = try_research_technology(tech)

			if force_researched and APM_CAN_LOG_INFO then
				log(APM_MSG_INFO("migrations", "tech \"" .. key .. "\" has been force researched"))
			end
		end
	end
end

for _, force in pairs(game.forces) do
	local technologies = force.technologies

	research_technologies(technologies)
end
