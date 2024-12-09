require "util"
require("lib.log")

local self = "lib.utils.reactor"

if apm.lib.utils.reactor.add == nil then apm.lib.utils.reactor.add = {} end
if apm.lib.utils.reactor.set == nil then apm.lib.utils.reactor.set = {} end
if apm.lib.utils.reactor.get == nil then apm.lib.utils.reactor.get = {} end

if apm.lib.utils.reactor.overhaul_exceptions == nil then apm.lib.utils.reactor.overhaul_exceptions = {} end
if apm.lib.utils.reactor.overhaul_exceptions.table == nil then apm.lib.utils.reactor.overhaul_exceptions.table = {} end

--- [reactor.overhaul_exceptions.add]
---@param reactor_name string
function apm.lib.utils.reactor.overhaul_exceptions.add(reactor_name)
	apm.lib.utils.reactor.overhaul_exceptions.table[reactor_name] = true
end

--- [reactor.overhaul_exceptions.remove]
---@param reactor_name string
function apm.lib.utils.reactor.overhaul_exceptions.remove(reactor_name)
	apm.lib.utils.reactor.overhaul_exceptions.table[reactor_name] = nil
end

--- [reactor.exist]
---@param reactor_name string
---@return boolean
function apm.lib.utils.reactor.exist(reactor_name)
	if data.raw.reactor[reactor_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING("exist()", "reactor with name: '" .. tostring(reactor_name) .. "' dosent exist."))
	end

	return false
end

--- [reactor.get.by_name]
---@param reactor_name string
---@return data.ReactorPrototype
---@return boolean
function apm.lib.utils.reactor.get.by_name(reactor_name)
	local reactor = data.raw.reactor[reactor_name]

	if reactor then
		return reactor, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING("exist()", "reactor with name: '" .. tostring(reactor_name) .. "' dosent exist."))
	end

	return {}, false
end

--- [reactor.get.fuel_categories]
---@param reactor_name string
---@return data.FuelCategory[]?
function apm.lib.utils.reactor.get.fuel_categories(reactor_name)
	local reactor, ok = apm.lib.utils.reactor.get.by_name(reactor_name)

	if not ok then
		return nil
	end

	if not reactor.energy_source then
		return nil
	end

	if reactor.energy_source.type == "burner" then
		if reactor.energy_source.fuel_categories then
			local rc = {}
			for _, fc in pairs(reactor.energy_source.fuel_categories) do
				table.insert(rc, { name = fc, type = "fuel-category" })
			end

			return rc
		end
	elseif reactor.energy_source.type == "fluid" then
		if reactor.energy_source.fluid_box.filter ~= nil then
			return { { name = reactor.energy_source.fluid_box.filter, type = "fluid" } }
		end
	end

	if reactor.energy_source.type == "burner" then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"get.fuel_categories()", "default 'burner' for: " .. tostring(reactor_name)
			))
		end

		return apm.lib.utils.fuel.get.default_category()
	elseif reactor.energy_source.type == "fluid" then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"get.fuel_categories()", "default 'fluid' for: " .. tostring(reactor_name)
			))
		end

		return apm.lib.utils.fuel.get.default_fluid_category()
	end

	return nil
end

--- [reactor.update_description]
---@param reactor_name string
function apm.lib.utils.reactor.update_description(reactor_name)
	local reactor, ok = apm.lib.utils.reactor.get.by_name(reactor_name)

	if not ok then
		return nil
	end

	if not reactor.energy_source then
		return nil
	end

	local fuel_categories = apm.lib.utils.reactor.get.fuel_categories(reactor_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(reactor, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(reactor, fuel_categories)
	end
end

--- [reactor.add.fuel_category]
---@param reactor_name string
---@param fuel_categorie data.FuelCategoryID
function apm.lib.utils.reactor.add.fuel_category(reactor_name, fuel_categorie)
	local reactor, ok = apm.lib.utils.reactor.get.by_name(reactor_name)

	if not ok then
		return nil
	end

	apm.lib.utils.entity.add.fuel_category(reactor, fuel_categorie)
end

--- [reactor.set.fuel_categories]
---@param reactor_name string
---@param fuel_categories data.FuelCategoryID|data.FuelCategoryID[]
function apm.lib.utils.reactor.set.fuel_categories(reactor_name, fuel_categories)
	local reactor, ok = apm.lib.utils.reactor.get.by_name(reactor_name)

	if not ok then
		return nil
	end

	apm.lib.utils.entity.set.fuel_category(reactor, fuel_categories)
end

--- [reactor.overhaul]
---@param reactor_name string
function apm.lib.utils.reactor.overhaul(reactor_name)
	local reactor, ok = apm.lib.utils.reactor.get.by_name(reactor_name)

	if not ok then
		return nil
	end

	if apm.lib.utils.reactor.overhaul_exceptions.table[reactor_name] then 
		return
	end

	local default_categories = apm.lib.utils.fuel.get.default_nuclear_category_ids()

	apm.lib.utils.entity.set.fuel_category(reactor, default_categories)
end
