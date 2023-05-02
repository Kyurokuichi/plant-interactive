--[[
    Assets Module

    This is the module for loading assets to be use in the game
    (Sprites, UIs stuffs, SFX, etc.)
--]]

local assets = {
    image = {},
    font = {},
    audio = {},
    video = {}
}

local function loadImage(name, path)
    assets.image[name] = love.graphics.newImage(path)
end

local function loadFont(name, path, size)
    assets.font[name] = love.graphics.newFont(path, size)
end

local function loadAudio(name, path, type)
    assets.audio[name] = love.audio.newSource(path, type or 'stream')
end

local function loadVideo(name, path)
    assets.video[name] = love.graphics.newVideo(path)
end

function assets.loadLeast()
    loadImage('einsteinSquad', 'assets/einstein-squad.png')
end

function assets.loadAll()
    -- Sprite Objects
    loadImage('backgroundRoom'    , 'assets/room.png')
    loadImage('pot'               , 'assets/pot.png')
    loadImage('leftSpeaker'       , 'assets/speaker_left.png')
    loadImage('rightSpeaker'      , 'assets/speaker_right.png')
    loadImage('clock'             , 'assets/clock.png')

    -- Background
    loadImage('backgroundCity'        , 'assets/background-city.png')
    loadImage('backgroundTown'        , 'assets/background-town.png')
    loadImage('backgroundPowerLines'  , 'assets/background-power_lines.png')
    loadImage('backgroundLeavesInner' , 'assets/background-leaves_inner.png')
    loadImage('backgroundLeavesInner2', 'assets/background-leaves_inner_2.png')
    loadImage('backgroundLeavesOuter' , 'assets/background-leaves_outer.png')
    loadImage('backgroundLetterBox'   , 'assets/background-letterbox.png')

    -- Water meter
    loadImage('waterLevel'        , 'assets/water_meter.png')
    loadImage('meterIndicator'    , 'assets/meter_indicator.png')
    --loadImage('wateringLevel'     , 'assets/watering_meter.png')
    --loadImage('meterIndicatorLong', 'assets/meter_indicator_long.png')

    -- Plant Images
    loadImage('internode', 'assets/plant-internode.png')
    loadImage('leaf'     , 'assets/plant-leaf.png')

    -- Menus Overlay Designs
    loadImage('overlayDry'    , 'assets/overlay-dry.png')
    loadImage('overlayHealthy', 'assets/overlay-healthy.png')
    loadImage('overlaySwamped', 'assets/overlay-swamped.png')

    -- Results Menu Designs
    loadImage('tvAntenna', 'assets/tv-antenna.png')
    loadImage('tvSpeaker', 'assets/tv-speaker.png')
    loadImage('tvScreen' , 'assets/tv-screen.png')
    loadImage('tvRadio'  , 'assets/tv-radio.png')
    loadImage('tvStand'  , 'assets/tv-stand.png')
    loadImage('graph'    , 'assets/graph.png')

    -- Frames
    loadImage('frameButton1', 'assets/frame-button_1.png')
    loadImage('frameButton2', 'assets/frame-button_2.png')
    loadImage('frameButton3', 'assets/frame-button_3.png')
    loadImage('frameButton4', 'assets/frame-button_4.png')
    loadImage('frameButton5', 'assets/frame-button_5.png')
    loadImage('frameButton6', 'assets/frame-button_6.png')
    loadImage('frameButton7', 'assets/frame-button_7.png')
    loadImage('frameWindow1', 'assets/frame-window_1.png')
    loadImage('frameWindow2', 'assets/frame-window_2.png')

    -- Icons
    loadImage('iconMenuPots'       , 'assets/icon-menu_pots.png')
    loadImage('iconMenuMusics'     , 'assets/icon-menu_musics.png')
    loadImage('iconMenuMore'       , 'assets/icon-menu_more.png')
    loadImage('iconAdd'            , 'assets/icon-add.png')
    loadImage('iconBack'           , 'assets/icon-back.png')
    loadImage('iconClose'          , 'assets/icon-close.png')
    loadImage('iconGame'           , 'assets/icon-game.png')
    loadImage('iconIndicatorVolume', 'assets/icon-indicator_volume.png')
    loadImage('iconleftArrowSmall' , 'assets/icon-left_arrow_small.png')
    loadImage('iconleftArrow'      , 'assets/icon-left_arrow.png')
    loadImage('iconPot'            , 'assets/icon-pot.png')
    loadImage('iconPreview'        , 'assets/icon-preview.png')
    loadImage('iconRemove'         , 'assets/icon-remove.png')
    loadImage('iconRightArrowSmall', 'assets/icon-right_arrow_small.png')
    loadImage('iconRightArrow'     , 'assets/icon-right_arrow.png')
    loadImage('iconWaterMeter'     , 'assets/icon-water_meter.png')
    loadImage('iconWatering'       , 'assets/icon-watering.png')
    loadImage('iconCheck'          , 'assets/icon-check.png')
    loadImage('iconRetxit'         , 'assets/icon-retxit.png')
    loadImage('iconRetry'          , 'assets/icon-retry.png')
    loadImage('iconExit'           , 'assets/icon-exit.png')
    loadImage('iconWarn'           , 'assets/icon-warn.png')
    loadImage('iconAbout'          , 'assets/icon-about.png')

    -- Fonts
    loadFont('small' , 'assets/font.ttf', 8)
    loadFont('normal', 'assets/font.ttf', 16)
    loadFont('medium', 'assets/font.ttf', 24)
    loadFont('large' , 'assets/font.ttf', 32)

    -- SFX
    loadAudio('sfxClick'          , 'assets/sfx-click.ogg')
    loadAudio('sfxConfirm'        , 'assets/sfx-confirm.ogg')
    loadAudio('sfxWarning'        , 'assets/sfx-warning.ogg')
    loadAudio('sfxWarning2'       , 'assets/sfx-warning_2.ogg')
    loadAudio('sfxWater'          , 'assets/sfx-water.ogg')
    loadAudio('sfxWaterProduction', 'assets/sfx-water_production.ogg')

    -- Classical Musics
    loadAudio('classical1' , 'assets/classical/Beethoven - Fur Elise.ogg')
    loadAudio('classical2' , 'assets/classical/Beethoven - Moonlight Sonata 3rd Movement.ogg')
    loadAudio('classical3' , 'assets/classical/Bizet - Carmen  Overture.ogg')
    loadAudio('classical4' , 'assets/classical/Grieg - In the Hall of the Mountain King.ogg')
    loadAudio('classical5' , 'assets/classical/Herms Niel - Erika.ogg' )
    loadAudio('classical6' , 'assets/classical/Johann Strauss II - The Blue Danube Waltz.ogg')
    loadAudio('classical7' , 'assets/classical/Mozart - Eine Kleine Nachtmusik.ogg')
    loadAudio('classical8' , 'assets/classical/Offenbach - Can Can Music.ogg')
    loadAudio('classical9' , 'assets/classical/Rossini - William Tell Overture Final.ogg')
    loadAudio('classical10', 'assets/classical/Tchaikovsky - Nutcracker Suite  Russian Dance Trepak.ogg')

    -- Ballad Musics
    loadAudio('ballad1' , 'assets/ballad/Adele - Hello.ogg')
    loadAudio('ballad2' , 'assets/ballad/Air Supply - Every Woman In The World.ogg')
    loadAudio('ballad3' , 'assets/ballad/BTS - The Truth Untold.ogg')
    loadAudio('ballad4' , 'assets/ballad/Celine Dion - My Heart Will Go On.ogg')
    loadAudio('ballad5' , 'assets/ballad/Celine Dion - The Power Of Love.ogg')
    loadAudio('ballad6' , 'assets/ballad/Christina Perri - A Thousand Years.ogg')
    loadAudio('ballad7' , 'assets/ballad/Elvis Presley - Cant Help Falling In Love.ogg')
    loadAudio('ballad8' , 'assets/ballad/Queen - Good Old Fashioned Lover Boy.ogg')
    loadAudio('ballad9' , 'assets/ballad/TWICE - Doughnut.ogg')
    loadAudio('ballad10', 'assets/ballad/Westlife - Swear It Again.ogg')

    -- Rock Musics
    loadAudio('rock1' , 'assets/rock/Bon Jovi - Livin On A Prayer.ogg')
    loadAudio('rock2' , 'assets/rock/Dead Or Alive - You Spin Me Round Like a Record.ogg')
    loadAudio('rock3' , 'assets/rock/Eagles - Hotel California.ogg')
    loadAudio('rock4' , 'assets/rock/Led Zeppelin - Kashmir.ogg')
    loadAudio('rock5' , 'assets/rock/Linkin Park - In The End.ogg')
    loadAudio('rock6' , 'assets/rock/Mother Mother - Hayloft II.ogg')
    loadAudio('rock7' , 'assets/rock/Nirvana - Heartshaped Box.ogg')
    loadAudio('rock8' , 'assets/rock/Sabaton - Bismarck.ogg')
    loadAudio('rock9' , 'assets/rock/The Beatles - Hey Jude.ogg')
    loadAudio('rock10', 'assets/rock/UNDEAD CORPORATION - Embraced by the Flame.ogg')
end

assets.loadImage = loadImage
assets.loadFont = loadFont
assets.loadAudio = loadAudio
assets.loadVideo = loadVideo

function assets.getImage(name)
    return assets.image[name]
end

function assets.getFont(name)
    return assets.font[name]
end

function assets.getAudio(name)
    return assets.audio[name]
end

function assets.getVideo(name)
    return assets.video[name]
end

return assets