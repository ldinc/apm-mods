local t = {
    processing = {
        alloy = 'alloy-processing',
        cobalt = 'cobalt-processing',
        titanium = 'titanium-processing',
        aluminium = 'aluminium-processing',
        titaniumAlloy = 'titanium-alloy-processing',
        zinc = 'zinc-processing',
        sulfur = 'sulfur-processing',
        lead = 'lead-processing',
        oil = {
            basic = 'oil-processing',
            advanced = 'advanced-oil-processing',
            extra = 'oil-processing-2'
        },
        coke = {
            I = 'apm_fuel-1',
            II = 'apm_fuel-2',
            III = 'apm_fuel-3',
            IV = 'apm_fuel-4',
        },
        planks = {
            I = 'apm_treated_wood_planks_1',
            II = 'apm_treated_wood_planks_2',
            III = 'apm_treated_wood_planks_3',
        },
    },

    science = {
        production = 'production-science-pack',
        automation = 'apm_power_automation_science_pack',
        chemical = 'chemical-science-pack',
        logistics = 'logistic-science-pack',
    },

    boiler = {
        electric = 'electric-boiler',
    },

    puddling = {furnace = 'apm_puddling_furnace_0'},

    crusher = {
        burner = 'apm_crusher_machine_0',
        steam = 'apm_crusher_machine_1',
        electric = 'apm_crusher_machine_2',
    },

    press = {
        burner = 'apm_press_machine_0',
        steam = 'apm_press_machine_1',
        electric = 'apm_press_machine_2',
    },

    sieve = {
        burner = 'apm_burner_sieve',
        steam = 'apm_sieve_0',
    },

    materials = {
        ceramics = 'ceramics',
        rubber = {
            basic= 'apm_rubber_1',
            vulcano = 'apm_rubber_2',
        },
        asphalt = {
            creosote = 'apm_asphalt_1',
            oil = 'apm_asphalt_2',
        }
    },

    fluid = {
        handling = {
            basic = 'fluid-handling',
        },
        control = {
            basic = 'apm_water_supply-1',
            advanced = 'apm_water_supply-2',
        }
    },

    logistics = {
        basic = 'logistics-0',
        yellow = 'logistics',
        rail = {
            ways = 'railway',
            stop = 'automated-rail-transportation',
            signals = 'rail-signals',
            advanced = 'alt-rail',
            nuclear = 'rampant-arsenal-technology-nuclear-railway',
        },
        automobile = {
            basic = 'automobilism',
            electric = 'automobilism_electric',
        },
        inserters = {
            red = 'fast-inserter',
        },
    },

    combat = {
        turret = {
            gun = {
                I = 'gun-turret',
            },
        },

        rocketry = 'rocketry',
        rocket = {
            silo = 'rocket-silo',
        },
    },

    electricity = 'apm_power_electricity',

    electronics = {
        basic = 'electronics',
        advanced = {
            I = 'advanced-electronics',
            II = 'advanced-electronics-2',
        },
    },

    automation = {
        electric = {
            basic = 'automation',
        },
    },

    electrolysis = {
        I = '',
        II = 'electrolysis-2',
    },

    battery = {
        lead = 'battery',
        liio = 'battery-2',
        agzn = 'battery-3',
    },

    nuclear = {
        breeder = 'apm_nuclear_breeder',
        uranium = 'nuclear-power',
        thorium = 'bob-nuclear-power-2',
        deuterium = 'bob-nuclear-power-3',
        ultimate = 'deuterium-fuel-cell-2',
        fuel = {
            reprocessing = 'nuclear-fuel-reprocessing',
        },
        synthesys = {
            plutonium = 'bobingabout-enrichment-process',
        },
    },

    ore = {
        crushing = {advanced = 'advanced-ore-crushing'},
        enrichment = {
            base = 'ore-enrichment',
            advanced = 'advanced-ore-enrichment',
        },
    },
}

return t