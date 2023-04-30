local resultMenu = require('scripts.interface.group').new(false, true)

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

local window = drwFrame.new(assets.getImage('frameWindow2'), 26, 26, 92, 204)
local title = drwText.new('Einstein TV', 26, 26, 92, 8)

-- Sprite
local TV = {
    antenna = drwImage.new(assets.getImage('tvAntenna'), 39, 1),
    speaker = drwImage.new(assets.getImage('tvSpeaker'), 26, 38),
    screen = drwImage.new(assets.getImage('tvScreen'), 26, 59),
    radio = drwImage.new(assets.getImage('tvRadio'), 44, 175),
    stand = drwImage.new(assets.getImage('tvStand'), 18, 231)
}

-- Buttons
local retxitButton = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 31, 203, 22, 22),
    icon = drwImage.new(assets.getImage('iconRetxit'), 31, 203),
    ntr = ntrRect.new(31, 203, 22, 22)
}
local switchNextMenu = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 95, 203, 18, 22),
    icon = drwImage.new(assets.getImage('iconRightArrow'), 93, 203),
    ntr = ntrRect.new(95, 203, 18, 22)
}
local switchPreviousMenu = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 65, 203, 18, 22),
    icon = drwImage.new(assets.getImage('iconleftArrow'), 63, 203),
    ntr = ntrRect.new(65, 203, 18, 22)
}

local nextButton = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 107, 180, 6, 6),
    icon = drwImage.new(assets.getImage('iconRightArrowSmall'), 107, 180),
    ntr = ntrRect.new(107, 180, 6, 6)
}

local previousButton = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 31, 180, 6, 6),
    icon = drwImage.new(assets.getImage('iconleftArrowSmall'), 31, 180),
    ntr = ntrRect.new(31, 180, 6, 6)
}

-- Sub groups
local retxitMenu = require 'scripts.interfaces.result-menu.retxit-menu'

local topInfo = {
    
}

resultMenu:connect(window)
resultMenu:connect(title)

resultMenu:connect(TV)

resultMenu:connect(switchNextMenu)
resultMenu:connect(switchPreviousMenu)
resultMenu:connect(retxitButton)

resultMenu:connect(nextButton)
resultMenu:connect(previousButton)

resultMenu:connect(retxitMenu)

-- Events
resultMenu.event:add('update', function (dt)
    if not retxitMenu.isLocked then
        return
    end

    if retxitButton.ntr.isClicked then
        retxitMenu:toggle()
        sfx.play('click')
    end

    if switchPreviousMenu.ntr.isClicked then
        sfx.play('click')
    end

    if switchNextMenu.ntr.isClicked then
        sfx.play('click')
    end

    if nextButton.ntr.isClicked then
        sfx.play('click')
    end

    if previousButton.ntr.isClicked then
        sfx.play('click')
    end
end)

resultMenu.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(assets.getFont('small'))

    window:draw()
    title:draw()

    TV.antenna:draw()
    TV.speaker:draw()
    TV.screen:draw()
    TV.radio:draw()
    TV.stand:draw()

    color.conditionRGB(switchNextMenu.ntr.isCursorHovering and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    switchNextMenu.frame:draw()
    switchNextMenu.icon:draw()

    color.conditionRGB(switchPreviousMenu.ntr.isCursorHovering and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    switchPreviousMenu.frame:draw()
    switchPreviousMenu.icon:draw()

    color.conditionRGB(retxitButton.ntr.isCursorHovering and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    retxitButton.frame:draw()
    retxitButton.icon:draw()

    color.conditionRGB(nextButton.ntr.isCursorHovering and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    nextButton.frame:draw()
    nextButton.icon:draw()

    color.conditionRGB(previousButton.ntr.isCursorHovering and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    previousButton.frame:draw()
    previousButton.icon:draw()

    love.graphics.setColor(1, 1, 1, 1)
end)

return resultMenu