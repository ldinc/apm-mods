local data = {
    antenna = {
        base = 'roboport-antenna-1',
        advanced = 'roboport-antenna-2',
    },

    port = {
        basic = 'roboport',
        advanced = 'bob-roboport-2',
    },

    bots = {
        construction = {
            red = 'bob-construction-robot-2',
            blue = 'bob-construction-robot-3',
            nuclear = 'bob-construction-robot-5',

            part = {
                brain = {
                    red = 'robot-brain-construction-2',
                    blue = 'robot-brain-construction-3',
                },
                tool = {
                    red = 'robot-tool-construction-2',
                    blue = 'robot-tool-construction-3',
                },
            },
        },

        logistic = {
            red = 'bob-logistic-robot-2',
            blue = 'bob-logistic-robot-3',
            nuclear = 'bob-logistic-robot-5',

            part = {
                brain = {
                    red = 'robot-brain-logistic-2',
                    blue = 'robot-brain-logistic-3',
                },
                tool = {
                    red = 'robot-tool-logistic-2',
                    blue = 'robot-tool-logistic-3',
                },
            },
        },
    },

    frame = {
        basic = 'flying-robot-frame',
        advanced = 'flying-robot-frame-2',
    }
}

return data
