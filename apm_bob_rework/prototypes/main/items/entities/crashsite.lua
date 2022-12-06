require('util')

local kr_crash_site_icons_path = '__apm_bob_rework_resource_pack_ldinc__/graphics/icons/krastorio/entities/crash-site/'

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {
    type = "item",
    name = "kr-crash-site-generator",
    localised_name = { "entity-name.kr-damaged-ship-reactor" },
    localised_description = { "entity-description.kr-crash-site-building" },
    icon = kr_crash_site_icons_path .. "crash-site-generator.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "crash-site",
    order = "x[crash-site-generator]",
    place_result = "kr-crash-site-generator",
    stack_size = 1,
    flags = { "hidden" },
}
data:extend({ item })

item = {
    type = "item",
    name = "kr-crash-site-lab-repaired",
    localised_name = { "entity-name.kr-damaged-ship-research-computer" },
    localised_description = { "entity-description.kr-crash-site-building" },
    icon = kr_crash_site_icons_path .. "crash-site-lab-repaired.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "crash-site",
    order = "x[crash-site-lab-repaired]",
    place_result = "kr-crash-site-lab-repaired",
    stack_size = 1,
    flags = { "hidden" },
}
data:extend({ item })

item = {
    type = "item",
    name = "kr-crash-site-assembling-machine-1-repaired",
    localised_name = { "entity-name.kr-damaged-ship-assembler" },
    localised_description = { "entity-description.kr-crash-site-building" },
    icon = kr_crash_site_icons_path .. "crash-site-assembling-machine-1-repaired.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "crash-site",
    order = "x[crash-site-assembling-machine-1-repaired]",
    place_result = "kr-crash-site-assembling-machine-1-repaired",
    stack_size = 1,
    flags = { "hidden" },
}
data:extend({ item })

item = {
    type = "item",
    name = "kr-crash-site-assembling-machine-2-repaired",
    localised_name = { "entity-name.kr-damaged-ship-assembler" },
    localised_description = { "entity-description.kr-crash-site-building" },
    icon = kr_crash_site_icons_path .. "crash-site-assembling-machine-2-repaired.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "crash-site",
    order = "x[crash-site-assembling-machine-2-repaired]",
    place_result = "kr-crash-site-assembling-machine-2-repaired",
    stack_size = 1,
    flags = { "hidden" },
}
data:extend({ item })

item = {
    type = "item",
    name = "kr-crash-site-chest-1",
    localised_name = { "entity-name.crash-site-chest-1" },
    localised_description = { "entity-description.kr-crash-site-building" },
    icon = kr_crash_site_icons_path .. "crash-site-chest.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "crash-site",
    order = "x[crash-site-chest]",
    place_result = "kr-crash-site-chest-1",
    stack_size = 1,
    flags = { "hidden" },
}
data:extend({ item })

item = {
    type = "item",
    name = "kr-crash-site-chest-2",
    localised_name = { "entity-name.crash-site-chest-2" },
    localised_description = { "entity-description.kr-crash-site-building" },
    icon = kr_crash_site_icons_path .. "crash-site-chest.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "crash-site",
    order = "x[crash-site-chest]",
    place_result = "kr-crash-site-chest-2",
    stack_size = 1,
    flags = { "hidden" },
}
data:extend({ item })
