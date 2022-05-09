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

local amount = settings.startup["apm_sinkhole_fluid_rate"].value

for k, v in pairs(data.raw.fluid) do
    local newicons = get_icons(v)
    table.insert(newicons, no_icon)
    data:extend({
      {
        type = "recipe",
        name = v.name.."-sinkhole",
        category = "apm_sinkhole",
        subgroup = "fluid-recipes",
        enabled = true,
        hidden = false,
        energy_required = 1,
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