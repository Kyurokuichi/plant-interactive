--[[
    music.lua

    Music table
--]]

local assets = require('scripts.assets')

local musics = {
    classical = {
        {
            name = 'Fur Elise',
            artist = 'Ludwig Van Beethoven',
            audio = assets.getAudio('classical1'),
            path = 'assets/classical/Beethoven - Fur Elise.ogg',
        },

        {
            name = 'Moonlight Sonata 3rd Movement',
            artist = 'Ludwig Van Beethoven',
            audio = assets.getAudio('classical2'),
            path = 'assets/classical/Beethoven - Moonlight Sonata 3rd Movement.ogg'
        },

        {
            name = 'Carmen Overture',
            artist = 'Alexandre Cesar Leopold Bizet',
            audio = assets.getAudio('classical3'),
            path = 'assets/classical/Bizet - Carmen  Overture.ogg'
        },


        {
            name = 'In the Hall of the Mountain King',
            artist = 'Edvard Grieg',
            audio = assets.getAudio('classical4'),
            path = 'assets/classical/Grieg - In the Hall of the Mountain King.ogg'
        },


        {
            name = 'Erika',
            artist = 'Herms Niel',
            audio = assets.getAudio('classical5'),
            path = 'assets/classical/Herms Niel - Erika.ogg'
        },


        {
            name = 'The Blue Danube Waltz',
            artist = 'Johann Strauss II',
            audio = assets.getAudio('classical6'),
            path = 'assets/classical/Johann Strauss II - The Blue Danube Waltz.ogg'
        },


        {
            name = 'Eine Kleine Nachtmusik',
            artist = 'Wolfgang Amadeus Mozart',
            audio = assets.getAudio('classical7'),
            path = 'assets/classical/Mozart - Eine Kleine Nachtmusik.ogg'
        },

        {
            name = 'Can Can',
            artist = 'Jacques Offenbach',
            audio = assets.getAudio('classical8'),
            path = 'assets/classical/Offenbach - Can Can Music.ogg'
        },

        {
            name = 'William Tell Overture',
            artist = 'Gioachino Rossini',
            audio = assets.getAudio('classical9'),
            path = 'assets/classical/Rossini - William Tell Overture Final.ogg'
        },

        {
            name = 'Russian Dance Trepak',
            artist = 'Peter Ilyich Tchaikovsky',
            audio = assets.getAudio('classical10'),
            path = 'assets/classical/Tchaikovsky - Nutcracker Suite  Russian Dance Trepak.ogg'
        }
    },

    ballad = {
        {
            name = 'Hello',
            artist = 'Adele',
            audio = assets.getAudio('ballad1'),
            path = 'assets/ballad/Adele - Hello.ogg'
        },

        {
            name = 'Every Woman In The World',
            artist = 'Air supply',
            audio = assets.getAudio('ballad2'),
            path = 'assets/ballad/Air Supply - Every Woman In The World.ogg'
        },

        {
            name = 'The Truth Unfold',
            artist = 'BTS',
            audio = assets.getAudio('ballad3'),
            path = 'assets/ballad/BTS - The Truth Untold.ogg'
        },

        {
            name = 'My Heart Will Go On',
            artist = 'Celine Dion',
            audio = assets.getAudio('ballad4'),
            path = 'assets/ballad/Celine Dion - My Heart Will Go On.ogg'
        },

        {
            name = 'The Power Of Love',
            artist = 'Celine Dion',
            audio = assets.getAudio('ballad5'),
            path = 'assets/ballad/Celine Dion - The Power Of Love.ogg'
        },

        {
            name = 'A Thousand Years',
            artist = 'Christina Perri',
            audio = assets.getAudio('ballad6'),
            path = 'assets/ballad/Christina Perri - A Thousand Years.ogg'
        },

        {
            name = 'Cant Help Falling In Love',
            artist = 'Elvis Presley',
            audio = assets.getAudio('ballad7'),
            path = 'assets/ballad/Elvis Presley - Cant Help Falling In Love.ogg'
        },

        {
            name = 'Good Old-Fashioned Lover Boy',
            artist = 'Queen',
            audio = assets.getAudio('ballad8'),
            path = 'assets/ballad/Queen - Good Old Fashioned Lover Boy.ogg'
        },

        {
            name = 'Doughnut',
            artist = 'TWICE',
            audio = assets.getAudio('ballad9'),
            path = 'assets/ballad/TWICE - Doughnut.ogg'
        },

        {
            name = 'Swear It Again',
            artist = 'Westlife',
            audio = assets.getAudio('ballad10'),
            path = 'assets/ballad/Westlife - Swear It Again.ogg'
        }
    },

    rock = {
        {
            name = 'Livin On A Prayer',
            artist = 'Bon Jovi',
            audio = assets.getAudio('rock1'),
            path = 'assets/rock/Bon Jovi - Livin On A Prayer.ogg'
        },

        {
            name = 'You Spin Me Round (Like a Record)',
            artist = 'Dead Or Alive',
            audio = assets.getAudio('rock2'),
            path = 'assets/rock/Dead Or Alive - You Spin Me Round Like a Record.ogg'
        },

        {
            name = 'Hotel California',
            artist = 'Eagles',
            audio = assets.getAudio('rock3'),
            path = 'assets/rock/Eagles - Hotel California.ogg'
        },

        {
            name = 'Kashmir',
            artist = 'Led Zepelin',
            audio = assets.getAudio('rock4'),
            path = 'assets/rock/Led Zeppelin - Kashmir.ogg'
        },

        {
            name = 'In The End',
            artist = 'Linkin Park',
            audio = assets.getAudio('rock5'),
            path = 'assets/rock/Linkin Park - In The End.ogg'
        },

        {
            name = 'Hayloft II',
            artist = 'Mother Mother',
            audio = assets.getAudio('rock6'),
            path = 'assets/rock/Mother Mother - Hayloft II.ogg'
        },

        {
            name = 'Heart-Shaped Box',
            artist = 'Nirvana',
            audio = assets.getAudio('rock7'),
            path = 'assets/rock/Nirvana - Heartshaped Box.ogg'
        },

        {
            name = 'Bismarck',
            artist = 'Sabaton',
            audio = assets.getAudio('rock8'),
            path = 'assets/rock/Sabaton - Bismarck.ogg'
        },

        {
            name = 'Hey Jude',
            artist = 'The Beatles',
            audio = assets.getAudio('rock9'),
            path = 'assets/rock/The Beatles - Hey Jude.ogg'
        },

        {
            name = 'Embraced by the Flame',
            artist = 'UNDEAD CORPORATION',
            audio = assets.getAudio('rock10'),
            path = 'assets/rock/UNDEAD CORPORATION - Embraced by the Flame.ogg'
        }
    },

    -- Special [to be implement]
    --meme = {},
    --weeb = {},

    custom = {}
}

function musics.setVolume(volume)
    for _, value in pairs(musics) do
        if type(value) == 'table' then
            for _, music in ipairs(value) do
                music.audio:setVolume(volume)
            end
        end
    end
end

return musics