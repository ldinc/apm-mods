if not aai then aai = {} end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

local aai_replace_list = {
	["burner-assembling-machine"] = "apm_assembling_machine_0",
	["motor"] = "apm_simple_engine",
}

---@param kind "created"|"respawn"|"ship"|"debris"
local function patch_list(kind)
	local interface = remote.interfaces["freeplay"]

	if not (interface and interface["get_" .. kind .. "_items"] and interface["set_" .. kind .. "_items"]) then
		return
	end

	---@diagnostic disable-next-line: param-type-mismatch
	local items = remote.call("freeplay", "get_" .. kind .. "_items") --[[@as table<string, integer>]]
	local changed = false

	for from, to in pairs(aai_replace_list) do
		local count = items[from]

		if count then
			items[from] = nil

			if to and prototypes.item[to] then
				items[to] = (items[to] or 0) + count
			end

			changed = true
		end
	end

	if changed then
		---@diagnostic disable-next-line: param-type-mismatch
		remote.call("freeplay", "set_" .. kind .. "_items", items)
	end
end

function aai.patch_starting_items()
	if not script.active_mods["aai-industry"] then
		return
	end

	if not settings.startup["apm_power_compat_earendel"] or not settings.startup["apm_power_compat_earendel"].value then
		return
	end

	for _, kind in pairs({ "created", "respawn", "ship", "debris" }) do
		patch_list(kind)
	end
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
return aai
