require("prototypes.integrations.technology")

-- generated techs must at least need the science packs of their prerequisites
-- (e.g. electric-engine needs chemical science without apm_power)
for _, technology_name in pairs({
	"automobilism_electric-1",
	"tanks_electric-1",
	"tanks_electric-2",
	"tanks_electric-3",
	"locomotive_electric",
	"vehicle-warden-2",
	"apm_electric_bob-railway-2",
	"apm_electric_bob-railway-3",
	"apm_electric_bob-armoured-railway",
	"apm_electric_bob-armoured-railway-2",
}) do
	apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites(technology_name)
end

apm.lib.utils.builder.recipe.update()

require("prototypes.tips")
