local prefix = {
    acidic = {
        biter = 'acid-biter-spawner-',
        splitter = 'acid-splitter-spawner',
    },
}

local postfix = '-rampant'

local base = function (prefix, v, t)
    return prefix..v..tostring(v)..'-t'..tostring(t)..postfix
end

local corpse = function (prefix, v, t)
    return prefix..v..tostring(v)..'-t'..tostring(t)..'-corpse'..postfix
end

local gen = function (prefix, v, t)
    return {
        base = base(prefix, v, t),
        corpse = corpse(prefix, v, t),
    }
end

local s = {
    acidic = {
        biter = {
            I = {
                v1 = gen(prefix.acidic.biter, 1, 1),
                v2 = gen(prefix.acidic.biter, 2, 1),
                v3 = gen(prefix.acidic.biter, 3, 1),
            },
        },
        splitter = {
            I = {
                v1 = gen(prefix.acidic.splitter, 1, 1),
                v2 = gen(prefix.acidic.splitter, 2, 1),
                v3 = gen(prefix.acidic.splitter, 3, 1),
            },
        },
    },
}

return s