--- [boblogistics]
if mods.boblogistics then
	local entity, ok = apm.lib.utils.entity.get.by_name("bob-steam-inserter", "inserter")

	if ok then
		apm.lib.utils.entity.del.next_upgrade(entity)
		apm.lib.utils.entity.set.hidden(entity)
	end
end
