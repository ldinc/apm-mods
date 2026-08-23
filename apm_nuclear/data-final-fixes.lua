require("prototypes.integrations.items")
require("prototypes.integrations.categories")
require("prototypes.integrations.technologies")
require("prototypes.integrations.recipes")
require("prototypes.integrations.entities")
require("prototypes.integrations.disable")
require("prototypes.integrations.fuel_categories")
require("prototypes.integrations.equipment")
require("prototypes.integrations.icon-overwrites")
require("prototypes.integrations.final-overwrites")

apm.lib.utils.builder.recipe.update()


apm.lib.utils.technology.overwrite.science_pack_order_strings("science-pack")
apm.lib.utils.technology.overwrite.lab_science_pack_order()
