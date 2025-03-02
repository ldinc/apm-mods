if not apm.nuclear.helper then apm.nuclear.helper = {} end

---@param skiplist any
---@param prefix string
---@retutrn any
function apm.nuclear.helper.add_to_skiplist(skiplist, prefix)
	local techlist = apm.lib.utils.technology.find.by_prefix(prefix)

	if not skiplist then
		skiplist = {}
	end

	if techlist then
		for _, tech in ipairs(techlist) do
			skiplist[tech] = true
		end
	end

	return skiplist
end