local pipes = require "lib.entities.pipes"
local types = require "lib.entities.types"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local function throughput(name, type, k)
    local pipe = data.raw[type][name]

    if pipe and pipe.fluid_box then
        pipe.fluid_box.height = k
    end
end

apm.bob_rework.lib.override.pipes = function()
    if settings.startup['apm_bob_rework_pipes_throughput'].value == true then
        local advanced = {
            pipes.base.ceramic,
            pipes.base.steel,
            pipes.base.iron,
        }
        local advancedToGround = {
            pipes.under.ceramic,
            pipes.under.steel,
            pipes.under.iron,
        }
        local extra = {
            pipes.base.titanium,
            pipes.base.titaniumAlloy,
            pipes.base.copperTungsten,
            pipes.base.tungsten,
        }
        local extraToGround = {
            pipes.under.titanium,
            pipes.under.titaniumAlloy,
            pipes.under.copperTungsten,
            pipes.under.tungsten,
        }

        for _, pipe in pairs(advanced) do throughput(pipe, types.pipe.base, 2) end
        for _, pipe in pairs(advancedToGround) do throughput(pipe, types.pipe.underground, 2) end
        for _, pipe in pairs(extra) do throughput(pipe, types.pipe.base, 4) end
        for _, pipe in pairs(extraToGround) do throughput(pipe, types.pipe.underground, 4) end
    end
end
