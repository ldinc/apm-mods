if mathUtilsG then
    return mathUtilsG
end
local mathUtils = {}

-- imports

local constants = require("Constants")

-- constants

local TICKS_A_MINUTE = constants.TICKS_A_MINUTE

-- imported functions

local mSqrt = math.sqrt
local mLog10 = math.log10

local mRandom = math.random
local mFloor = math.floor
local mAbs = math.abs

-- module code

function mathUtils.roundToFloor(number, multiple)
    return mFloor(number / multiple) * multiple
end

function mathUtils.roundToNearest(number, multiple)
    local num = number + (multiple * 0.5)
    return num - (num % multiple)
end

function mathUtils.randomTickEvent(tick, low, high)
    local range = high - low
    local minutesToTick = (range * mRandom()) + low
    return tick + mathUtils.roundToNearest(TICKS_A_MINUTE * minutesToTick, 1)
end

function mathUtils.distort(xorRandom, num, stdDev, min, max)
    local amin = min or num * 0.70
    local amax = max or num * 1.30
    local sd = stdDev or 0.17
    if (num < 0) then
        local t = amin
        amin = amax
        amax = t
    end
    return mathUtils.roundToNearest(mathUtils.gaussianRandomRangeRG(num, num * sd, amin, amax, xorRandom), 0.01)
end

function mathUtils.linearInterpolation(percent, min, max)
    return ((max - min) * percent) + min
end

function mathUtils.xorRandom(state)
    local xor = bit32.bxor
    local lshift = bit32.lshift
    local rshift = bit32.rshift

    state = state + 21594771

    return function()
        state = xor(state, lshift(state, 13))
        state = xor(state, rshift(state, 17))
        state = xor(state, lshift(state, 5))
        state = state % 2147483647
        return state * 4.65661287525e-10
    end
end

function mathUtils.linearInterpolation(percent, min, max)
    return ((max - min) * percent) + min
end

--[[
    Used for gaussian random numbers
--]]
function mathUtils.gaussianRandom(mean, std_dev)
    -- marsagliaPolarMethod
    local iid1
    local iid2
    local q
    repeat
        iid1 = 2 * mRandom() + -1
        iid2 = 2 * mRandom() + -1
        q = (iid1 * iid1) + (iid2 * iid2)
    until (q ~= 0) and (q < 1)
    local s = mSqrt((-2 * mLog10(q)) / q)
    local v = iid1 * s

    return mean + (v * std_dev)
end

function mathUtils.gaussianRandomRange(mean, std_dev, min, max)
    if (min >= max) then
        return min
    end
    local r
    repeat
        local iid1
        local iid2
        local q
        repeat
            iid1 = 2 * mRandom() + -1
            iid2 = 2 * mRandom() + -1
            q = (iid1 * iid1) + (iid2 * iid2)
        until (q ~= 0) and (q < 1)
        local s = mSqrt((-2 * mLog10(q)) / q)
        local v = iid1 * s

        r = mean + (v * std_dev)
    until (r >= min) and (r <= max)
    return r
end

function mathUtils.gaussianRandomRG(mean, std_dev, rg)
    -- marsagliaPolarMethod
    local iid1
    local iid2
    local q
    repeat
        iid1 = 2 * rg() + -1
        iid2 = 2 * rg() + -1
        q = (iid1 * iid1) + (iid2 * iid2)
    until (q ~= 0) and (q < 1)
    local s = mSqrt((-2 * mLog10(q)) / q)
    local v = iid1 * s

    return mean + (v * std_dev)
end

function mathUtils.gaussianRandomRangeRG(mean, std_dev, min, max, rg)
    local r
    if (min >= max) then
        return min
    end
    repeat
        local iid1
        local iid2
        local q
        repeat
            iid1 = 2 * rg() + -1
            iid2 = 2 * rg() + -1
            q = (iid1 * iid1) + (iid2 * iid2)
        until (q ~= 0) and (q < 1)
        local s = mSqrt((-2 * mLog10(q)) / q)
        local v = iid1 * s
        r = mean + (v * std_dev)
    until (r >= min) and (r <= max)
    return r
end

function mathUtils.euclideanDistanceNamed(p1, p2)
    local xs = p1.x - p2.x
    local ys = p1.y - p2.y
    return ((xs * xs) + (ys * ys)) ^ 0.5
end

function mathUtils.euclideanDistancePoints(x1, y1, x2, y2)
    local xs = x1 - x2
    local ys = y1 - y2
    return ((xs * xs) + (ys * ys)) ^ 0.5
end

function mathUtils.mahattenDistancePoints(x1, y1, x2, y2)
    local xs = x1 - x2
    local ys = y1 - y2
    return mAbs(xs + ys)
end

function mathUtils.euclideanDistanceArray(p1, p2)
    local xs = p1[1] - p2[1]
    local ys = p1[2] - p2[2]
    return ((xs * xs) + (ys * ys)) ^ 0.5
end

function mathUtils.distortPosition(position, size)
    local xDistort = mathUtils.gaussianRandomRange(1, 0.5, 0, 2) - 1
    local yDistort = mathUtils.gaussianRandomRange(1, 0.5, 0, 2) - 1
    position.x = position.x + (xDistort * size)
    position.y = position.y + (yDistort * size)
    return position
end

-- + !КДА 2021.11 for SwarmUtils
-- example:
-- Values{1, 3, 5, 10,...}
-- Levels{1.5, 3.5}
-- result{2, 7.5}
-- precision = 0 => to integer, 1 => 0.1, 2=>0.01...
function mathUtils.calculateValuesForLevels(Values, Levels, precision)
	local multipiler = 0
	if precision then
		multipiler = 10^precision
	end	
	local newTierValues = {}
	for i = 1, #Levels do
		local lvl = Levels[i]
		if not lvl then lvl = 1 end
		local lvlMin = mFloor(lvl)
		if (lvlMin==lvl) or not(Values[lvlMin+1]) then
			newTierValues[i] = Values[lvlMin]
		else
			local Val1 = Values[lvlMin]
			local Val2 = Values[lvlMin+1]
			
			newTierValues[i] = mathUtils.linearInterpolation(lvl - lvlMin, Val1, Val2)
			if not (multipiler==0) then
				newTierValues[i] = mFloor(newTierValues[i]*multipiler)/multipiler
			end
		end
	end	
	return newTierValues
end
-- - !КДА 2021.11

mathUtilsG = mathUtils
return mathUtils
