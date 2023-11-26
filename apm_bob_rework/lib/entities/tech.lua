local t = {
    buff = {
        hp = {
            I = 'rampant-arsenal-technology-character-health-1',
        },
    },

    military = {
        I = 'military',
        II = 'military-2',
    },

    processing = {
        alloy = 'alloy-processing',
        invar = 'invar-processing',
        cobalt = 'cobalt-processing',
        titanium = 'titanium-processing',
        tungsten = 'tungsten-processing',
        tungstenAlloy = 'tungsten-alloy-processing',
        aluminium = 'aluminium-processing',
        titaniumAlloy = 'titanium-alloy-processing',
        zinc = 'zinc-processing',
        sulfur = 'sulfur-processing',
        lead = 'lead-processing',
        gold = 'gold-processing',
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
        low_density_structure = 'low-density-structure',
        grinding = 'grinding',
    },

    science = {
        production = 'production-science-pack',                     -- purple
        automation = 'apm_power_automation_science_pack',           -- yellow
        chemical = 'chemical-science-pack',                         -- blue
        logistics = 'logistic-science-pack',                        -- red
        steam = 'apm_steam_science_pack',                           -- white
        utility = 'utility-science-pack',                           -- green
        advanced = { logistics = 'advanced-logistic-science-pack'}, -- pink
        military = 'military-science-pack',                         -- black
        nuclear = 'apm_nuclear_science_pack',                       -- nuclear
        space = 'space-science-pack',                               -- space
    },

    boiler = {
        electric = 'electric-boiler',
        burner = {
            advanced = 'bob-boiler-2',
        },
        oil = {
            basic = 'bob-oil-boiler-1',
        },
    },

    coking ={
        plant = {
            basic = 'apm_coking_plant_0',
            advanced = 'apm_coking_plant_1',
            extra = 'apm_coking_plant_2',
        },
    },

    puddling = {furnace = 'apm_puddling_furnace_0'},

    greenhouse = {
        burner = 'apm_greenhouse',
        steam = 'apm_greenhouse-2',
        electric = 'apm_greenhouse-3',
    },

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
            basic= 'apm_rubber-1',
            vulcano = 'apm_rubber-2',
        },
        asphalt = {
            creosote = 'apm_asphalt_1',
            oil = 'apm_asphalt_2',
        }
    },

    fluid = {
        handling = {
            basic = 'fluid-handling',
            advanced = 'bob-fluid-handling-2',
            expert = 'bob-fluid-handling-3',
        },
        control = {
            basic = 'apm_water_supply-1',
            extra = 'apm_fluid_control-1',
            advanced = 'apm_water_supply-2',
        },
        pumpjack = {
            basic = 'pumpjack',
            advanced = 'bob-pumpjacks-1',
        },
        barrel = 'fluid-barrel-processing',
    },

    logistics = {
        basic = 'logistics-0',
        yellow = 'logistics',
        red = 'logistics-2',
        blue = 'logistics-3',
        rail = {
            ways = 'railway',
            stop = 'automated-rail-transportation',
            signals = 'rail-signals',
            advanced = 'alt-rail',
            nuclear = 'rampant-arsenal-technology-nuclear-railway',
        },
        wagon = {
            fluid = {
                basic = 'fluid-wagon',
                armoured = 'bob-armoured-fluid-wagon',
            },
        },
        automobile = {
            basic = 'automobilism',
            electric = 'automobilism_electric',
        },
        inserters = {
            red = 'fast-inserter',
            redstack = 'stack-inserter',
            blue = 'express-inserters',
            bluestack = 'stack-inserter-2',
        },
        bots = {
            frame = {
                basic = 'robotics',
                advanced = 'bob-robotics-2',
            },

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

        shield = {
            I = 'energy-shield-equipment',
            II = 'energy-shield-mk2-equipment',
            III = 'bob-energy-shield-equipment-3',
            IV = 'bob-energy-shield-equipment-4',
        },

        tank = {
            base = 'tank',
            electric = 'tanks_electric-1',
        },

        car = {
            base = 'automobilism',
            electric = 'automobilism_electric-1',
        },
    },

    effect = {
        transmitter = {
            basic = 'effect-transmission',
            advanced = 'wide-beacon',
        },
        heat = {
            pipe = {
                basic = 'bob-heat-pipe-1',
                advanced = 'bob-heat-pipe-2',
                expert = 'bob-heat-pipe-3',
            },
        },
    },

    electricity = 'apm_power_electricity',

    energy = {
        substation ={
            basic = 'electric-energy-distribution-2',
            advanced = 'electric-substation-2',
        },
        distribution = {
            basic = 'electric-energy-distribution-1',
            advanced = 'electric-pole-2',
        },
        steam = {
            boiler = {
                basic = 'apm_power_steam',
            },
            engine = {
                advanced = 'bob-steam-engine-2',
            },
        },
        solar = {
            basic = 'solar-energy',
            advanced = 'bob-solar-energy-2',
            expert = 'bob-solar-energy-3',
        },
        heat = {
            exchanger = 'bob-heat-exchanger-1',
            pipe = {
                basic = 'bob-heat-pipe-1',
            },
        },
    },

    device = {
        lamp = 'optics',
    },

    equipment = {
        shield = {
            basic = 'energy-shield-equipment',
        },
    },

    network = {
        basic = 'circuit-network',
        ltn = 'circuit-network-2',
    },

    electronics = {
        basic = 'electronics',
        advanced = {
            I = 'advanced-electronics',
            II = 'advanced-electronics-2',
            III = 'advanced-electronics-3',
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
            product = 'apm_nuclear_fuel',
            deuterium = {
                cell = {
                    advanced = 'deuterium-fuel-cell-2',
                },
            },
        },
        thorium_breeder = 'apm_nuclear_breeder_thorium',
        synthesys = {
            plutonium = 'bobingabout-enrichment-process',
        },
        rtg = 'rtg',
        processing = {
            thorium = 'apm_nuclear_thorium_processing',
            uranium = 'uranium-processing',
            heavy_water = 'heavy-water-processing',
            deuterium = 'deuterium-processing',
        },
        portable = {
            reactor = 'fusion-reactor-equipment',
        },
    },

    ore = {
        crushing = {advanced = 'advanced-ore-crushing'},
        enrichment = {
            base = 'ore-enrichment',
            advanced = 'advanced-ore-enrichment',
        },
        mining = {
            steam = 'apm_steam_mining_drill',
            yellow = 'apm_electric_mining_drills',
            red = 'bob-drills-1',
            blue = 'bob-drills-2',
        }
    },
}

return t