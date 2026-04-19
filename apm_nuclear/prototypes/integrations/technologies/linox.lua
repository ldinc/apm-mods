return function(skiplist)
	local techlist = apm.lib.utils.technology.find.by_prefix("linox")

	if not skiplist then
		skiplist = {}
	end

	techlist["linox-technology_planet-discovery-linox"] = nil

	if techlist then
		for _, tech in ipairs(techlist) do
			skiplist[tech] = true
		end
	end

	return skiplist
end
