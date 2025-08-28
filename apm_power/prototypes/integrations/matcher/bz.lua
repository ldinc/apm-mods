---@return boolean
return function()
	if
			mods["bzlead"] or
			mods["bzcarbon"] or
			mods["bzsilicon"] or
			mods["bzzirconium"] or
			mods["bztitanium"]
	then
		return true
	end

	return false
end
