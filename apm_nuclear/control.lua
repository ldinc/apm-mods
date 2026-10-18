-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function register_radioactive_items()
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_container_worn", 1)
	remote.call("apm_radiation", "add_item", "apm_breeder_container_worn", 1)

	remote.call("apm_radiation", "add_item", "apm_yellowcake", 1)
	remote.call("apm_radiation", "add_item", "apm_oxide_pellet_u235", 2)
	remote.call("apm_radiation", "add_item", "apm_oxide_pellet_th232", 1)
	remote.call("apm_radiation", "add_item", "apm_oxide_pellet_np237", 1)
	remote.call("apm_radiation", "add_item", "apm_oxide_pellet_pu239", 3)

	remote.call("apm_radiation", "add_item", "apm_fuel_rod_uranium", 1)
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_uranium_active", 3)
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_uranium_cooled", 2)

	remote.call("apm_radiation", "add_item", "apm_fuel_rod_mox", 2)
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_mox_active", 3)
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_mox_cooled", 2)

	remote.call("apm_radiation", "add_item", "apm_fuel_rod_neptunium", 1)
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_neptunium_active", 2)
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_neptunium_cooled", 1)

	remote.call("apm_radiation", "add_item", "apm_breeder_uranium", 1)
	remote.call("apm_radiation", "add_item", "apm_breeder_uranium_loaded", 2)
	remote.call("apm_radiation", "add_item", "apm_breeder_uranium_active", 3)
	remote.call("apm_radiation", "add_item", "apm_breeder_uranium_cooled", 2)
	remote.call("apm_radiation", "add_item", "apm_breeder_uranium_seperated", 2)

	remote.call("apm_radiation", "add_item", "apm_fuel_rod_thorium", 1)
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_thorium_active", 3)
	remote.call("apm_radiation", "add_item", "apm_fuel_rod_thorium_cooled", 2)

	remote.call("apm_radiation", "add_item", "apm_breeder_thorium", 1)
	remote.call("apm_radiation", "add_item", "apm_breeder_thorium_loaded", 2)
	remote.call("apm_radiation", "add_item", "apm_breeder_thorium_active", 3)
	remote.call("apm_radiation", "add_item", "apm_breeder_thorium_cooled", 2)
	remote.call("apm_radiation", "add_item", "apm_breeder_thorium_seperated", 2)

	remote.call("apm_radiation", "add_item", "apm_radioactive_waste", 1)
end


-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function register_burner_equipment()
	for equipment_name, equipment in pairs(prototypes.equipment) do
		if equipment.burner_prototype then
			remote.call("apm_equipment", "add_burner_equipment", equipment_name)
		end
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function add_thorium_to_nauvis()
	local surface = game.surfaces["nauvis"]

	if not surface or not prototypes.entity["thorium-ore"] then
		return
	end

	local settings = surface.map_gen_settings
	local changed = false

	settings.autoplace_controls = settings.autoplace_controls or {}

	if prototypes.autoplace_control["thorium-ore"] and not settings.autoplace_controls["thorium-ore"] then
		settings.autoplace_controls["thorium-ore"] = { frequency = 1, size = 1, richness = 1 }
		changed = true
	end

	settings.autoplace_settings = settings.autoplace_settings or {}

	local entity = settings.autoplace_settings["entity"] or { settings = {} }

	entity.settings = entity.settings or {}

	if not entity.settings["thorium-ore"] then
		entity.settings["thorium-ore"] = { frequency = 1, size = 1, richness = 1 }
		settings.autoplace_settings["entity"] = entity
		changed = true
	end

	if changed then
		surface.map_gen_settings = settings

		log("apm_nuclear: thorium-ore added to the map generation of nauvis (new chunks only)")
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_init()
	register_radioactive_items()
	register_burner_equipment()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_load()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_update()
	register_radioactive_items()
	register_burner_equipment()
	add_thorium_to_nauvis()
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
script.on_init(on_init)
script.on_load(on_load)
script.on_configuration_changed(on_update)
