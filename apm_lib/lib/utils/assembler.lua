require 'util'
require('lib.log')

local self = 'lib.utils.assembler'

if apm.lib.utils.assembler.add == nil then apm.lib.utils.assembler.add = {} end
if apm.lib.utils.assembler.mod == nil then apm.lib.utils.assembler.mod = {} end
if apm.lib.utils.assembler.mod.category == nil then apm.lib.utils.assembler.mod.category = {} end
if apm.lib.utils.assembler.burner == nil then apm.lib.utils.assembler.burner = {} end
if apm.lib.utils.assembler.centrifuge == nil then apm.lib.utils.assembler.centrifuge = {} end
if apm.lib.utils.assembler.get == nil then apm.lib.utils.assembler.get = {} end
if apm.lib.utils.assembler.set == nil then apm.lib.utils.assembler.set = {} end

require("lib.utils.assembler.base")
require("lib.utils.assembler.circuit")
require("lib.utils.assembler.fluid_box")
require("lib.utils.assembler.fuel_categories")
require("lib.utils.assembler.properties")
require("lib.utils.assembler.overhaul")