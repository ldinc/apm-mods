---@return boolean
return function()
	if
			mods["bzlead"] or
			mods["bzcarbon"] or
			mods["bzsilicon"] or
			mods["bzzirconium"] or
			mods["bztitanium"] or
			mods["bzlead2"] or
			mods["bzcarbon2"] or
			mods["bzsilicon2"] or
			mods["bzzirconium2"] or
			mods["bztitanium2"]
	then
		return true
	end

	return false
end
