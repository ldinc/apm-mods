-- steam sieve

local newTech = function(mod_name, technology, t_prerequisites, t_recipes, t_research_packs, i_research_count, i_research_time, iconpath)
    new = {}
    new.type = 'technology'
    new.name = technology
    new.icon = iconpath
    new.icon_size = 128
    new.effects = {}
    if t_recipes ~= nil then
        for _, name in pairs(t_recipes) do
            table.insert(new.effects, {type = 'unlock-recipe', recipe = name})
        end
    end
    new.prerequisites = t_prerequisites
    new.unit = {}
    new.unit.count = i_research_count
    new.unit.ingredients = t_research_packs
    new.unit.time = i_research_time
    new.order = 'a-a-a'
    data:extend({new})
end


newTech(
    'apm_power',
    'apm_burner_sieve',
    {'apm_coking_plant_1'},
    {'apm_burner_sieve', 'apm_dry_mud', 'apm_sieve_iron', 'apm_dry_mud_sifting_iron', 'apm_sieve_copper', 'apm_dry_mud_sifting_copper'},
    {{"apm_industrial_science_pack", 1}},
    25, 10,
    "__apm_bob_rework_ldinc__/graphics/tech/burner-sieve.png"
)

newTech(
    'apm_power',
    'kr-tesla-coil',
    {'apm_power_electricity'},
    {'kr-tesla-coil','energy-absorber'},
    {{"apm_industrial_science_pack", 1}},
    40, 10,
    "__apm_bob_rework_ldinc__/graphics/tech/krastorio/tesla-coil.png"
)

newTech(
    'apm_power',
    'kr-wind-turbine',
    {'apm_power_electricity'},
    {'kr-wind-turbine'},
    {{"apm_industrial_science_pack", 1}},
    40, 10,
    "__apm_bob_rework_ldinc__/graphics/tech/krastorio/wind-turbine.png"
)