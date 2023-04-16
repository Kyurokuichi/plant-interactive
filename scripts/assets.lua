local assets = {}

-- Run only once function
-- NOTE: this function commits suicide when execute (pun joke)
function assets.initialize()
    assets.initialize = nil

    assets.image = {}
    assets.image.room           = love.graphics.newImage('assets/room.png')
    assets.image.pot            = love.graphics.newImage('assets/pot.png')

    -- UIs
    assets.image.waterMeter     = love.graphics.newImage('assets/water-meter.png')

    -- Frames
    assets.image.frameButton    = love.graphics.newImage('assets/frame-button.png')
    assets.image.frameStart     = love.graphics.newImage('assets/frame-start.png')
    assets.image.frameWindow    = love.graphics.newImage('assets/frame-window.png')

    -- Icons
    assets.image.iconPotsMenu   = love.graphics.newImage('assets/icon-potsmenu.png')
    assets.image.iconMusicMenu  = love.graphics.newImage('assets/icon-musicmenu.png')
    assets.image.iconMoreMenu   = love.graphics.newImage('assets/icon-moremenu.png')

    assets.font = {}
    assets.font.small   = love.graphics.newFont('assets/font.ttf', 8)
    assets.font.normal  = love.graphics.newFont('assets/font.ttf', 16)
    assets.font.medium  = love.graphics.newFont('assets/font.ttf', 24)
    assets.font.large   = love.graphics.newFont('assets/font.ttf', 32)
end

return assets