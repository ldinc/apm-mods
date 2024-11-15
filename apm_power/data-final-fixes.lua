require('prototypes.integrations.fuel')
require('prototypes.integrations.overwrites')
require('prototypes.integrations.technologies')
require('prototypes.integrations.recipes')
require('prototypes.integrations.items')
require('prototypes.integrations.entities')
require('prototypes.integrations.bots')
require('prototypes.integrations.recipe-categories')
require('prototypes.integrations.icons')
require('prototypes.integrations.tiles')
require('prototypes.integrations.final-overwrites')
require('prototypes.integrations.patches')
--require('prototypes.power.map-gen-presets')

-- generate recipies for sinkhole

local amount = tonumber(settings.startup["apm_sinkhole_fluid_rate"].value)

if not amount then
  amount = 1
end


local get_icons = function(prototype)
  if prototype.icons then
    return table.deepcopy(prototype.icons)
  else
    return {{
      icon = prototype.icon,
      icon_size = prototype.icon_size,
      icon_mipmaps = prototype.icon_mipmaps
    }}
  end
end

for k, v in pairs(data.raw.fluid) do
    local newicons = get_icons(v)
    -- table.insert(newicons, no_icon)
    data:extend({
      {
        type = "recipe",
        name = v.name.."-sinkhole",
        category = "apm_sinkhole",
        subgroup = "fluid-recipes",
        enabled = true,
        hidden = true,
        energy_required = 20,
        ingredients =
        {
          {type="fluid", name=v.name, amount=amount}
        },
        results = {},
        icons = newicons,
        icon_size = 32,
        order = "z[sinkhole]"
      }
    })
end