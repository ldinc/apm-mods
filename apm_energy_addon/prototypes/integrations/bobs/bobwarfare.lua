local generate = function()
	---@type boolean
	local apm_energy_addon_always_show_made_in = false

	local v = settings.startup["apm_energy_addon_always_show_made_in"].value

	if type(v) == "boolean" then
		apm_energy_addon_always_show_made_in = v
	end

	apm.energy_addon.generate_electric_powered("bob-tank-2")

	---@type data.RecipePrototype
	local recipe = {
		type = "recipe",
		name = "apm_electric_bob-tank-2",

		enabled = false,
		energy_required = 0.5,
		ingredients = {
			{ type = "item", name = "apm_electric_tank",    amount = 1 },
			{ type = "item", name = "electric-engine-unit", amount = 24 },
			apm.lib.utils.builder.recipe.item.simple("APM_CIRCUIT_T5", 20)
		},
		results = {
			{ type = "item", name = "apm_electric_bob-tank-2", amount = 1 }
		},
		main_product = "apm_electric_bob-tank-2",
		requester_paste_multiplier = 4,
		always_show_products = true,
		always_show_made_in = apm_energy_addon_always_show_made_in,
	}

	data:extend({ recipe })

	---@type data.TechnologyPrototype
	local technology = {
		type = "technology",
		name = "tanks_electric-2",
		icon = "__base__/graphics/technology/tank.png",
		icon_size = 256,
		icon_mipmaps = 4,
		effects = {
			{ type = "unlock-recipe", recipe = recipe.name },
		},
		prerequisites = { "bob-tanks-2", "electric-engine", "battery" },
		unit = {
			count = 125,
			ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 }, { "military-science-pack", 1 }, { "chemical-science-pack", 1 } },
			time = 30,
		},
		order = "aa_a",
	}

	data:extend({ technology })

	--
	-- ==========================================================================================
	--

	apm.energy_addon.generate_electric_powered("bob-tank-3")

	---@type data.RecipePrototype
	local recipe = {
		type = "recipe",
		name = "apm_electric_bob-tank-3",

		enabled = false,
		energy_required = 0.5,
		ingredients = {
			{ type = "item", name = "apm_electric_bob-tank-2", amount = 1 },
			{ type = "item", name = "electric-engine-unit",    amount = 24 },
			apm.lib.utils.builder.recipe.item.simple("APM_CIRCUIT_T6", 20)
		},
		results = {
			{ type = "item", name = "apm_electric_bob-tank-3", amount = 1 }
		},
		main_product = "apm_electric_bob-tank-3",
		requester_paste_multiplier = 4,
		always_show_products = true,
		always_show_made_in = apm_energy_addon_always_show_made_in,
	}

	data:extend({ recipe })

	---@type data.TechnologyPrototype
	local technology = {
		type = "technology",
		name = "tanks_electric-3",
		icon = "__base__/graphics/technology/tank.png",
		icon_size = 128,
		effects = {
			{ type = "unlock-recipe", recipe = recipe.name },
		},
		prerequisites = { "bob-tanks-3", "electric-engine", "battery" },
		unit = {
			count = 175,
			ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 }, { "military-science-pack", 1 }, { "chemical-science-pack", 1 }, { "utility-science-pack", 1 } },
			time = 30,
		},
		order = "aa_a"
	}

	data:extend({ technology })

	--
	-- ==========================================================================================
	--

	local o_name = "bob-antron"
	-- local e_name = "apm_electric_" .. o_name

	apm.energy_addon.generate_electric_powered_spidertron(o_name)
	apm.energy_addon.generate_electric_spidertron_new_recipe(o_name)
	apm.energy_addon.generate_electric_spidertron_new_tech(o_name, "bob-walking-vehicle")

	o_name = "bob-tankotron"
	apm.energy_addon.generate_electric_powered_spidertron(o_name)
	apm.energy_addon.generate_electric_spidertron_new_recipe(o_name)
	apm.energy_addon.generate_electric_spidertron_new_tech(o_name, o_name)

	o_name = "bob-logistic-spidertron"
	apm.energy_addon.generate_electric_powered_spidertron(o_name)
	apm.energy_addon.generate_electric_spidertron_new_recipe(o_name)
	apm.energy_addon.generate_electric_spidertron_new_tech(o_name, o_name)
end

return {
	generate = generate,
}
