local base = '__apm_bob_rework_resource_pack_ldinc__/graphics/'
local arahnids = {
    spawner = base ..'entities/arachnids/spawner/',
    rampant = {
        acidic = base..'entities/arachnids/spawner/rampant/acidic/',
        brutal = base..'entities/arachnids/spawner/rampant/brutal/',
    },
}

local g = {

    enitity = {
        pumpjack = {
            burner = {
                icon = base.."icons/pumpjack.png",
                base = base..'entities/burner-pumpjack/',
            },
        },
        minibuffer = {
            allcorners = {
                icon = {icon=base.."icons/all-corners-tank.png", icon_size=64},
                base = {
                    lr = base.."entities/all-corners-tank/lr-base.png",
                    hr = base.."entities/all-corners-tank/base.png",
                },
                shadow = {
                    lr = base.."entities/all-corners-tank/lr-shadow.png",
                    hr = base.."entities/all-corners-tank/shadow.png",
                },
            },
        },
    },

    arahnids = {
        spawner = {
            
            idle = {
                integration = {
                    lr = arahnids.spawner.."Arachnids-spawner-idle-integration.png",
                    hr = arahnids.spawner.."Arachnids-spawner-idle-integration.png",
                },
            
                animation = {
                    lr = arahnids.spawner.."Arachnids-spawner-idle.png",
                    hr = arahnids.spawner.."hr-Arachnids-spawner-idle.png",

                    shadows = {
                        lr = arahnids.spawner.."Arachnids-spawner-idle-shadow.png",
                        hr = arahnids.spawner.."hr-Arachnids-spawner-idle-shadow.png",
                    },
                },
            },

            death = {
                lr = arahnids.spawner.."Arachnids-spawner-die.png",
                hr = arahnids.spawner.."hr-Arachnids-spawner-die.png",

                shadows = {
                    lr = arahnids.spawner.."Arachnids-spawner-die-shadow.png",
                    hr = arahnids.spawner.."hr-Arachnids-spawner-die-shadow.png",
                },
            },

            rampant = {
                acidic = {
                    idle = {
                        integration = {
                            lr = arahnids.rampant.acidic.."idle-integration.png",
                            hr = arahnids.rampant.acidic.."idle-integration.png",
                        },
                    
                        animation = {
                            lr = arahnids.rampant.acidic.."idle.png",
                            hr = arahnids.rampant.acidic.."hr-idle.png",
        
                            shadows = {
                                lr = arahnids.rampant.acidic.."idle-shadows.png",
                                hr = arahnids.rampant.acidic.."hr-idle-shadows.png",
                            },
                        },
                    },
        
                    death = {
                        lr = arahnids.rampant.acidic.."death.png",
                        hr = arahnids.rampant.acidic.."hr-death.png",
        
                        shadows = {
                            lr = arahnids.rampant.acidic.."death-shadows.png",
                            hr = arahnids.rampant.acidic.."hr-death-shadows.png",
                        },
                    },
                },

                brutal = {
                    idle = {
                        integration = {
                            lr = arahnids.rampant.brutal.."idle-integration.png",
                            hr = arahnids.rampant.brutal.."idle-integration.png",
                        },
                    
                        animation = {
                            lr = arahnids.rampant.brutal.."idle.png",
                            hr = arahnids.rampant.brutal.."hr-idle.png",
        
                            shadows = {
                                lr = arahnids.rampant.brutal.."idle-shadows.png",
                                hr = arahnids.rampant.brutal.."hr-idle-shadows.png",
                            },
                        },
                    },
        
                    death = {
                        lr = arahnids.rampant.brutal.."death.png",
                        hr = arahnids.rampant.brutal.."hr-death.png",
        
                        shadows = {
                            lr = arahnids.rampant.brutal.."death-shadows.png",
                            hr = arahnids.rampant.brutal.."hr-death-shadows.png",
                        },
                    },
                },
            },
        },
    },
}

return g