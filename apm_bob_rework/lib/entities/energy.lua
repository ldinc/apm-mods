local energy = {
    heat = {
        exchanger = 'heat-exchanger',
        pipe = {
            basic = 'heat-pipe',
            advance = 'heat-pipe-2',
            extra = 'heat-pipe-3',
        },
        source = {
            burner = 'burner-reactor',
            fluid = 'fluid-reactor',
        },
    },

    tesla = {
        coil = 'kr-tesla-coil',
    },

    pole = {
        small = 'small-electric-pole',
        medium = {
            basic = 'medium-electric-pole',
            advance = 'medium-electric-pole-2',
        },
        big = {
            basic = 'big-electric-pole',
            advance = 'big-electric-pole-2',
        },
    },

    turbine = {
        wind = 'kr-wind-turbine',
        steam = 'steam-turbine',
    },

    boiler = {
        basic = 'boiler',
        advance = 'boiler-2',
        extra = 'boiler-3',
        electric = 'electric-boiler',
        fluid = {
            basic = 'oil-boiler',
            advance = 'oil-boiler-2',
        }
    },

    generator = {
        steam = {
            basic = 'steam-engine',
            advance = 'steam-engine-2',
            drop = {
                extra = 'steam-engine-3',
            },
        },
        burner = 'bob-burner-generator',
        fluid = {
            basic = 'fluid-generator',
            hydrazine = 'hydrazine-generator',
        },
    },

    accum = {
        basic = 'accumulator',
        high = {
            basic = 'large-accumulator',
            advance = 'large-accumulator-2',
        },
        fast = {
            basic = 'fast-accumulator',
            advance = 'fast-accumulator-2',
        },
        slow = {
            basic = 'slow-accumulator',
            advance = 'slow-accumulator-2',
        },
    },

    solar = {
        panel = {
            small = {
                basic = 'solar-panel-small',
                advance = 'solar-panel-small-2',
            },
            basic = {
                basic = 'solar-panel',
                advance = 'solar-panel-2',
            },
            large = {
                basic = 'solar-panel-large',
                advance = 'solar-panel-large-2',
            },
        }
    },

    station = {
        charging = 'apm_battery_charging_station',
        dischargin = 'apm_battery_discharging_station',
    },

    sub = {
        station = {
            basic = 'substation',
            advance = 'substation-2',
        },
    },

    switch = 'power-switch',
}

return energy
