return function(skiplist)
	local techlist = apm.lib.utils.technology.find.by_prefix("cerys")

	if not skiplist then
		skiplist = {}
	end

	skiplist["holmium-plate-productivity-1"] = true
	skiplist["holmium-plate-productivity-2"] = true

	if techlist then
		for _, tech in ipairs(techlist) do
			skiplist[tech] = true
		end
	end

	return skiplist
end
