local alloys = require "lib.entities.alloys"
local t = require "lib.tier.base"
local plates = require "lib.entities.plates"
local tint   = require "lib.entities.tint"
local tech   = require "lib.entities.tech"
local materials = require "lib.entities.materials"

deadlock.add_tier({
	transport_belt      = "basic-transport-belt",
	colour              = {r=105, g=105, b=105},
	underground_belt    = "basic-underground-belt",
	splitter            = "basic-splitter",
	technology          = "logistics-0",
	order               = "a",
	loader_ingredients  = {
		{t.gray.belt, 1},
		{t.gray.constructionAlloy, 1},
		{t.gray.logic, 1},
	},
	beltbox_ingredients = {
		{t.gray.belt, 2},
		{t.gray.constructionAlloy, 2},
		{t.gray.gearWheel, 2},
		{t.gray.logic, 4},
	},
	beltbox_technology  = "logistics-0",
})
if data.raw["loader-1x1"]["basic-transport-belt-loader"] then
	data.raw["loader-1x1"]["basic-transport-belt-loader"].next_upgrade = "transport-belt-loader"
end

-- tier 1
deadlock.add_tier({
	transport_belt      = "transport-belt",
	colour              = {r=210, g=180, b=80},
	underground_belt    = "underground-belt",
	splitter            = "splitter",
	technology          = "logistics",
	order               = "a",
	loader_ingredients  = {
		{t.yellow.belt, 1},
		{t.yellow.constructionAlloy, 1},
		{t.yellow.logic, 1},
	},
	beltbox_ingredients = {
		{t.yellow.belt, 2},
		{t.yellow.constructionAlloy, 2},
		{t.yellow.gearWheel, 2},
		{t.yellow.logic, 4},
	},
	beltbox_technology  = "logistics",
})
if data.raw["loader-1x1"]["transport-belt-loader"] then
	data.raw["loader-1x1"]["transport-belt-loader"].next_upgrade = "fast-transport-belt-loader"
end
if data.raw.furnace["transport-belt-beltbox"] then
	data.raw.furnace["transport-belt-beltbox"].next_upgrade = "fast-transport-belt-beltbox"
end

-- tier 2
deadlock.add_tier({
	transport_belt      = "fast-transport-belt",
	colour              = {r=210, g=60, b=60},
	underground_belt    = "fast-underground-belt",
	splitter            = "fast-splitter",
	technology          = "logistics-2",
	order               = "b",
	loader_ingredients  = {
		{t.red.belt, 1},
		{t.red.constructionAlloy, 1},
		{t.red.logic, 1},
	},
	beltbox_ingredients = {
		{t.red.belt, 2},
		{t.red.constructionAlloy, 2},
		{t.red.gearWheel, 2},
		{t.red.logic, 4},
	},
	beltbox_technology  = "logistics-2",
})
if data.raw.technology["deadlock-stacking-2"] then
	table.insert(data.raw.technology["deadlock-stacking-2"].prerequisites, "deadlock-stacking-1")
end
if data.raw["loader-1x1"]["fast-transport-belt-loader"] then
	data.raw["loader-1x1"]["fast-transport-belt-loader"].next_upgrade = "express-transport-belt-loader"
end
if data.raw.furnace["fast-transport-belt-beltbox"] then
	data.raw.furnace["fast-transport-belt-beltbox"].next_upgrade = "express-transport-belt-beltbox"
end

-- tier 3
deadlock.add_tier({
	transport_belt      = "express-transport-belt",
	colour              = {r=80, g=180, b=210},
	underground_belt    = "express-underground-belt",
	splitter            = "express-splitter",
	technology          = "logistics-3",
	order               = "c",
	loader_ingredients  = {
		{t.blue.belt, 1},
		{t.blue.constructionAlloy, 1},
		{t.blue.logic, 1},
	},
	beltbox_ingredients = {
		{t.blue.belt, 2},
		{t.blue.constructionAlloy, 2},
		{t.blue.gearWheel, 2},
		{t.blue.logic, 4},
	},
	beltbox_technology  = "logistics-3",
})
if data.raw.technology["deadlock-stacking-3"] then
	table.insert(data.raw.technology["deadlock-stacking-3"].prerequisites, "deadlock-stacking-2")
end

-- disable electricity
local up = function (name, pollution, speed)
	local entity = data.raw.furnace[name]

	if entity then
		entity.energy_source = {
			type = "void",
			emissions_per_minute = pollution,
			fluid_box = {}
		}
		
		entity.crafting_speed = speed
	end
end

up('basic-transport-belt-beltbox', 3, 1)
up('transport-belt-beltbox', 2, 2)
up('fast-transport-belt-beltbox', 1, 3)
up('express-transport-belt-beltbox', 0, 4)

local push = apm.lib.utils.technology.add.recipe_for_unlock

-- push('logistics', 'transport-belt-beltbox')
-- push('logistics-2', 'fast-transport-belt-beltbox')
-- push('logistics-3', 'express-transport-belt-beltbox')

-- push('logistics', 'transport-belt-loader')
-- push('logistics-2', 'fast-transport-belt-loader')
-- push('logistics-3', 'express-transport-belt-loader')

local categoryMap = {
	["stacking"] = true,
	["unstacking"]= true,
}

for _, recipe in pairs(data.raw.recipe) do
	if categoryMap[recipe.category] then
		apm.lib.utils.recipe.disable(recipe.name)
	end
end

-- rewrite recipies
local stackSize = 25
local k = 5
local energyRequired = 1

local makeStackAndUnstack = function (product, tech, localised_name)
	local ico = {
        icon = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/plates/"..product..".png",
        icon_size = 64,
    }

	local pico = {
		icon = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/plates/pack.png",
		icon_size = 64,
	}

	local upico = {
		icon = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/plates/unpack.png",
		icon_size = 64,
	}

	local name = "apm_"..product.."_stack"
	if product == 'apm_dry_mud' then
		name = 'apm_dry_mud_stack'
	end


	local item = {}
    item.type = 'item'
    item.name = name
    item.icons = {ico}
    item.stack_size = 200/stackSize
    -- item.group = "raw-material"
    item.subgroup = "raw-material"
    item.order = 'ab_i'
    data:extend({item})

	local pack = {
		type = "recipe",
		category = "stacking",
		name = name.."_pack",
		icons = apm.lib.utils.icon.merge({{ico}, {pico}}),
		subgroup = "raw-material",

		normal = {
			enabled = false,
			energy_required = energyRequired,
			ingredients  = {
				{type = "item", name = product, amount = stackSize},
			},
			results = {
				{type = "item", name = name, amount = k},
			},
			main_product = name,
			requester_paste_multiplier = 1,
			always_show_products = true,
		},
	}
	pack.expensive = table.deepcopy(pack.normal)

	local unpack = {
		type = "recipe",
		category = "stacking",
		name = name.."_unpack",
		icons = apm.lib.utils.icon.merge({{ico}, {upico}}),
		subgroup = "raw-material",

		normal = {
			enabled = false,
			energy_required = energyRequired,
			ingredients  = {
				{type = "item", name = name, amount = k},
			},
			results = {
				{type = "item", name = product, amount = stackSize},
			},
			main_product = product,
			requester_paste_multiplier = 1,
			always_show_products = true,
		},
	}
	unpack.expensive = table.deepcopy(unpack.normal)

	local unpackByHands = {
		type = "recipe",
		category = "apm_handcrafting_only",
		name = name.."_unpack_by_hands",
		icons = apm.lib.utils.icon.merge({{ico}, {upico}, {apm.lib.icons.dynamics.t1}}),
		subgroup = "raw-material",

		normal = {
			enabled = false,
			energy_required = 0.1,
			ingredients  = {
				{type = "item", name = name, amount = k},
			},
			results = {
				{type = "item", name = product, amount = stackSize},
			},
			main_product = product,
			requester_paste_multiplier = 1,
			always_show_products = true,
		},
	}
	unpackByHands.expensive = table.deepcopy(unpack.normal)

	data:extend({ pack })
	data:extend({ unpack })
	data:extend({ unpackByHands })

	apm.lib.utils.technology.add.recipe_for_unlock(tech, pack.name)
	apm.lib.utils.technology.add.recipe_for_unlock(tech, unpack.name)
	apm.lib.utils.technology.add.recipe_for_unlock(tech, unpackByHands.name)

	if localised_name == '' or localised_name == nil then
		localised_name = product
	end


	apm.lib.utils.item.overwrite.localised_name(name, "Stack of "..localised_name)
	apm.lib.utils.recipe.overwrite.localised_name(pack.name, "Pack to stack "..localised_name)
	apm.lib.utils.recipe.overwrite.localised_name(unpack.name, "Unpack from stack "..localised_name)
	apm.lib.utils.recipe.overwrite.localised_name(unpackByHands.name, "Unpack from stack "..localised_name.." by hands")
end

-- starting plates & alloys
makeStackAndUnstack(plates.iron, tech.logistics.basic, "iron plates")
makeStackAndUnstack(plates.copper, tech.logistics.basic, "copper plates")

-- tin, bronze, lead
makeStackAndUnstack(plates.tin, tech.logistics.basic, "tin plates")
makeStackAndUnstack(plates.lead, tech.logistics.basic, "lead plates")
makeStackAndUnstack(alloys.bronze, tech.logistics.basic, "bronze plates")

-- zinc
makeStackAndUnstack(plates.zinc, tech.coking.plant.basic, "zinc plates")

-- brass
makeStackAndUnstack(alloys.brass, tech.processing.zinc, "brass plates")

-- steel
makeStackAndUnstack(plates.steel, tech.puddling.furnace, "steel")

-- plastic bar
makeStackAndUnstack(materials.plastic, tech.electrolysis.II, "plastic bars")

-- tungsten
makeStackAndUnstack(plates.tungsten, tech.processing.tungsten, "tungsten")

-- copper-tungsten-plate
makeStackAndUnstack(alloys.copper.tungsten, tech.processing.tungstenAlloy, "copper tungsten")

-- aluminium-plate
makeStackAndUnstack(plates.aluminium, tech.processing.aluminium, "aluminium plates")
makeStackAndUnstack(alloys.titanium, tech.processing.titaniumAlloy, "titanium alloys")

makeStackAndUnstack(plates.titanium, tech.processing.titanium, "titanium")

makeStackAndUnstack(alloys.cobalt.steel, tech.processing.cobalt, "cobalt steel")

makeStackAndUnstack(alloys.invar, tech.processing.invar, "invar")

makeStackAndUnstack(alloys.tungstenCarbide, tech.processing.tungstenAlloy, "tungsten alloys")

-- make stacks for dty mud
makeStackAndUnstack(materials.mud.dry, tech.sieve.burner, "dry mud")