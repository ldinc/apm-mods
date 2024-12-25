return function()
	local techlist = apm.lib.utils.technology.find.by_prefix("cerys")

	local skiplist = {
		["holmium-plate-productivity-1"] = true,
		["holmium-plate-productivity-2"] = true,
	}

	if techlist then
		for _, tech in ipairs(techlist) do
			skiplist[tech] = true
		end
	end

	return skiplist
end
