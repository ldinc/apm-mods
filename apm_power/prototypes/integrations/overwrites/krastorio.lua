--- For Krastorio2 the mod'll try intergrate minimal set of sp and then reuse them as part of original ...
--- The example is angel compat mod for 1.x version of factorio

for _, tech in pairs(data.raw["technology"]) do
	apm.lib.utils.technology.remove.apms_if_has_others_by_ref(tech)
end
