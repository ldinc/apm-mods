local trigger_item = "hot-steel-plate"
local _, ok = apm.lib.utils.item.get_by_name(trigger_item)

if ok then
  apm.lib.utils.technology.trigger.set.craft_item("steam-power", trigger_item, 50)
end
