return function(skiplist)
	if not skiplist then
		skiplist = {}
	end

	local techlist = {
		"mining-productivity-3",
		"steel-plate-productivity"
	}

	if techlist then
		for _, tech in ipairs(techlist) do
			skiplist[tech] = true
		end
	end

	return skiplist
end
