local enums = {
    index = {
        type = {
            system = 1,
            group = 2,
            element = 3,
            event = 4,
            signal = 5
        },

        element = {
            drawable = 1,
            interactable = 2
        },
    },

    key = {
        type = {
            'system',
            'group',
            'element',
            'event',
            'signal'
        },

        element = {
            'drawable',
            'interactable'
        },

        drwFrameQuad = {
            'top left',
            'top',
            'top right',
            'left',
            'center',
            'right',
            'bottom left',
            'bottom',
            'bottom right'
        }
    },
}

return enums