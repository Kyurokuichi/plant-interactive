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

    assets.video = {}
    assets.video.konami         = love.graphics.newVideo('assets/konami.ogv')

end

return assets