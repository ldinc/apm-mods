-- TODO: drop (use pls logistisc.lua)
local d = {
    belt = {
        gray = 'basic-transport-belt',
        yellow = 'transport-belt',
        red = 'fast-transport-belt',
        blue = 'express-transport-belt',
    },

    underground = {
        belt = {
            gray = 'basic-underground-belt',
            yellow = 'underground-belt',
            red = 'fast-underground-belt',
            blue = 'express-underground-belt',
        },
    },

    splitter = {
        gray = 'basic-splitter',
        yellow = 'splitter',
        red = 'fast-splitter',
        blue = 'express-splitter',
    },

    loader = {
        gray = 'basic-transport-belt-loader',
        yellow = 'transport-belt-loader',
        red = 'fast-transport-belt-loader',
        blue = 'express-transport-belt-loader',
    },

    -- loader = {
    --     gray = 'basic-loader',
    --     yellow = 'loader',
    --     red = 'fast-loader',
    --     blue = 'express-loader',
    -- },

    stacker = {
        yellow = 'transport-belt-beltbox',
        red = 'fast-transport-belt-beltbox',
        blue = 'express-transport-belt-beltbox',
    },
}

return d