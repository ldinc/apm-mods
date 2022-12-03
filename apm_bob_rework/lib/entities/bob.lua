local bob = {

    assembler = {
        burner = 'burner-assembling-machine',
        steam = 'steam-assembling-machine',
        electric = {
            base = 'assembling-machine-1',
            yellow = 'assembling-machine-2',
            red = 'assembling-machine-3',
            blue = 'assembling-machine-4',
            purple = 'assembling-machine-5',
            green = 'assembling-machine-6',
        },
        electronics = {
            yellow = 'electronics-machine-1',
            blue = 'electronics-machine-2',
            green = 'electronics-machine-3',
        },
    },

    generator = {
        burner = 'bob-burner-generator',
    },

    valve = {
        check = 'bob-valve', -- обратный клапан =)
        overflow = 'bob-overflow-valve',
        topup = 'bob-topup-valve',
    },

    modules = {
        part = {
            case = 'module-case',
            contact = 'module-contact',
            board = {
                main = 'module-circuit-board',
                basic = 'module-processor-board',
                logic = 'module-processor-board-2',
                processor = 'module-processor-board-3',
                bonus = {
                    speed = {
                        basic = 'speed-processor',
                        logic = 'speed-processor-2',
                        processor = 'speed-processor-3',
                    },
                    efficency = {
                        basic = 'effectivity-processor',
                        logic = 'effectivity-processor-2',
                        processor = 'effectivity-processor-3',
                    },
                    productivity = {
                        basic = 'productivity-processor',
                        logic = 'productivity-processor-2',
                        processor = 'productivity-processor-3',
                    },
                    pollution = {
                        decrease = {
                            basic = 'pollution-clean-processor',
                            logic = 'pollution-clean-processor-2',
                            processor = 'pollution-clean-processor-3',
                        },
                        increase = {
                            basic = 'pollution-create-processor',
                            logic = 'pollution-create-processor-2',
                            processor = 'pollution-create-processor-3',
                        },
                    },
                },
            },
        },
        card = {},
    },

    tech = {
        automation = {
            basic = 'basic-automation',
        }
    },

    product = {
        recipe = {
            resin = 'bob-resin-wood',
            rubber = 'bob-rubber',
        },
    },

    recipe = {
        zinc = 'bob-zinc-plate',
    },
}

return bob