local enums = {
    index  = {
        phase = {
            pre  = 1,
            peri = 2,
            post = 3
        },

        health = {
            healthy = 1,
            wilting = 2,
        },

        genre = {
            classical = 1,
            ballad    = 2,
            rock      = 3
        },

        semiphase = {
            countdown  = 1,
            simulation = 2
        },

        overlay = {
            dry = 1,
            healthy = 2,
            swamped = 3
        }
    },

    key = {
        phase = {
            'pre',
            'peri',
            'post'
        },

        health = {
            'healthy',
            'wilting'
        },

        genre = {
            'classical',
            'ballad',
            'rock'
        },

        semiphase = {
            'countdown',
            'simulation'
        }
    },
}

return enums