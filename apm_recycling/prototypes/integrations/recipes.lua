require ('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/integrations/recipes.lua'

APM_LOG_HEADER(self)

local apm_recycler_always_show_made_in = settings.startup["apm_recycler_always_show_made_in"].value

local apm_recycler_integration_bob = settings.startup["apm_recycler_integration_bob"].value
local apm_recycler_integration_angel = settings.startup["apm_recycler_integration_angel"].value
local apm_recycler_integration_earendel = settings.startup["apm_recycler_integration_earendel"].value
local apm_recycler_integration_kingarthur = settings.startup["apm_recycler_integration_kingarthur"].value
local apm_recycler_integration_sctm = settings.startup["apm_recycler_integration_sctm"].value

local apm_recycler_compat_bob = settings.startup["apm_recycler_compat_bob"].value
local apm_recycler_compat_angel = settings.startup["apm_recycler_compat_angel"].value
local apm_recycler_compat_earendel = settings.startup["apm_recycler_compat_earendel"].value
local apm_recycler_compat_kingarthur = settings.startup["apm_recycler_compat_kingarthur"].value
local apm_recycler_compat_sctm = settings.startup["apm_recycler_compat_sctm"].value

APM_LOG_SETTINGS(self, 'apm_recycler_always_show_made_in', apm_recycler_always_show_made_in)

APM_LOG_SETTINGS(self, 'apm_recycler_integration_bob', apm_recycler_integration_bob)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_angel', apm_recycler_integration_angel)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_earendel', apm_recycler_integration_earendel)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_kingarthur', apm_recycler_integration_kingarthur)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_sctm', apm_recycler_integration_sctm)

APM_LOG_SETTINGS(self, 'apm_recycler_compat_bob', apm_recycler_compat_bob)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_angel', apm_recycler_compat_angel)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_earendel', apm_recycler_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_kingarthur', apm_recycler_compat_kingarthur)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_sctm', apm_recycler_compat_sctm)

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function create_easy_smelting(name, output, tint, order)       
    local input_amount = 1
    local output_amount = 1
    local output_item = data.raw.item[output]

    local recipe = {}
    recipe.type = 'recipe'
    recipe.name = 'apm_recycling_smelting_' .. name .. '_easy'
    recipe.localised_name = {"item-name." .. output_item.name}
    recipe.icons = {
        {icon = '__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_processed_metal.png', tint=tint, icon_size=64},
        apm.lib.icons.dynamics.smelting,
    }
    recipe.category = 'smelting'
    recipe.group = "apm_recycling"
    recipe.subgroup = "apm_recycling_scrap_processed_smelting_easy"
    recipe.order = order
    recipe.normal = {}
    recipe.normal.enabled = false
    recipe.normal.energy_required = 4.5
    recipe.normal.ingredients = {
        {type='item', name='apm_scrap_processed_' .. name, amount=2},
    }
    recipe.normal.results = {
        {type='item', name=output_item.name, amount=output_amount},
    }
    recipe.normal.allow_decomposition = false
    recipe.normal.allow_as_intermediate = false
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = apm_recycler_always_show_made_in
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type='item', name='apm_scrap_processed_' .. name, amount=3},
    }

    data:extend({recipe})
end

-- apm -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.apm_nuclear and (not mods.angelsrefining and apm_recycler_compat_angel) then
    apm.lib.utils.recipe.category.change('apm_radioactive_wastewater_recyling', 'apm_recycling_2')
end

-- angel ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.angelsrefining and apm_recycler_compat_angel then
    create_easy_smelting('copper', 'copper-plate', {r= 0.68, g = 0.47, b = 0.40}, 'aa_a')
    create_easy_smelting('iron', 'iron-plate', {r= 0.46, g = 0.53, b = 0.59}, 'aa_b')
    create_easy_smelting('steel', 'steel-plate', {r= 0.68, g = 0.70, b = 0.73}, 'aa_c')

    angelsmods.functions.make_void('apm_cleaning_solution', 'water')
    angelsmods.functions.make_void('apm_dirty_cleaning_solution', 'water')
end

-- bob ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobelectronics and not mods.apm_recycling and apm_recycler_compat_bob then
end

-- sctm -- --------------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------------------
if mods.ScienceCostTweakerM and apm_recycler_compat_sctm then
    if apm.lib.utils.recycling.metal.exist('iron') and apm.lib.utils.recycling.metal.exist('copper') and apm.lib.utils.recycling.metal.exist('steel') then
        apm.lib.utils.recipe.result.remove_all('sct-waste-copperonly')
        apm.lib.utils.recipe.result.remove_all('sct-waste-ironcopper')

        if not mods.apm_power then
            apm.lib.utils.recipe.result.mod('sct-t1-ironcore', 'apm_scrap_metal_box_iron', 1)
            apm.lib.utils.recipe.result.mod('sct-t1-magnet-coils', 'apm_scrap_metal_box_copper', 1)
        end

        if mods.bobplates then
            apm.lib.utils.recipe.result.mod('sct-t2-instruments', 'apm_scrap_metal_box_tin', 1)
            apm.lib.utils.recipe.result.mod('sct-t3-atomic-sensors', 'apm_scrap_metal_box_copper', 1)
            apm.lib.utils.recipe.result.mod('sct-t3-atomic-sensors', 'apm_scrap_metal_box_gold', 1)
            apm.lib.utils.recipe.result.mod('sct-t3-atomic-sensors', 'apm_scrap_metal_box_aluminium', 1)
            apm.lib.utils.recipe.result.mod('sct-t3-laser-emitter', 'apm_scrap_metal_box_aluminium', 1)
            apm.lib.utils.recipe.result.mod('sct-t3-laser-foci', 'apm_scrap_metal_box_gold', 1)
            apm.lib.utils.recipe.result.mod('sct-mil-subplating', 'apm_scrap_metal_box_brass', 1)
            apm.lib.utils.recipe.result.mod('sct-mil-plating', 'apm_scrap_metal_box_brass', 2)
            apm.lib.utils.recipe.result.mod('sct-prod-overclocker', 'apm_scrap_metal_box_tin', 2)
            apm.lib.utils.recipe.result.mod('sct-prod-overclocker', 'apm_scrap_metal_box_lead', 2)
            apm.lib.utils.recipe.result.mod('sct-prod-overclocker', 'apm_scrap_metal_box_silver', 2)
            apm.lib.utils.recipe.result.mod('sct-logistic-automated-storage', 'apm_scrap_metal_box_brass', 1)
            apm.lib.utils.recipe.result.mod('sct-logistic-unimover', 'apm_scrap_metal_box_aluminium', 2)
            apm.lib.utils.recipe.result.mod('sct-htech-thermalstore', 'apm_scrap_metal_box_tungsten', 4)
            apm.lib.utils.recipe.result.mod('sct-htech-thermalstore', 'apm_scrap_metal_box_cobalt-steel', 4)
            apm.lib.utils.recipe.result.mod('sct-htech-injector', 'apm_scrap_metal_box_titanium', 3)
        else
            apm.lib.utils.recipe.result.mod('sct-t2-instruments', 'apm_scrap_metal_box_iron', 1)
            apm.lib.utils.recipe.result.mod('sct-t3-atomic-sensors', 'apm_scrap_metal_box_iron', 2)
            apm.lib.utils.recipe.result.mod('sct-t3-laser-emitter', 'apm_scrap_metal_box_iron', 1)
            apm.lib.utils.recipe.result.mod('sct-t3-laser-foci', 'apm_scrap_metal_box_iron', 2)
            apm.lib.utils.recipe.result.mod('sct-mil-subplating', 'apm_scrap_metal_box_iron', 1)
            apm.lib.utils.recipe.result.mod('sct-mil-subplating', 'apm_scrap_metal_box_copper', 1)
            apm.lib.utils.recipe.result.mod('sct-mil-plating', 'apm_scrap_metal_box_iron', 1)
            apm.lib.utils.recipe.result.mod('sct-mil-plating', 'apm_scrap_metal_box_copper', 1)
            apm.lib.utils.recipe.result.mod('sct-prod-overclocker', 'apm_scrap_metal_box_iron', 2)
            apm.lib.utils.recipe.result.mod('sct-prod-overclocker', 'apm_scrap_metal_box_copper', 2)
            apm.lib.utils.recipe.result.mod('sct-prod-overclocker', 'apm_scrap_metal_box_steel', 2)
            apm.lib.utils.recipe.result.mod('sct-htech-thermalstore', 'apm_scrap_metal_box_copper', 3)
            apm.lib.utils.recipe.result.mod('sct-htech-injector', 'apm_scrap_metal_box_iron', 3)
            apm.lib.utils.recipe.result.mod('sct-htech-capbank', 'apm_scrap_metal_box_iron', 3)
        end

        apm.lib.utils.recipe.result.mod('sct-t2-reaction-nodes', 'apm_scrap_metal_box_iron', 1)
        apm.lib.utils.recipe.result.mod('sct-t2-wafer-stamp', 'apm_scrap_metal_box_iron', 1)
        apm.lib.utils.recipe.result.mod('sct-t3-laser-emitter', 'apm_scrap_metal_box_copper', 1)
        apm.lib.utils.recipe.result.mod('sct-t3-laser-foci', 'apm_scrap_metal_box_copper', 1)
        apm.lib.utils.recipe.result.mod('sct-t3-flash-fuel', 'apm_scrap_metal_box_steel', 1)
        apm.lib.utils.recipe.result.mod('sct-mil-plating', 'apm_scrap_metal_box_steel', 1)
        apm.lib.utils.recipe.result.mod('sct-prod-biosilicate', 'apm_scrap_metal_box_steel', 2)

        apm.lib.utils.recipe.remove('sct-waste-processing-copper')
        apm.lib.utils.recipe.remove('sct-waste-processing-mixed')
    end
end