local logistics = {
    belt = {
        slow = 'basic-transport-belt',
        basic = 'transport-belt',
        fast = 'fast-transport-belt',
        express = 'express-transport-belt',

        under = {
            slow = 'basic-underground-belt',
            basic = 'underground-belt',
            fast = 'fast-underground-belt',
            express = 'express-underground-belt',
        },
    },

    splitter = {
        slow = 'basic-splitter',
        basic = 'splitter',
        fast = 'fast-splitter',
        express = 'express-splitter',
    },

    loader = {
        slow = 'basic-transport-belt-loader',
        basic = 'transport-belt-loader',
        fast = 'fast-transport-belt-loader',
        express = 'express-transport-belt-beltloader',
    },

    rail = {
        element = 'rail',
        advanced = 'alt-rail',
    },

    -- entities for disabling later
    disabled = {
        belt = {
            turbo = 'turbo-transport-belt',
            ultimate = 'ultimate-transport-belt',

            under = {
                turbo = 'turbo-underground-belt',
                ultimate = 'ultimate-underground-belt',
            },
        },
        splitter = {
            turbo = 'turbo-splitter',
            ultimate = 'ultimate-splitter',
        },
        loader = {
            turbo = 'purple-loader',
            ultimate = 'green-loader',
        },
    },
}

-- TODO: move here inserters
return logistics
