require('lib.utils.data_util')

local data_util = apm.bob_rework.lib.datautil

local graphics = '__apm_bob_rework_resource_pack_ldinc__/graphics/'

local collision_floor = {
    --"item-layer", -- stops player from dropping items on belts.
    "floor-layer",
    --"object-layer",
    "water-tile",
    "rail-layer"
}

local base = 'alt-rail'
local name = 'alt-curved-rail'

local curved_rail = table.deepcopy(data.raw["curved-rail"]["curved-rail"])
curved_rail.name = name
curved_rail.icon = graphics .. "icons/se/space-rail.png"
curved_rail.icon_size = 64
curved_rail.icon_mipmaps = 1
curved_rail.minable = { mining_time = 0.2, count = 4, result = base }
curved_rail.placeable_by = { count = 4, item = base }
curved_rail.collision_mask = collision_floor
curved_rail.fast_replaceable_group = "alt-curved-rail"
curved_rail.next_upgrade = nil

data_util.replace_filenames_recursive(curved_rail.pictures, "__base__/graphics/entity/curved-rail/hr-",
    graphics .. "entities/se/space-rail/hr/")
data_util.replace_filenames_recursive(curved_rail.pictures,
    "__base__/graphics/entity/rail-endings/hr-rail-endings-background.png",
    graphics .. "entities/se/space-rail/hr/rail-endings-background.png")
data_util.replace_filenames_recursive(curved_rail.pictures, "__base__/graphics/entity/curved-rail/",
    graphics .. "entities/se/space-rail/sr/")
data_util.replace_filenames_recursive(curved_rail.pictures,
    "__base__/graphics/entity/rail-endings/rail-endings-background.png",
    graphics .. "entities/se/space-rail/sr/rail-endings-background.png")

name = 'alt-straight-rail'
local straight_rail = table.deepcopy(data.raw["straight-rail"]["straight-rail"])
straight_rail.name = name
straight_rail.icon = graphics .. "icons/se/space-rail.png"
straight_rail.icon_size = 64
straight_rail.icon_mipmaps = 1
straight_rail.minable = {
    mining_time = 0.2,
    result = base,
}
straight_rail.placeable_by = { count = 1, item = base }
straight_rail.collision_mask = collision_floor
straight_rail.fast_replaceable_group = base
straight_rail.next_upgrade = nil
--data.raw["straight-rail"]["straight-rail"].next_upgrade = straight_rail.name

data_util.replace_filenames_recursive(straight_rail.pictures, "__base__/graphics/entity/straight-rail/hr-",
    graphics .. "entities/se/space-rail/hr/")
data_util.replace_filenames_recursive(straight_rail.pictures,
    "__base__/graphics/entity/rail-endings/hr-rail-endings-background.png",
    graphics .. "entities/se/space-rail/hr/rail-endings-background.png")
data_util.replace_filenames_recursive(straight_rail.pictures, "__base__/graphics/entity/straight-rail/",
    graphics .. "entities/se/space-rail/sr/")
data_util.replace_filenames_recursive(straight_rail.pictures,
    "__base__/graphics/entity/rail-endings/rail-endings-background.png",
    graphics .. "entities/se/space-rail/sr/rail-endings-background.png")

local rail_planner = table.deepcopy(data.raw["rail-planner"]["rail"])
local name = 'alt-rail'
rail_planner.name = name
rail_planner.curved_rail = curved_rail.name
rail_planner.straight_rail = straight_rail.name
rail_planner.place_result = straight_rail.name
rail_planner.localised_name = { "item-name.alt-rail" }
rail_planner.icon = graphics.."icons/se/space-rail.png"
rail_planner.icon_size = 64
rail_planner.icon_mipmaps = 1
rail_planner.subgroup = "train-transport"

data:extend({
    rail_planner,
    straight_rail,
    curved_rail,
})
