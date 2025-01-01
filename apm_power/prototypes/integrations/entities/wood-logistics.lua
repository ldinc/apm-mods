if not apm.lib.features.power.compat.safthelamb then
	return
end


apm.lib.utils.assembler.add.fluid_connections("lumber-mill", 3)
local assembler, ok = apm.lib.utils.assembler.get.by_name("lumber-mill")

if not ok then
  return
end

assembler.fluid_boxes[1].pipe_connections[1].position = { 2.69, 0.5 }