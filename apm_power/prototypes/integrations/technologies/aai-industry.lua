apm.lib.utils.technology.delete("basic-fluid-handling")
-- apm.lib.utils.technology.delete("basic-fluid-handling")

apm.lib.utils.technology.add.prerequisites("apm_crusher_machine_0", "burner-mechanics")
apm.lib.utils.technology.add.prerequisites("apm_steam_science_pack", "steam-power")
apm.lib.utils.technology.add.prerequisites("steam-power", "apm_puddling_furnace_0")
apm.lib.utils.technology.add.prerequisites("sand-processing", "apm_stone_bricks")
apm.lib.utils.technology.add.prerequisites("sand-processing", "apm_stone_bricks")
apm.lib.utils.technology.add.prerequisites("glass-processing", "sand-processing")


apm.lib.utils.technology.add.prerequisites("apm_fuel-2", "apm_puddling_furnace_0")
