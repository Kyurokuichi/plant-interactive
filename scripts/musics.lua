--[[
    music.lua

    Music table
--]]

local assets = require('scripts.assets')

local music = {
    classical = {
        {
            name = 'Fur Elise',
            artist = 'Ludwig Van Beethoven',
            audio = assets.audio.classical1,
            path = 'assets/classical/Beethoven - Fur Elise.ogg',
        },

        {
            name = 'Moonlight Sonata 3rd Movement',
            artist = 'Ludwig Van Beethoven',
            audio = assets.audio.classical2,
            path = 'assets/classical/Beethoven - Moonlight Sonata 3rd Movement.ogg'
        },

        {
            name = 'Carmen Overture',
            artist = 'Alexandre Cesar Leopold Bizet',
            audio = assets.audio.classical3,
            path = 'assets/classical/Bizet - Carmen  Overture.ogg'
        },


        {
            name = 'In the Hall of the Mountain King',
            artist = 'Edvard Grieg',
            audio = assets.audio.classical4,
            path = 'assets/classical/Grieg - In the Hall of the Mountain King.ogg'
        },


        {
            name = 'Erika',
            artist = 'Herms Niel',
            audio = assets.audio.classical5,
            path = 'assets/classical/Herms Niel - Erika.ogg'
        },


        {
            name = 'The Blue Danube Waltz',
            artist = 'Johann Strauss II',
            audio = assets.audio.classical6,
            path = 'assets/classical/Johann Strauss II - The Blue Danube Waltz.ogg'
        },


        {
            name = 'Eine Kleine Nachtmusik',
            artist = 'Wolfgang Amadeus Mozart',
            audio = assets.audio.classical7,
            path = 'assets/classical/Mozart - Eine Kleine Nachtmusik.ogg'
        },

        {
            name = 'Can Can',
            artist = 'Jacques Offenbach',
            audio = assets.audio.classical8,
            path = 'assets/classical/Offenbach - Can Can Music.ogg'
        },

        {
            name = 'William Tell Overture',
            artist = 'Gioachino Rossini',
            audio = assets.audio.classical9,
            path = 'assets/classical/Rossini - William Tell Overture Final.ogg'
        },

        {
            name = 'Russian Dance Trepak',
            artist = 'Peter Ilyich Tchaikovsky',
            audio = assets.audio.classical10,
            path = 'assets/classical/Tchaikovsky - Nutcracker Suite  Russian Dance Trepak.ogg'
        }
    },

    ballad = {
        {
            name = 'Hello',
            artist = 'Adele',
            audio = assets.audio.ballad1,
            path = 'assets/ballad/Adele - Hello.ogg'
        },

        {
            name = 'Every Woman In The World',
            artist = 'Air supply',
            audio = assets.audio.ballad2,
            path = 'assets/ballad/Air Supply - Every Woman In The World.ogg'
        },

        {
            name = 'The Truth Unfold',
            artist = 'BTS',
            audio = assets.audio.ballad3,
            path = 'assets/ballad/BTS - The Truth Untold.ogg'
        },

        {
            name = 'My Heart Will Go On',
            artist = 'Celine Dion',
            audio = assets.audio.ballad4,
            path = 'assets/ballad/Celine Dion - My Heart Will Go On.ogg'
        },

        {
            name = 'The Power Of Love',
            artist = 'Celine Dion',
            audio = assets.audio.ballad5,
            path = 'assets/ballad/Celine Dion - The Power Of Love.ogg'
        },

        {
            name = 'A Thousand Years',
            artist = 'Christina Perri',
            audio = assets.audio.ballad6,
            path = 'assets/ballad/Christina Perri - A Thousand Years.ogg'
        },

        {
            name = 'Cant Help Falling In Love',
            artist = 'Elvis Presley',
            audio = assets.audio.ballad7,
            path = 'assets/ballad/Elvis Presley - Cant Help Falling In Love Audio.ogg'
        },

        {
            name = 'Good Old-Fashioned Lover Boy',
            artist = 'Queen',
            audio = assets.audio.ballad8,
            path = 'assets/ballad/Queen - Good Old Fashioned Lover Boy.ogg'
        },

        {
            name = 'Doughnut',
            artist = 'TWICE',
            audio = assets.audio.ballad9,
            path = 'assets/ballad/TWICE - Doughnut.ogg'
        },

        {
            name = 'Swear It Again',
            artist = 'Westlife',
            audio = assets.audio.ballad10,
            path = 'assets/ballad/Westlife - Swear It Again.ogg'
        }
    },

    rock = {
        {
            name = 'Livin On A Prayer',
            artist = 'Bon Jovi',
            audio = assets.audio.rock1,
            path = 'assets/rock/Bon Jovi - Livin On A Prayer Official Music Video.ogg'
        },

        {
            name = 'You Spin Me Round (Like a Record)',
            artist = 'Dead Or Alive',
            audio = assets.audio.rock2,
            path = 'assets/rock/Dead Or Alive - You Spin Me Round Like a Record Official Video.ogg'
        },

        {
            name = 'Hotel California',
            artist = 'Eagles',
            audio = assets.audio.rock3,
            path = 'assets/rock/Eagles - Hotel California.ogg'
        },

        {
            name = 'Kashmir',
            artist = 'Led Zepelin',
            audio = assets.audio.rock4,
            path = 'assets/rock/Led Zeppelin - Kashmir.ogg'
        },

        {
            name = 'In The End',
            artist = 'Linkin Park',
            audio = assets.audio.rock5,
            path = 'assets/rock/Linkin Park - In The End Official.ogg'
        },

        {
            name = 'Hayloft II',
            artist = 'Mother Mother',
            audio = assets.audio.rock6,
            path = 'assets/rock/Mother Mother - Hayloft II.ogg'
        },

        {
            name = 'Heart-Shaped Box',
            artist = 'Nirvana',
            audio = assets.audio.rock7,
            path = 'assets/rock/Nirvana - Heartshaped Box.ogg'
        },

        {
            name = 'Bismarck',
            artist = 'Sabaton',
            audio = assets.audio.rock8,
            path = 'assets/rock/Sabaton - Bismarck.ogg'
        },

        {
            name = 'Hey Jude',
            artist = 'The Beatles',
            audio = assets.audio.rock9,
            path = 'assets/rock/The Beatles - Hey Jude.ogg'
        },

        {
            name = 'Embraced by the Flame',
            artist = 'UNDEAD CORPORATION',
            audio = assets.audio.rock10,
            path = 'assets/rock/UNDEAD CORPORATION - Embraced by the Flame.ogg'
        }
    },

    -- Special [to be implement]
    meme = {},
    weeb = {},

    custom = {}
}

return music