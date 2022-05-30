local table = require("__flib__.table")

-- Make anything with an equipment grid of the correct category be detected by tesla coils
local types_have_grid = {
  "artillery-wagon",
  "car",
  "cargo-wagon",
  "character",
  "fluid-wagon",
  "locomotive",
  "spider-vehicle",
}
local grids = data.raw["equipment-grid"]
for _, type in pairs(types_have_grid) do
  for _, prototype in pairs(data.raw[type]) do
    if type ~= "character" then
      local grid = grids[prototype.equipment_grid]
      if not grid or (not table.find(grid.equipment_categories, "vehicle") and not table.find(grid.equipment_categories, "armor")) then
        goto continue
      end
    end

    local mask = prototype.trigger_target_mask
    if not mask then
      if type == "character" then
        mask = { "common", "ground-unit" }
      else
        mask = {}
      end
    end

    prototype.trigger_target_mask = mask
    table.insert(mask, "kr-tesla-coil-trigger")

    ::continue::
  end
end

-- Make trains targetable by tesla coils
local types_are_military = {
  "locomotive",
  "apm_electric_locomotive",
  "bob-locomotive-2",
  "apm_electric_bob-locomotive-2",
  "bob-locomotive-3",
  "apm_electric_bob-locomotive-3",
  "bob-armoured-locomotive",
  "apm_electric_bob-armoured-locomotive",
  "bob-armoured-locomotive-2",
  "apm_electric_bob-armoured-locomotive-2",
  "nuclear-train-vehicle-rampant-arsenal",
  "cargo-wagon", -- TODO: add wagons here
  "fluid-wagon",
  "artillery-wagon",
}
for _, type in pairs(types_are_military) do
  local t = data.raw[type]
  if t then
    for _, prototype in pairs(t) do
      prototype.is_military_target = true
    end
  end
end
