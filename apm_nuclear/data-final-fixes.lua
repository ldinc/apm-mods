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

-- Normalize the science pack display: all packs from the order map are moved
-- into the vanilla "science-pack" subgroup and get their order string from the
-- map, so the technology and lab GUIs show the intended progression.
apm.lib.utils.technology.overwrite.science_pack_order_strings("science-pack")

-- The lab GUI shows the packs of a lab in the order of its inputs array.
apm.lib.utils.technology.overwrite.lab_science_pack_order()
