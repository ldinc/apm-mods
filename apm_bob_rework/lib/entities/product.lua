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
        ceramic = 'ceramic-bearing',

        balls = {
            titanium = 'titanium-bearing-ball',
            ceramic = 'ceramic-bearing-ball',
            bronze = 'bronze-bearing-ball',
            brass = 'brass-bearing-ball',
        },
    },

    battery = {
        basic = 'battery',
        LiIon = 'lithium-ion-battery',
        Z = 'silver-zinc-battery',
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
    }
}

return p