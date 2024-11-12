require 'util'
require('lib.log')

local self = 'lib.utils.technology.trigger'

if not apm.lib.utils.technology.trigger then apm.lib.utils.technology.trigger = {} end
if not apm.lib.utils.technology.trigger.set then apm.lib.utils.technology.trigger.set = {} end



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
	if not apm.lib.utils.technology.exist(technology_name) then
		return
	end

	---@type data.CraftItemTechnologyTrigger
	local trigger = {
		type = "craft-item",
		item = trigger_item,
	}

	if trigger_count then
		trigger.count = trigger_count
	end

	local old_trigger = apm.lib.utils.technology.trigger.get(technology_name)

	if not old_trigger then
		data.raw["technology"][technology_name].research_trigger = trigger

		return
	end

	if old_trigger.type ~= "craft-item" then
		--TODO: drop old properly & set new???
		data.raw["technology"][technology_name].research_trigger = trigger

		return
	end

	data.raw["technology"][technology_name].research_trigger.item = trigger.item
	data.raw["technology"][technology_name].research_trigger.count = trigger.count
	data.raw["technology"][technology_name].research_trigger.item_quality = trigger.item_quality
end
