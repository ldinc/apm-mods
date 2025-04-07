if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.utils then apm.lib.utils = {} end
if not apm.lib.utils.debug then apm.lib.utils.debug = {} end
if not apm.lib.utils.debug.check then apm.lib.utils.debug.check = {} end

--- TODO: Add code for tech debug and check hidden items


local deps_products_check = function(products, required_products)
	local diff = {}

	for name, _ in pairs(required_products) do
		if not products[name] then
			diff[name] = {}
		end
	end

	return diff
end

function apm.lib.utils.debug.check.products()
	game.player.print("Note: use only on start")


	---@type  TechnologyPrototypeFilter
	local roots_filter = {
		filter = "has-prerequisites",
		invert = true
	}

	local roots = prototypes.get_technology_filtered { roots_filter }

	game.player.print("Total t-roots: " .. tostring(#roots))

	local recipes = prototypes.get_recipe_filtered {}


	game.player.print("Total enabled recipes: " .. tostring(#recipes))

	local products = {
		["ammoniacal-solution"] = { from = { "default" } },
		["fluorine"] = { from = { "default" } },
		["lava"] = { from = { "default" } },
		["lithium-brine"] = { from = { "default" } },
	}

	local raw = prototypes.get_item_filtered {
		{
			filter = "subgroup",
			subgroup = "raw-resource",
			mode = "and"
		},
		{
			filter = "hidden",
			invert = true
		}
	}

	for name, r in pairs(raw) do
		products[name] = { from = { "raw-resource" } }
	end

	local required_products = {}

	local all_recipes = recipes

	local handle_recipe = function(recipe_name)
		local recipe = all_recipes[recipe_name]

		if not recipe then
			log("skipped recipe " .. recipe_name)

			return
		end

		local deps = {}

		for _, ingredient in ipairs(recipe.ingredients) do
			table.insert(deps, ingredient.name)
		end

		if #recipe.products > 0 then
			for _, dep in ipairs(deps) do
				if not required_products[dep] then
					required_products[dep] = {}
				end
			end

			for _, value in ipairs(recipe.products) do
				local pname = value.name
				if not products[pname] then products[pname] = { from = {}, deps = {} } end

				table.insert(products[pname].from, recipe.name)


				if #deps > 0 then
					if not products[pname].deps then products[pname].deps = {} end

					table.insert(products[pname].deps, table.deepcopy(deps))
				end
			end
		end
	end

	for _, recipe in pairs(recipes) do
		handle_recipe(recipe.name)
	end

	local tqueue = {}

	for name, tech in pairs(roots) do
		tqueue[name] = tech
	end

	for tname, _ in pairs(tqueue) do
		log(serpent.block(tname))

		local tech = prototypes.technology[tname]

		if tech.successors then
			for sname, stech in pairs(tech.successors) do
				if not stech.hidden then
					tqueue[sname] = stech
				end
			end
		end

		if tech.effects then
			for _, effect in ipairs(tech.effects) do
				if effect.type == "unlock-recipe" then
					local recipe_name = effect.recipe

					handle_recipe(recipe_name)
				end
			end
		end
	end

	local failed = deps_products_check(products, required_products)
	game.player.print("Total failed: " .. tostring(#failed))

	log(serpent.block(failed))

	-- log(serpent.block(products))
	-- log(serpent.block(required_products))
end
