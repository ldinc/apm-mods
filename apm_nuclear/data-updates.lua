apm.lib.utils.builder.recipe.update()

require("prototypes.main.entities-overwrites")
require("prototypes.main.item-overwrites")
require("prototypes.main.recipe-overwrites")
require("prototypes.main.equipment-overwrites")
require("prototypes.main.technologies-overwrites")
require("prototypes.integrations.updates")

apm.lib.utils.planet.add.resource("nauvis", "thorium-ore")

--- [radiation resistance patch]
local armor = apm.lib.utils.armor
local R = armor.damage_type.radiation

armor.add_resistance("heavy-armor", R, 0, 10)
armor.add_resistance("modular-armor", R, 1, 15)
armor.add_resistance("power-armor", R, 3, 30)
armor.add_resistance("power-armor-mk2", R, 5, 50)

if mods["space-age"] then
	armor.add_resistance("mech-armor", R, 8, 60)
end
