require("prototypes.integrations.technologies.helpers")

return function(skiplist)
	skiplist = apm.nuclear.helper.add_to_skiplist(skiplist, "space-telescope-research")
	skiplist = apm.nuclear.helper.add_to_skiplist(skiplist, "stack-inserter-research")
	skiplist = apm.nuclear.helper.add_to_skiplist(skiplist, "Space-Lab-Research")
	skiplist = apm.nuclear.helper.add_to_skiplist(skiplist, "advanced-battery-research")
	skiplist = apm.nuclear.helper.add_to_skiplist(skiplist, "orbital-artillery-rangefinding")
	skiplist = apm.nuclear.helper.add_to_skiplist(skiplist, "orbital-prospecting")
	skiplist = apm.nuclear.helper.add_to_skiplist(skiplist, "robot-global-positioning-system")
	skiplist = apm.nuclear.helper.add_to_skiplist(skiplist, "advanced-fan-research")

	return skiplist
end
