if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.enities.base')
require('lib.tier.t0_bronze')
require('lib.tier.t1_brass')
require('lib.tier.t2_monel')
require('lib.tier.t6_titanium')