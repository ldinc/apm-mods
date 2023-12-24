if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end
if apm.bob_rework.lib.entities.chem == nil then apm.bob_rework.lib.entities.chem = {} end

apm.bob_rework.lib.entities.chem.lubricant = 'lubricant'
apm.bob_rework.lib.entities.chem.deuterium = 'deuterium'

local fluids =  {
    lubricant = 'lubricant',
    deuterium = 'deuterium',
    chlorine = 'chlorine',
    hydrogen = 'hydrogen',
    water = 'water',
    nitrogen = 'nitrogen',
    napalm = 'napalm-fluid-rampant-arsenal',
    acid = {
        sulfuric = 'sulfuric-acid',
    }, 
    oil = {
        crude = 'crude-oil',
        light = 'light-oil',
        heavy = 'heavy-oil',
    },

    tank = {
        minibuffer = 'minibuffer',
        small = {
            inline = 'bob-small-inline-storage-tank',
            cross = 'bob-small-storage-tank',
        },
    },

    liquid = {
        fuel = 'liquid-fuel',
    },
}

return fluids