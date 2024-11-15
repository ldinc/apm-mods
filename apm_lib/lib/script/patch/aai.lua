if not aai then aai = {} end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function replace_aai_burner_assembling_machine()
	local surface = game.surfaces["nauvis"]
	local range = 20
	local containers = surface.find_entities_filtered { type = "container", area = { { -range, -range }, { range, range } } }
	for _, container in pairs(containers) do
		local inventory = container.get_inventory(defines.inventory.chest)
		if not inventory then
			goto continue
		end

		local content = inventory.get_contents()
		for _, item in pairs(content) do
			if item.name == 'burner-ore-crusher' then
				if settings.startup['apm_power_compat_angel'].value then
					if script.active_mods['angelsrefining'] then
						inventory.remove({ name = item.name, count = item.count })
						inventory.insert({ name = "apm_crusher_machine_0", count = item.count * 2 })
					end
				end
			end
			if item.name == 'burner-assembling-machine' then
				inventory.remove({ name = item.name, count = item.count })
				inventory.insert({ name = 'apm_assembling_machine_0', count = 1 })
			end
		end
		::continue::
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function aai.on_tick()
	if game.tick > 2 then return end
	if game.tick == 2 then
		if settings.startup['apm_power_compat_earendel'].value then
			if script.active_mods['aai-industry'] then
				if settings.global['crash-sequence'].value then
					replace_aai_burner_assembling_machine()
				end
			end
		end
	end
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
return aai
