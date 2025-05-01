local original_gh = {
  "apm_greenhouse_0",
  "apm_greenhouse_1",
  "apm_greenhouse_2",
}

for _, gh in ipairs(original_gh) do
  apm.lib.utils.assembler.add.crafting_categories(gh, {"greenhouse-farming"})
end

apm.lib.utils.assembler.add.crafting_categories("colony-greenhouse", {"apm_greenhouse"})

apm.lib.utils.assembler.mod.crafting_speed("colony-greenhouse", 4)