local storages = {
    chest = {
        wooden = 'wooden-chest',
        iron = 'iron-chest',
        steel = 'steel-chest',
        titanium = 'titanium-chest',
    },

    storehouse = {
        basic = 'storehouse-basic',
        provider = {
            active = 'storehouse-active-provider',
            passive = 'storehouse-passive-provider',
            storage = 'storehouse-storage',
            buffer = 'storehouse-buffer',
            requester = 'storehouse-requester',
        },
    },

    warehouse = {
        basic = 'warehouse-basic',
        provider = {
            active = 'warehouse-active-provider',
            passive = 'warehouse-passive-provider',
            storage = 'warehouse-storage',
            buffer = 'warehouse-buffer',
            requester = 'warehouse-requester',
        },
    },

    logistic = {
        basic = {
            provider = {
                active = 'logistic-chest-active-provider',
                passive = 'logistic-chest-passive-provider',
                storage = 'logistic-chest-storage',
                buffer = 'logistic-chest-buffer',
                requester = 'logistic-chest-requester',
            },
        },
        advance = {
            provider = {
                active = 'logistic-chest-active-provider-2',
                passive = 'logistic-chest-passive-provider-2',
                storage = 'logistic-chest-storage-2',
                buffer = 'logistic-chest-buffer-2',
                requester = 'logistic-chest-requester-2',
            },
        },
    },

    tank = {
        small = {
            inline = 'bob-small-inline-storage-tank',
            basic = 'bob-small-storage-tank',
        },
        basic = {
            pipes4 = 'storage-tank',
            pipes8 = 'bob-storage-tank-all-corners',
        },
        advance = {
            pipes4 = 'storage-tank-2',
            pipes8 = 'bob-storage-tank-all-corners-2',
        },
    },
}

return storages
