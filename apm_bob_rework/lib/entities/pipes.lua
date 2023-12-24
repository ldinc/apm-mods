if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end
if apm.bob_rework.lib.pipe == nil then apm.bob_rework.lib.pipe = {} end
if apm.bob_rework.lib.pipe.toGround == nil then apm.bob_rework.lib.pipe.toGround = {} end

apm.bob_rework.lib.entities.copperPipe = 'copper-pipe'
apm.bob_rework.lib.entities.bronzePipe = 'bronze-pipe'

apm.bob_rework.lib.entities.brassPipe = 'brass-pipe'
apm.bob_rework.lib.entities.ironPipe = 'pipe'
apm.bob_rework.lib.entities.stonePipe = 'stone-pipe'
apm.bob_rework.lib.entities.steelPipe = 'steel-pipe'
apm.bob_rework.lib.entities.plasticPipe = 'plastic-pipe'
apm.bob_rework.lib.entities.plasticUnderPipe = 'plastic-pipe-to-ground'
apm.bob_rework.lib.entities.titaniumPipe = 'titanium-pipe'
apm.bob_rework.lib.entities.ceramicPipe = 'ceramic-pipe'
apm.bob_rework.lib.entities.tungstenPipe = 'tungsten-pipe'
apm.bob_rework.lib.entities.nitinolPipe = 'nitinol-pipe'
apm.bob_rework.lib.entities.copperTungstenPipe = 'copper-tungsten-pipe'

--refactored
apm.bob_rework.lib.pipe.nitinol = 'nitinol-pipe'
apm.bob_rework.lib.pipe.iron = 'pipe'
apm.bob_rework.lib.pipe.steel = 'steel-pipe'
apm.bob_rework.lib.pipe.copper = 'copper-pipe'

apm.bob_rework.lib.entities.bronzeUnderPipe = 'bronze-pipe-to-ground'
apm.bob_rework.lib.entities.brassUnderPipe = 'brass-pipe-to-ground'
apm.bob_rework.lib.entities.stoneUnderPipe = 'stone-pipe-to-ground'
apm.bob_rework.lib.entities.nitinolUnderPipe = 'nitinol-pipe-to-ground'

--refactored
apm.bob_rework.lib.pipe.toGround.nitinol = 'nitinol-pipe-to-ground'

-- heat pipes
apm.bob_rework.lib.entities.heatPipe = 'heat-pipe'
apm.bob_rework.lib.entities.heatPipe_t2 = 'heat-pipe-2'
apm.bob_rework.lib.entities.heatPipe_t3 = 'heat-pipe-3'

local pipes = {
    base = {
        brass = 'brass-pipe',
        bronze = 'bronze-pipe',
        copper = 'copper-pipe',
        steel = 'steel-pipe',
        iron = 'pipe',
        titanium = 'titanium-pipe',
        titaniumAlloy = 'titanium-alloy-pipe',
        ceramic = 'ceramic-pipe',
        copperTungsten = 'copper-tungsten-pipe',
        nitinol = 'nitinol-pipe',
    },
    under = {
        brass = 'brass-pipe-to-ground',
        bronze = 'bronze-pipe-to-ground',
        copper = 'copper-pipe-to-ground',
        steel = 'steel-pipe-to-ground',
        iron = 'pipe-to-ground',
        titanium = 'titanium-pipe-to-ground',
        titaniumAlloy = 'titanium-alloy-pipe-to-ground',
        ceramic = 'ceramic-pipe-to-ground',
        copperTungsten = 'copper-tungsten-pipe-to-ground',
        nitinol = 'nitinol-pipe-to-ground',
    },
    sinkhole = {
        small = 'apm_small_sinkhole',
        large = 'apm_sinkhole',
    },
    valve = {
        check = 'apm_valve_2', -- обратный клапан =)
        overflow = 'apm_valve_1',
        topup = 'apm_valve_0',
    },
}

return pipes