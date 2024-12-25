local whitelist = {
	"automation-science-pack",
	"logistic-science-pack",
	"cerys-science-pack",
	"utility-science-pack",
}

local techlist = apm.lib.utils.technology.find.by_prefix("cerys")

if techlist then
	for _, t_name in ipairs(techlist) do
		apm.lib.utils.technology.remove.science_packs_except(t_name, whitelist)
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO("compatability for \"Cerys-Moon-of-Fulgora\" enabled"))
	end
end
