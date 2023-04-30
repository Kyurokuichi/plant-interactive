local retxitMenu = require('scripts.interface.group').new(false, true)

-- General
local assets  = require 'scripts.assets'
local screen = require 'scripts.screen'
local sysntf = require 'scripts.sysntf'
local player = require 'scripts.player'
local enums = require 'scripts.enums'
local musics = require 'scripts.musics'
local color = require 'scripts.color'
local sfx = require 'scripts.sfx'

-- Interface classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect = require 'scripts.interface.elements.ntr-rect'

local window = drwFrame.new(assets.getImage('frameWindow1'), 26, 82, 92, 92)
local title = drwText.new('Retry & Exit Menu', 26, 82, 92, 8)

-- Buttons
local backButton = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 35, 103, 74, 22),
    icon = drwImage.new(assets.getImage('iconBack'), 60, 103),
    ntr = ntrRect.new(35, 103, 74, 22)
}

local retryButton = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 35, 141, 28, 22),
    icon = drwImage.new(assets.getImage('iconRetry'), 38, 141),
    ntr = ntrRect.new(35, 141, 28, 22)
}

local exitButton = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 81, 141, 28, 22),
    icon = drwImage.new(assets.getImage('iconExit'), 84, 141),
    ntr = ntrRect.new(81, 141, 28, 22)
}

retxitMenu:connect(backButton)
retxitMenu:connect(retryButton)
retxitMenu:connect(exitButton)

retxitMenu.event:add('update', function (dt)
    if backButton.ntr.isClicked then
        retxitMenu:toggle()
        sfx.play('click')
    end

    if exitButton.ntr.isClicked then
        love.event.quit(0)
    end

    if retryButton.ntr.isClicked then
        love.event.quit('restart')
    end
end)

retxitMenu.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(assets.getFont('small'))

    window:draw()
    title:draw()

    color.conditionRGB(backButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    backButton.frame:draw()
    backButton.icon:draw()

    color.conditionRGB(retryButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    retryButton.frame:draw()
    retryButton.icon:draw()

    color.conditionRGB(exitButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    exitButton.frame:draw()
    exitButton.icon:draw()

    love.graphics.setColor(1, 1, 1, 1)
end)



return retxitMenu