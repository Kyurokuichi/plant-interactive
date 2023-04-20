local assets = {}

-- Run only once function
-- NOTE: this function commits suicide when execute (pun joke)
function assets.initialize()
    assets.initialize = nil

    assets.image = {}

    assets.image.room           = love.graphics.newImage('assets/room.png')
    assets.image.pot            = love.graphics.newImage('assets/pot.png')
    assets.image.leftSpeaker    = love.graphics.newImage('assets/speaker-left.png')
    assets.image.rightSpeaker   = love.graphics.newImage('assets/speaker-right.png')
    assets.image.nahida         = love.graphics.newImage('assets/nahida.png')

    -- UIs
    assets.image.waterMeter     = love.graphics.newImage('assets/water-meter.png')

    -- Frames
    assets.image.frameButton1   = love.graphics.newImage('assets/frame-button1.png')
    assets.image.frameButton2   = love.graphics.newImage('assets/frame-button2.png')
    assets.image.frameStart     = love.graphics.newImage('assets/frame-start.png')
    assets.image.frameWindow    = love.graphics.newImage('assets/frame-window.png')

    -- Icons
    assets.image.iconPotsMenu   = love.graphics.newImage('assets/icon-potsmenu.png')
    assets.image.iconMusicMenu  = love.graphics.newImage('assets/icon-musicmenu.png')
    assets.image.iconMoreMenu   = love.graphics.newImage('assets/icon-moremenu.png')
    assets.image.iconBack       = love.graphics.newImage('assets/icon-back.png')
    assets.image.iconRemove     = love.graphics.newImage('assets/icon-remove.png')
    assets.image.iconLeftArrow  = love.graphics.newImage('assets/icon-leftarrow.png')
    assets.image.iconRightArrow = love.graphics.newImage('assets/icon-rightarrow.png')

    assets.font = {}

    assets.font.small           = love.graphics.newFont('assets/font.ttf', 8)
    assets.font.normal          = love.graphics.newFont('assets/font.ttf', 16)
    assets.font.medium          = love.graphics.newFont('assets/font.ttf', 24)
    assets.font.large           = love.graphics.newFont('assets/font.ttf', 32)
    assets.font.impact          = love.graphics.newFont('assets/impact.ttf', 24)

    -- Audios
    assets.audio = {}

    assets.audio.konami         = love.audio.newSource('assets/konami.ogg', 'stream')

    -- Musics
    assets.audio.classical1     = love.audio.newSource('assets/classical/Beethoven - Fur Elise.ogg', 'stream')
    assets.audio.classical2     = love.audio.newSource('assets/classical/Beethoven - Moonlight Sonata 3rd Movement.ogg', 'stream')
    assets.audio.classical3     = love.audio.newSource('assets/classical/Bizet - Carmen  Overture.ogg', 'stream')
    assets.audio.classical4     = love.audio.newSource('assets/classical/Grieg - In the Hall of the Mountain King.ogg', 'stream')
    assets.audio.classical5     = love.audio.newSource('assets/classical/Herms Niel - Erika.ogg', 'stream')
    assets.audio.classical6     = love.audio.newSource('assets/classical/Johann Strauss II - The Blue Danube Waltz.ogg', 'stream')
    assets.audio.classical7     = love.audio.newSource('assets/classical/Mozart - Eine Kleine Nachtmusik.ogg', 'stream')
    assets.audio.classical8     = love.audio.newSource('assets/classical/Offenbach - Can Can Music.ogg', 'stream')
    assets.audio.classical9     = love.audio.newSource('assets/classical/Rossini - William Tell Overture Final.ogg', 'stream')
    assets.audio.classical10    = love.audio.newSource('assets/classical/Tchaikovsky - Nutcracker Suite  Russian Dance Trepak.ogg', 'stream')

    assets.audio.ballad1        = love.audio.newSource('assets/ballad/Adele - Hello.ogg', 'stream')
    assets.audio.ballad2        = love.audio.newSource('assets/ballad/Air Supply - Every Woman In The World.ogg', 'stream')
    assets.audio.ballad3        = love.audio.newSource('assets/ballad/BTS - The Truth Untold.ogg', 'stream')
    assets.audio.ballad4        = love.audio.newSource('assets/ballad/Celine Dion - My Heart Will Go On.ogg', 'stream')
    assets.audio.ballad5        = love.audio.newSource('assets/ballad/Celine Dion - The Power Of Love.ogg', 'stream')
    assets.audio.ballad6        = love.audio.newSource('assets/ballad/Christina Perri - A Thousand Years.ogg', 'stream')
    assets.audio.ballad7        = love.audio.newSource('assets/ballad/Elvis Presley - Cant Help Falling In Love Audio.ogg', 'stream')
    assets.audio.ballad8        = love.audio.newSource('assets/ballad/Queen - Good Old Fashioned Lover Boy.ogg', 'stream')
    assets.audio.ballad9        = love.audio.newSource('assets/ballad/TWICE - Doughnut.ogg', 'stream')
    assets.audio.ballad10       = love.audio.newSource('assets/ballad/Westlife - Swear It Again.ogg', 'stream')

    assets.audio.rock1          = love.audio.newSource('assets/rock/Bon Jovi - Livin On A Prayer Official Music Video.ogg', 'stream')
    assets.audio.rock2          = love.audio.newSource('assets/rock/Dead Or Alive - You Spin Me Round Like a Record Official Video.ogg', 'stream')
    assets.audio.rock3          = love.audio.newSource('assets/rock/Eagles - Hotel California.ogg', 'stream')
    assets.audio.rock4          = love.audio.newSource('assets/rock/Led Zeppelin - Kashmir.ogg', 'stream')
    assets.audio.rock5          = love.audio.newSource('assets/rock/Linkin Park - In The End Official.ogg', 'stream')
    assets.audio.rock6          = love.audio.newSource('assets/rock/Mother Mother - Hayloft II.ogg', 'stream')
    assets.audio.rock7          = love.audio.newSource('assets/rock/Nirvana - Heartshaped Box.ogg', 'stream')
    assets.audio.rock8          = love.audio.newSource('assets/rock/Sabaton - Bismarck.ogg', 'stream')
    assets.audio.rock9          = love.audio.newSource('assets/rock/The Beatles - Hey Jude.ogg', 'stream')
    assets.audio.rock10         = love.audio.newSource('assets/rock/UNDEAD CORPORATION - Embraced by the Flame.ogg', 'stream')

    assets.video = {}
    assets.video.konami         = love.graphics.newVideo('assets/konami.ogv')

end

return assets