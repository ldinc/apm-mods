apm.lib.utils.builder.recipe.update()

require("prototypes.main.entities-overwrites")
require("prototypes.main.item-overwrites")
require("prototypes.main.recipe-overwrites")
require("prototypes.main.equipment-overwrites")
require("prototypes.main.technologies-overwrites")
require("prototypes.integrations.updates")

if mods["space-age"] then
	apm.lib.utils.planet.add.resource("nauvis", "thorium-ore")
	-- local resource_autoplace = require("__core__.lualib.resource-autoplace")
	-- resource_autoplace.initialize_patch_set("thorium-ore", false)
end
