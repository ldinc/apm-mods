if apm.lib.utils.constants == nil then apm.lib.utils.constants = {} end
if apm.lib.utils.constants.value == nil then apm.lib.utils.constants.value = {} end
if apm.lib.utils.constants.value.weight == nil then apm.lib.utils.constants.value.weight = {} end

local gram = gram or  1
local grams = grams or gram
local kg = kg or (1000*grams)
local tons = tons or (1000*kg)
local second = second or 60
local minute = minute or (60 * second)
local hour = hour or (60 * minute)
local meter = meter or 1
local kilometer = kilometer or 1000

apm.lib.utils.constants.value.weight.default = 1 * kg
apm.lib.utils.constants.value.weight.science_pack = 1 * kg
apm.lib.utils.constants.value.weight.plate = 1 * kg
apm.lib.utils.constants.value.weight.ore = 1 * kg
apm.lib.utils.constants.value.weight.crushed_ore = 1 * kg
apm.lib.utils.constants.value.weight.wood = 1 * kg
apm.lib.utils.constants.value.weight.chemistry = 1 * kg
apm.lib.utils.constants.value.weight.module = 0.1 * kg
apm.lib.utils.constants.value.weight.fuel_element = 1 * kg

if apm.lib.utils.constants.value.weight.building == nil then
	apm.lib.utils.constants.value.weight.building = {}
end

apm.lib.utils.constants.value.weight.building.small = 10 * kg
apm.lib.utils.constants.value.weight.building.medium = 20 * kg
apm.lib.utils.constants.value.weight.building.big = 50 * kg
apm.lib.utils.constants.value.weight.building.huge = 100 * kg

apm.lib.utils.constants.value.weight.building.inserter = 1 * kg
apm.lib.utils.constants.value.weight.building.pipe = 1 * kg
apm.lib.utils.constants.value.weight.building.belt = 1 * kg
apm.lib.utils.constants.value.weight.building.loader = 2 * kg


if apm.lib.utils.constants.value.weight.equipment == nil then
	apm.lib.utils.constants.value.weight.equipment = {}
end

apm.lib.utils.constants.value.weight.equipment.light = 1 * kg
apm.lib.utils.constants.value.weight.equipment.medium = 5 * kg
apm.lib.utils.constants.value.weight.equipment.heavy = 10 * kg

if apm.lib.utils.constants.value.weight.product == nil then
	apm.lib.utils.constants.value.weight.product = {}
end



apm.lib.utils.constants.value.weight.product.ash = 0.1 * kg
apm.lib.utils.constants.value.weight.product.mud = {
	dry = 1 * kg,
	wet = 2 * kg,
}
apm.lib.utils.constants.value.weight.product.sieve = 0.1 * kg
apm.lib.utils.constants.value.weight.product.filter = 0.1 * kg
apm.lib.utils.constants.value.weight.product.drums = 1 * kg
apm.lib.utils.constants.value.weight.product.press_plates = 1 * kg
apm.lib.utils.constants.value.weight.product.saw = 0.1 * kg
apm.lib.utils.constants.value.weight.product.resin = 1 * kg
apm.lib.utils.constants.value.weight.product.tree_seeds = 0.01 * kg
apm.lib.utils.constants.value.weight.product.ferlitizer = 1 * kg

apm.lib.utils.constants.value.weight.product.wood_pellete = 0.2 * kg
apm.lib.utils.constants.value.weight.product.wood_briquette = 1 * kg

apm.lib.utils.constants.value.weight.product.charcoal = 1 * kg
apm.lib.utils.constants.value.weight.product.crushed_coal = 1 * kg
apm.lib.utils.constants.value.weight.product.coal_briquette = 1 * kg
apm.lib.utils.constants.value.weight.product.coke = 1 * kg
apm.lib.utils.constants.value.weight.product.crushed_coke = 1 * kg
apm.lib.utils.constants.value.weight.product.coke_briquette = 1 * kg
apm.lib.utils.constants.value.weight.product.asphalt = 1 * kg
apm.lib.utils.constants.value.weight.product.landfill = 1 * kg
apm.lib.utils.constants.value.weight.product.stone_crucible = 1 * kg
apm.lib.utils.constants.value.weight.product.rubber = 1 * kg
apm.lib.utils.constants.value.weight.product.sealing_rings = 0.1 * kg
apm.lib.utils.constants.value.weight.product.gearing = 0.1 * kg
apm.lib.utils.constants.value.weight.product.pistons = 0.05 * kg
apm.lib.utils.constants.value.weight.product.engine = 1 * kg
apm.lib.utils.constants.value.weight.product.frame = 1 * kg
apm.lib.utils.constants.value.weight.product.bearing = 0.1 * kg
apm.lib.utils.constants.value.weight.product.bearing_ball = 0.02 * kg

apm.lib.utils.constants.value.weight.product.gun_powder = 1 * kg

apm.lib.utils.constants.value.weight.product.motherboard = 0.01 * kg
apm.lib.utils.constants.value.weight.product.electric_element = 0.01 * kg

apm.lib.utils.constants.value.weight.product.c = 0.01 * kg







