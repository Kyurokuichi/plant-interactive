local assets = {}

function assets:initialize()
    self.initialize = nil

    self.image = {}

    -- Sprites (objects, backgrounds)
    self.image.backgroundRoom   = love.graphics.newImage('assets/room.png')
    self.image.pot              = love.graphics.newImage('assets/pot.png')
    self.image.leftSpeaker      = love.graphics.newImage('assets/speaker_left.png')
    self.image.rightSpeaker     = love.graphics.newImage('assets/speaker_right.png')
    self.image.waterLevel       = love.graphics.newImage('assets/water_meter.png')

    -- Overlays (Design)
    self.image.overlayDry       = love.graphics.newImage('assets/overlay-dry.png')
    self.image.overlayHealthy   = love.graphics.newImage('assets/overlay-healthy.png')
    self.image.overlaySwamped   = love.graphics.newImage('assets/overlay-swamped.png')

    -- Frames
    self.image.frameButton1         = love.graphics.newImage('assets/frame-button_1.png')
    self.image.frameButton2         = love.graphics.newImage('assets/frame-button_2.png')
    self.image.frameButton3         = love.graphics.newImage('assets/frame-button_3.png')
    self.image.frameButton4         = love.graphics.newImage('assets/frame-button_4.png')
    self.image.frameButton5         = love.graphics.newImage('assets/frame-button_5.png')
    self.image.frameWindow1         = love.graphics.newImage('assets/frame-window_1.png')

    -- Icons
    self.image.iconMenuPots         = love.graphics.newImage('assets/icon-menu_pots.png')
    self.image.iconMenuMusics       = love.graphics.newImage('assets/icon-menu_musics.png')
    self.image.iconMenuMore         = love.graphics.newImage('assets/icon-menu_more.png')
    self.image.iconAdd              = love.graphics.newImage('assets/icon-add.png')
    self.image.iconBack             = love.graphics.newImage('assets/icon-back.png')
    self.image.iconClose            = love.graphics.newImage('assets/icon-close.png')
    self.image.iconGame             = love.graphics.newImage('assets/icon-game.png')
    self.image.iconIndicatorVolume  = love.graphics.newImage('assets/icon-indicator_volume.png')
    self.image.iconleftArrowSmall   = love.graphics.newImage('assets/icon-left_arrow_small.png')
    self.image.iconleftArrow        = love.graphics.newImage('assets/icon-left_arrow.png')
    self.image.iconPot              = love.graphics.newImage('assets/icon-pot.png')
    self.image.iconPreview          = love.graphics.newImage('assets/icon-preview.png')
    self.image.iconRemove           = love.graphics.newImage('assets/icon-remove.png')
    self.image.iconRightArrowSmall  = love.graphics.newImage('assets/icon-right_arrow_small.png')
    self.image.iconRightArrow       = love.graphics.newImage('assets/icon-right_arrow.png')

    self.font = {}

    -- Fonts
    self.font.small     = love.graphics.newFont('assets/font.ttf', 8)
    self.font.normal    = love.graphics.newFont('assets/font.ttf', 16)
    self.font.medium    = love.graphics.newFont('assets/font.ttf', 24)
    self.font.large     = love.graphics.newFont('assets/font.ttf', 32)

    self.audio = {}

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
    assets.audio.ballad7        = love.audio.newSource('assets/ballad/Elvis Presley - Cant Help Falling In Love.ogg', 'stream')
    assets.audio.ballad8        = love.audio.newSource('assets/ballad/Queen - Good Old Fashioned Lover Boy.ogg', 'stream')
    assets.audio.ballad9        = love.audio.newSource('assets/ballad/TWICE - Doughnut.ogg', 'stream')
    assets.audio.ballad10       = love.audio.newSource('assets/ballad/Westlife - Swear It Again.ogg', 'stream')

    assets.audio.rock1          = love.audio.newSource('assets/rock/Bon Jovi - Livin On A Prayer.ogg', 'stream')
    assets.audio.rock2          = love.audio.newSource('assets/rock/Dead Or Alive - You Spin Me Round Like a Record.ogg', 'stream')
    assets.audio.rock3          = love.audio.newSource('assets/rock/Eagles - Hotel California.ogg', 'stream')
    assets.audio.rock4          = love.audio.newSource('assets/rock/Led Zeppelin - Kashmir.ogg', 'stream')
    assets.audio.rock5          = love.audio.newSource('assets/rock/Linkin Park - In The End.ogg', 'stream')
    assets.audio.rock6          = love.audio.newSource('assets/rock/Mother Mother - Hayloft II.ogg', 'stream')
    assets.audio.rock7          = love.audio.newSource('assets/rock/Nirvana - Heartshaped Box.ogg', 'stream')
    assets.audio.rock8          = love.audio.newSource('assets/rock/Sabaton - Bismarck.ogg', 'stream')
    assets.audio.rock9          = love.audio.newSource('assets/rock/The Beatles - Hey Jude.ogg', 'stream')
    assets.audio.rock10         = love.audio.newSource('assets/rock/UNDEAD CORPORATION - Embraced by the Flame.ogg', 'stream')

    self.video = {}


end

return assets