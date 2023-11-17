function fillAPMReworkConfig(config)
	
	-- BobOres
	-- up the stone at start
	config["stone"].allotment = 80
	config["stone"].starting.richness = 14000
	config["stone"].richness = 15000
	
	local function checkOre(name)
		local data = game.entity_prototypes[name]
		if data and data.autoplace_specification then
			return true
		end
		return false
	end

    if checkOre("sulfur") then
        config["sulfur"] = {
            type="resource-ore",
            
            allotment=40,
            spawns_per_region={min=1, max=1},
            richness=8000,
            size={min=10, max=20},
            min_amount = 250,

            starting={richness=6000, size=15, probability=1},

            multi_resource_chance=0.20,
            multi_resource={
                ["lead-ore"] = 3,
                ["tin-ore"] = 3,
                ["tungsten-ore"] = 3,
                ["rutile-ore"] = 3,
            }
        }
    end

    if checkOre("zinc-ore") then
		config["zinc-ore"] = {
			type="resource-ore",
			
			allotment=60,
			spawns_per_region={min=1, max=1},
			richness=8000,
			size={min=10, max=20},
			min_amount = 250,

            starting={richness=6000, size=15, probability=1},

			multi_resource_chance=0.20,
			multi_resource={
				["lead-ore"] = 3,
				["silver-ore"] = 3,
				["gold-ore"] = 3,
				["tin-ore"] = 3,
				["tungsten-ore"] = 3,
				["bauxite-ore"] = 3,
			}
		}
	end
end