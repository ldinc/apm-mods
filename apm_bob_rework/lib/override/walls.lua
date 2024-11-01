local combat = require "lib.entities.combat"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local resistance = {
    physical = 'physical',
    laser = 'laser',
    plasma = 'plasma',
}

local setHP = function (name, hp)
    local wall = data.raw.wall[name]
    if wall then
        wall.max_health = hp
    end
end

local setResist = function (name, type, decrease, percent)
    local wall = data.raw.wall[name]
    if wall then
        if not wall.resistances then
            wall.resistances = {}
        end

        local resist = {type = type}

        resist.decrease = decrease
        resist.percent = percent

        local i = -1
        local len = 0

        for index, value in ipairs(wall.resistances) do
            if value.type == type then
                i = index
                break
            end
            len = len + 1
        end

        if i == -1 then
            i = len + 1
        end

        wall.resistances[i] = resist
    end
end

apm.bob_rework.lib.override.walls = function ()
    setHP(combat.wall.wooden, 400)
    setHP(combat.wall.basic, 1500)
    setHP(combat.wall.red, 4000)

    setResist(combat.wall.basic, resistance.physical, 6, 30)
    setResist(combat.wall.red, resistance.physical, 12, 50)
    setResist(combat.wall.blue, resistance.physical, 30, 60)

    setResist(combat.wall.red, resistance.laser, 0, 100)
    setResist(combat.wall.blue, resistance.laser, 0, 100)

    setResist(combat.wall.red, resistance.plasma, 0, 90)
    setResist(combat.wall.blue, resistance.plasma, 0, 100)
end