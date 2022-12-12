local p = {
    engine = {
        burner = 'apm_simple_engine',
        steam = 'apm_steam_engine',
        electric = 'electric-engine-unit',
        basic = 'engine-unit',
    },

    egenerator = 'apm_egen_unit',

    gearwheel = {
        bronze = 'bronze-gear-wheel',
        iron = 'iron-gear-wheel',
        brass = 'brass-gear-wheel',
        steel = 'steel-gear-wheel',
        titanium = 'titanium-gear-wheel',
        cobaltSteel = 'cobalt-steel-gear-wheel',
    },

    bearing = {
        bronze = 'bronze-bearing',
        brass = 'brass-bearing',
        steel = 'steel-bearing',
        titanium = 'titanium-bearing',
        cobaltSteel = 'cobalt-steel-bearing',
        cobalt = {steel = 'cobalt-steel-bearing'},
        ceramic = 'ceramic-bearing',

        -- TODO: remove
        ball = {
            titanium = 'titanium-bearing-ball',
            ceramic = 'ceramic-bearing-ball',
            bronze = 'bronze-bearing-ball',
            brass = 'brass-bearing-ball',
        },

        balls = {
            cobalt = {steel = 'cobalt-steel-bearing-balls'},
            ceramic = 'ceramic-bearing-balls',
            bronze = 'bronze-bearing-balls',
            brass = 'brass-bearing-balls',
        },
    },

    battery = {
        basic = 'battery',
        LiIon = 'lithium-ion-battery',
        Z = 'silver-zinc-battery',
        AgZn = 'silver-zinc-battery',
    },

    sealing = { rings = 'apm_sealing_rings' },
    rubber = 'apm_rubber',
    filter = 'apm_filter_charcoal',
    lamp = 'small-lamp',
    stick = 'iron-stick',
    magnet = 'apm_electromagnet',
    pistons = 'apm_pistions',

    sieve = {
        iron = 'apm_sieve_iron',
        disabled = {
            copper = 'apm_sieve_copper',
        },
    },

    board = {
        wooden = 'apm_wood_board',
    },

    cliff = { explosives = 'cliff-explosives' },
    explosives = 'explosives',

    gun = {
        powder = 'apm_gun_powder',
    },

    barrel = {
        empty = 'empty-barrel',
    },

    crushed = {
        stone = 'apm_crushed_stone',
    },

    chemistry = {
        resin = 'apm_resin',
        cordite = 'cordite',
        plastic = 'plastic-bar',
    },

}

return p