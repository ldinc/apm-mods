require 'util'
require('lib.log')

local self = 'lib.utils.technology.trigger'

if not apm.lib.utils.technology.trigger then apm.lib.utils.technology.trigger = {} end
if not apm.lib.utils.technology.trigger.set then apm.lib.utils.technology.trigger.set = {} end

---comment
---@param technology_name string
---@param set_default_sp? boolean
function apm.lib.utils.technology.trigger.remove(technology_name, set_default_sp)
	if not apm.lib.utils.technology.exist(technology_name) then
		return
	end

	data.raw["technology"][technology_name].research_trigger = nil

	if set_default_sp then
		data.raw["technology"][technology_name].unit = apm.lib.utils.technology.unit.new(
			{"apm_industrial_science_pack"},
			1,
			1
		)
	end

end

---@param technology_name data.TechnologyID
---@return data.TechnologyTrigger?
function apm.lib.utils.technology.trigger.get(technology_name)
	if not apm.lib.utils.technology.exist(technology_name) then
		return nil
	end

	local trigger = data.raw["technology"][technology_name].research_trigger

	if trigger then
		return trigger
	end

	return nil
end

---@param technology_name data.TechnologyID
---@param trigger_item data.ItemID
---@param trigger_count? uint32
function apm.lib.utils.technology.trigger.set.craft_item(technology_name, trigger_item, trigger_count)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	apm.lib.utils.technology.unit.clear_all_by_ref(technology)

	---@type data.CraftItemTechnologyTrigger
	local trigger = {
		type = "craft-item",
		item = trigger_item,
	}

	if trigger_count then
		trigger.count = trigger_count
	end


	technology.research_trigger = trigger
end


---@param technology_name string
---@param trigger_item string
---@param trigger_count double
function apm.lib.utils.technology.trigger.set.craft_fluid(technology_name, trigger_item, trigger_count)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	apm.lib.utils.technology.unit.clear_all_by_ref(technology)

	---@type data.CraftFluidTechnologyTrigger
	local trigger = {
		type ="craft-fluid",
		fluid = trigger_item,
	}

	if trigger_count then
		trigger.amount = trigger_count
	end


	technology.research_trigger = trigger
end


---@param technology_name data.TechnologyID
---@param trigger_entity data.EntityID
function apm.lib.utils.technology.trigger.set.mine(technology_name, trigger_entity)
	if not apm.lib.utils.technology.exist(technology_name) then
		return
	end

	---@type data.MineEntityTechnologyTrigger
	local trigger = {
		type = "mine-entity",
		entity = trigger_entity,
	}

	data.raw["technology"][technology_name].unit = nil
	data.raw["technology"][technology_name].research_trigger = trigger
end
