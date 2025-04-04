require("resourceconfigs.vanilla")  -- vanilla ore/liquids (no enemies)
require("resourceconfigs.vanilla_enemies")
require("resourceconfigs.roadworks")
require("resourceconfigs.dytech")
require("resourceconfigs.bobores")
require("resourceconfigs.bobenemies")
require("resourceconfigs.peacemod")
require("resourceconfigs.yuoki_industries")
require("resourceconfigs.replicators")
require("resourceconfigs.uraniumpower")
require("resourceconfigs.homeworld")
require("resourceconfigs.groundsulfur")
require("resourceconfigs.evolution")
require("resourceconfigs.replicators")
require("resourceconfigs.darkmatter")
require("resourceconfigs.springwater")
require("resourceconfigs.sulfuricacid")
require("resourceconfigs.naturalgas")
require("resourceconfigs.deepores")
require("resourceconfigs.angelsores")
require("resourceconfigs.hardcrafting")
require("resourceconfigs.5dimores")
require("resourceconfigs.thunderstone")
require("resourceconfigs.reactor")
require("resourceconfigs.narmod")
require("resourceconfigs.alienwall")
require("resourceconfigs.senpais")
require("resourceconfigs.beyond")
require("resourceconfigs.andrew")
require("resourceconfigs.bukket")
require("resourceconfigs.infinium")
require("resourceconfigs.anonymods")
require("resourceconfigs.sulfurmod")
require("resourceconfigs.primordialooze")
require("resourceconfigs.omnimatter")
require("resourceconfigs.portalresearch")
require("resourceconfigs.sigmaonenuclear")
require("resourceconfigs.xander")
require("resourceconfigs.xander1")
require("resourceconfigs.darkstar")
require("resourceconfigs.dyworld")
require("resourceconfigs.hydraulicpumpjacks")
require("resourceconfigs.napus")
require("resourceconfigs.fpp")
require("resourceconfigs.iceore")
require("resourceconfigs.clownsores")
require("resourceconfigs.liquidscience")
require("resourceconfigs.cncssulfur")
require("resourceconfigs.dp77sulfur")
require("resourceconfigs.allminable")
require("resourceconfigs.fmrx")
require("resourceconfigs.dp77ores")
require("resourceconfigs.bioindustries")
require("resourceconfigs.kpot")
require("resourceconfigs.finitewater")
require("resourceconfigs.mutabor")
require("resourceconfigs.tiberium")
require("resourceconfigs.tinyoverhaul")
require("resourceconfigs.neenemies")
require("resourceconfigs.leighzermorphite")
require("resourceconfigs.leighzerscienceores")
require("resourceconfigs.leighzersciencebottling")
require("resourceconfigs.leighzercheetahore")
require("resourceconfigs.krastorio")
require("resourceconfigs.krastorio2")
require("resourceconfigs.aixmatter")
require("resourceconfigs.simplesilicon")
require("resourceconfigs.reforestedwood")
require("resourceconfigs.bztitanium")
require("resourceconfigs.bottledscience")
require("resourceconfigs.zzzmodderssciencepack")
require("resourceconfigs.adamo")
require("resourceconfigs.apm")
require("resourceconfigs.industrialrevolution")
require("resourceconfigs.mobilefactory")
require("resourceconfigs.enchanted")
require("resourceconfigs.foodindustries")
require("resourceconfigs.geothermal")
require("resourceconfigs.zombiesextended")
require("resourceconfigs.bzlead")
require("resourceconfigs.coldbiters")
require("resourceconfigs.explosivebiters")
require("resourceconfigs.dualores")
require("resourceconfigs.enhancedrecipes")
require("resourceconfigs.bztungsten")
require("resourceconfigs.bzzirconium")
require("resourceconfigs.bzcarbon")
require("resourceconfigs.bzaluminum")
require("resourceconfigs.bztin")
require("resourceconfigs.nullius")
require("resourceconfigs.spfumaterials")
require("resourceconfigs.qatmore")
require("resourceconfigs.ritnglass")
require("resourceconfigs.bzgas")
-- require("resourceconfigs.yaiom")

require("resourceconfigs.pyalienlife")
require("resourceconfigs.pyalienlife194")
require("resourceconfigs.pyalternativeenergy194")
require("resourceconfigs.pycoal")
require("resourceconfigs.pycoal194")
require("resourceconfigs.pyfusion")
require("resourceconfigs.pyfusion194")
require("resourceconfigs.pyhightech")
require("resourceconfigs.pyhightech194")
require("resourceconfigs.pypetroleumhandling")
require("resourceconfigs.pypetroleumhandling194")
require("resourceconfigs.pyrawores")
require("resourceconfigs.pyrawores194")

require("resourceconfigs.apmbobrework")

local logger = require 'libs/logger'
local l = logger.new_logger()

function versionValue(version)
	local mult = 1e7
	local value = 0
	
	if version == nil then
		return value
	end	
	
	for token in string.gmatch(version, "[^%.]+") do
		value = value + tonumber(token) * mult
		mult = mult / 100
	end	
	
	return value
end

function loadResourceConfig()

	local version194 = versionValue("1.9.4")
	local pyModsVersion = versionValue(game.active_mods["pycoalprocessing"])
	local use194Configs = pyModsVersion >= version194

	local config={}

	fillVanillaConfig(config)
	fillEnemies(config)

	--[[ MODS SUPPORT ]]--
	fillEnchantedConfig(config) -- checks for individual mods inside
	
	if game.active_mods["fpp"] then
		fillFppConfig(config)
	end

	if not game.entity_prototypes["alien-ore"] or useEnemiesInPeaceMod then  -- if the user has peacemod installed he probably doesn't want that RSO spawns them either. remote.interfaces["peacemod"]
		if game.entity_prototypes["bob-big-explosive-worm-turret"] and game.entity_prototypes["bob-big-fire-worm-turret"] and game.entity_prototypes["bob-big-poison-worm-turret"] then
			fillBobEnemies(config)
		end
	end

	if game.active_mods["Natural_Evolution_Enemies"] then
		fillNEConfig(config)
	end

	-- Roadworks mod
	if game.entity_prototypes["RW_limestone"] then
		fillRoadworksConfig(config)
	end

	-- DyTech
	-- i moved everything even the checks there, i think it's cleaner this way
	fillDytechConfig(config)

	-- Andrew's mods (ores)
	if game.active_mods["andrew-ore"] then
		fillAndrewConfig(config)
	end

	if game.entity_prototypes["natural-gas"] then
		fillNaturalGasConfig(config)
	end

	-- peace mod
	if game.entity_prototypes["alien-ore"] then
		fillPeaceConfig(config)
	end

	--yuoki industries mod
	if game.entity_prototypes["y-res1"] then
		fillYuokiConfig(config)
	end

	--replicators mod
	if game.entity_prototypes["rare-earth"] then
		fillReplicatorsConfig(config)
	end

	--uranium power mod
	if game.entity_prototypes["uraninite"] then
		fillUraniumpowerConfig(config)
	end

	-- ground sulfur, need to check for autoplace since bob's mods use same ore name
	if game.entity_prototypes["sulfur"] and game.entity_prototypes["sulfur"].autoplace_specification ~= nil then
		fillGroundSulfurConfig(config)
	end

	-- evolution
	if game.entity_prototypes["alien-artifacts"] then
		fillEvolutionConfig(config)
	end

	-- replicators
	if game.entity_prototypes["creatine"] then
		fillReplicatorsConfig(config)
	end

	-- homeworld
	if game.entity_prototypes["sand-source"] then
		fillHomeworldConfig(config)
	end

	-- dark matter replicators
	fillDarkMatterConfig(config)

	-- spring water
	if game.entity_prototypes["spring-water"] then
		fillSpringWaterConfig(config)
	end

	-- sulfruric acid
	if game.entity_prototypes["sulfuric-acid"] then
		fillSulfuricAcidConfig(config)
	end

	-- deep ores
	if game.entity_prototypes["deep-copper-ore"] and game.entity_prototypes["deep-iron-ore"] then
		fillDeepOresConfig(config)
	end

	-- hard crafting
	if game.entity_prototypes["rich-copper-ore"] then
		if game.active_mods["BukketMod"] then
			fillBukketConfig(config)
		else
			fillHardCraftingConfig(config)
		end
	end

	if game.entity_prototypes["monazite-ore"] then
		fillThunderStoneConfig(config)
	end

	if game.entity_prototypes["nuclear-ores"] then
--		fillReactorConfig(config)
	end

	-- NARMod
	if game.entity_prototypes["brine-pool"] then
		fillNARModConfig(config)
	end

	if game.entity_prototypes["alien-biomass"] then
		fillAlienWallConfig(config)
	end

	if game.active_mods["SenpaisOverhall"] then
		fillSenpaisConfig(config)
	end

	if game.active_mods["Beyond"] then
		fillBeyondConfig(config)
	end

	if game.active_mods["infinium-ore"] then
		fillInfiniumConfig(config)
	end

	if game.active_mods["AnonyMods"] then
		fillAnonyModsConfig(config)
	end

	if game.active_mods["cncs_Sulfur_Mod"] then
		fillSulfurConfig(config)
	end

	if game.active_mods["PrimordialOoze"] then
		fillPrimordialOozeConfig(config)
	end

	if game.active_mods["omnimatter"] then
		fillOmnimatterConfig(config)
	end

	if game.active_mods["portal-research"] then
		fillPortalResearchConfig(config)
	end

	if game.active_mods["SigmaOne_Nuclear"] then
		fillSigmaOneNuclearConfig(config)
	end

	if game.active_mods["xander-mod"] or game.active_mods["xander-mod-th"] then
		fillXanderConfig(config)
	end

	if game.active_mods["xander-mod-v1"] then
		fillXander1Config(config)
	end

	if game.active_mods["Darkstar_utilities"] or game.active_mods["Darkstar_utilities_Low_Spec"] then
		fillDarkstarConfig(config)
	end

	if game.active_mods["DyWorld"] then
		fillDyWorldConfig(config)
	end

	if game.active_mods["pyfusionenergy"] then
		if use194Configs then
			fillPyFusionConfig194(config)
		else
			fillPyFusionConfig(config)
		end
	end

	if game.active_mods["pypetroleumhandling"] then
		if use194Configs then
			fillPyPetroleumHandlingConfig194(config)
		else
			fillPyPetroleumHandlingConfig(config)
		end
	end

	if game.active_mods["HydraulicPumpjacks"] then
		fillHydraulicPumpjacksConfig(config)
	end

	if game.active_mods["NapusMod"] then
		fillNapusConfig(config)
	end

	if game.active_mods["IceOre"] then
		fillIceOreConfig(config)
	end

	if game.active_mods["Clowns-Extended-Minerals"] then
		fillClownsMineralsConfig(config)
	end

	if game.active_mods["liquid-science"] then
		fillLiquidScienceConfig(config)
	end

	if game.active_mods["pycoalprocessing"] then
		if use194Configs then
			fillPyCoalConfig194(config)
		else
			fillPyCoalConfig(config)
		end
	end

	if game.active_mods["pyhightech"] then
		if use194Configs then
			fillPyHighTechConfig194(config)
		else
			fillPyHighTechConfig(config)
		end
	end

	if game.active_mods["pyalternativeenergy"] then
		if use194Configs then
			fillPyAlternativeEnergyConfig194(config)
		end
	end
	
	if game.active_mods["cncs_Sulfur_Mod"] then
		fillCncsSulfurConfig(config)
	end

	if game.active_mods["Dp77s-Sulfur-Mod"] then
		fillDp77SulfurConfig(config)
	end

	if game.active_mods["AllMinable"] then
		fillAllMinableConfig(config)
	end

	if game.active_mods["FMRx"] then
		fillFmrxConfig(config)
	end

	if game.active_mods["Dp77s-FactorioPlus-Ores"] then
		fillDp77OresConfig(config)
	end

	if game.active_mods["Bio_Industries"] then
		fillBioIndustriesConfig(config)
	end

	if game.active_mods["KPOT_Titanium"] then
		fillKpotConfig(config)
	end

	if game.active_mods["FiniteWater"] then
		fillFiniteWaterConfig(config)
	end

	if game.active_mods["Mutabor"] then
		fillMutaborConfig(config)
	end

	if game.active_mods["Fixed_Tiberium"] or game.active_mods["Fixed_Tiberium_okta"] then
		fillTiberiumConfig(config)
	end

	if game.active_mods["tiny-overhaul"] or game.active_mods["extended-industries"] then
		fillTinyOverhaulConfig(config)
	end

	if game.active_mods["pyrawores"] then
		if use194Configs then
			fillPyRawOresConfig194(config)
		else
			fillPyRawOresConfig(config)
		end
	end

	if game.active_mods["pyalienlife"] then
		if use194Configs then
			fillPyalienlifeConfig194(config)
		else
			fillPyalienlifeConfig(config)
		end
	end

	if game.active_mods["leighzermorphite"] then
		fillLeighzerMorphiteConfig(config)
	end

	if game.active_mods["leighzerscienceores"] then
		fillLeighzerScienceOres(config)
	end

	if game.active_mods["leighzersciencebottling"] then
		fillLeighzerScienceBottling(config)
	end

	if game.active_mods["leighzercheetahore"] then
		fillLeighzerCheetahOreConfig(config)
	end

	if game.active_mods["aix_matter"] then
		fillAiXMatterConfig(config)
	end

	if game.active_mods["SimpleSilicon"] then
		fillSimpleSiliconConfig(config)
	end

	if game.active_mods["ReforestedWood"] then
		fillReforestedWoodConfig(config)
	end

	if game.active_mods["bztitanium"] then
		fillBztitaniumConfig(config)
	end

	if game.active_mods["zzz_modders_science_pack"] then
		fillZzzModdersSciencePackConfig(config)
	end

	if game.active_mods["bottled_science"] then
		fillBottledScienceConfig(config)
	end

	-- multiple mods support in one file
	fillAdamoConfig(config)
	fillApmConfig(config)

	if game.active_mods["IndustrialRevolution"] then
		fillIndustrialRevolutionConfig(config)
	end

	if game.active_mods["Krastorio"] then
		fillKrastorioConfig(config)
	end

	if game.active_mods["Krastorio2"] then
		fillKrastorio2Config(config)
	end

	if game.active_mods["Mobile_Factory"] then
		fillMobileFactoryConfig(config)
	end

	if game.active_mods["FoodIndustry"] then
		fillFoodIndustriesConfig(config)
	end
	
	if game.active_mods["geothermalgen"] then
		fillGeoTermalConfig(config)
	end

	if game.active_mods["zombiesextended-core"] then
		fillZombiesExtendedConfig(config)
	end

	if game.active_mods["bzlead"] then
		fillBzleadConfig(config)
	end

	if game.active_mods["dualores"] then
		fillDualOresConfig(config)
	end

	if game.active_mods["Cold_biters"] then
		fillColdBitersEnemies(config)
	end

	if game.active_mods["Explosive_biters"] then
		fillExplosiveBitersEnemies(config)
	end

	if game.active_mods["bztungsten"] then
		fillBztungstenConfig(config)
	end
	
	if game.active_mods["bzzirconium"] then
		fillBzzirconiumConfig(config)
	end

	if game.active_mods["bzaluminum"] then
		fillBzaluminumConfig(config)
	end

	if game.active_mods["bzcarbon"] then
		fillBzcarbon(config)
	end
	
	if game.active_mods["nullius"] then
		fillNulliusConfig(config)
		config["enemy-base"] = nil
	end
	
	if game.active_mods["SpFuMaterialPack"] then
		fillSpFuMaterialsConfig(config)
	end

	if game.active_mods["RitnGlass"] then
		fillRitnGlassConfig(config)
	end

	if game.active_mods["bztin"] then
		fillBztinConfig(config)
	end

	if game.active_mods["bzgas"] then
		fillBzgasConfig(config)
	end

	if game.active_mods["yaiom"] then
--		fillYaiomConfig(config)
	end

	fillEnhancedRecipesConfig(config)
	
	-- BobOres
	if game.active_mods["bobores"] then
		fillBoboresConfig(config)
	elseif game.active_mods["5dim_ores"] then
		fill5dimConfig(config)
	end

    if game.active_mods["qatmore"] then
        fillQatmoreConfig(config)
    end
	-- angels ores
	if game.entity_prototypes["angels-ore1"] then
		fillAngelsOresConfig(config)
		-- remove no longer needed ores
	    config["copper-ore"] = nil
	    config["iron-ore"] = nil
		config["stone"] = nil
	end

	-- apm bob rework
	if game.active_mods["apm_bob_rework_ldinc"] then
		fillAPMReworkConfig(config)
	end

	return config
end