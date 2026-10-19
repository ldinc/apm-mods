if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.item.remove("charcoal")

if apm.lib.utils.item.exist("resin") then
	apm.lib.utils.item.remove("resin")
end
