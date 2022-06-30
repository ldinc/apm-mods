local p = {
    engine = {
        burner = 'apm_simple_engine',
        steam = 'apm_steam_engine',
        electric = 'engine-unit',
    },

    egenerator = 'apm_egen_unit',

    gearwheel = {
        bronze = 'bronze-gear-wheel',
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
    }
}

return p

-- rm('cobalt-steel-gear-wheel')
-- rm('cobalt-steel-bearing-ball')
-- rm('cobalt-steel-bearing')

-- apm.bob_rework.lib.entities.ironGearWheel = 'iron-gear-wheel'
-- apm.bob_rework.lib.entities.bronzeGearWheel = 'bronze-gear-wheel'
-- apm.bob_rework.lib.entities.titaniumGearWheel = 'titanium-gear-wheel'
-- apm.bob_rework.lib.entities.cobaltGearWheel = 'cobalt-steel-gear-wheel'
-- apm.bob_rework.lib.entities.steelGearWheel = 'steel-gear-wheel'
-- apm.bob_rework.lib.entities.nitinolGearWheel = 'nitinol-gear-wheel'

-- apm.bob_rework.lib.entities.steelBearing = 'steel-bearing'
-- apm.bob_rework.lib.entities.bronzeBearing = 'bronze-bearing'
-- apm.bob_rework.lib.entities.brassBearing = 'brass-bearing'
-- apm.bob_rework.lib.entities.steelBearing = 'steel-bearing'
-- apm.bob_rework.lib.entities.ceramicBearing = 'ceramic-bearing'
-- apm.bob_rework.lib.entities.cobaltBearing = 'cobalt-steel-bearing'
-- apm.bob_rework.lib.entities.titaniumBearing = 'titanium-bearing'
-- apm.bob_rework.lib.entities.nitinolBearing = 'nitinol-bearing'
