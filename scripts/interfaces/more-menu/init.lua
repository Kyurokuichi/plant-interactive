-- General
local assets  = require 'scripts.assets'
local screen = require 'scripts.screen'
local sysntf = require 'scripts.sysntf'
local player = require 'scripts.player'
local enums = require 'scripts.enums'
local musics = require 'scripts.musics'
local color = require 'scripts.color'
local sfx = require 'scripts.sfx'
local overlay = require 'scripts.overlay'

-- Interface classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect = require 'scripts.interface.elements.ntr-rect'

local moreMenu = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.getImage('frameWindow1'), 26, 26, 92, 204)
local title = drwText.new('More', 26, 26, 92, 8)

local backButton = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 53, 203, 38, 22),
    icon = drwImage.new(assets.getImage('iconBack'), 61, 203),
    ntr = ntrRect.new(53, 203, 38, 22)
}
local masterVolume = {
    title = drwText.new('Master Volume', 26, 39, 98, 8),
    frame = drwFrame.new(assets.getImage('frameButton3'), 31, 58, 82, 6),
    indicator = drwImage.new(assets.getImage('iconIndicatorVolume'), 31, 58),
    ntr = ntrRect.new(31, 58, 82, 6)
}
local musicVolume = {
    title = drwText.new('Music Volume', 26, 75, 98, 8),
    frame = drwFrame.new(assets.getImage('frameButton3'), 31, 94, 82, 6),
    indicator = drwImage.new(assets.getImage('iconIndicatorVolume'), 31, 94),
    ntr = ntrRect.new(31, 94, 82, 6)
}
local SFXVolume = {
    title = drwText.new('SFX Volume', 26, 111, 98, 8),
    frame = drwFrame.new(assets.getImage('frameButton3'), 31, 130, 82, 6),
    indicator = drwImage.new(assets.getImage('iconIndicatorVolume'), 31, 130),
    ntr = ntrRect.new(31, 130, 82, 6)
}
local aboutButton = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 53, 167, 38, 14),
    icon = drwImage.new(assets.getImage('iconAbout'), 53, 167),
    ntr = ntrRect.new(53, 167, 38, 14)
}

local about = require 'scripts.interfaces.more-menu.about'

moreMenu:connect(window)
moreMenu:connect(title)

moreMenu:connect(backButton)
moreMenu:connect(masterVolume)
moreMenu:connect(musicVolume)
moreMenu:connect(SFXVolume)
moreMenu:connect(aboutButton)

moreMenu:connect(about)

local isOpened = false

local function setupVolume(element)
    element.indicator.x = element.frame.x + element.frame.width * 1
    element.indicator.x = element.indicator.x - element.indicator.width/2

    element.indicator.y = element.frame.y + element.frame.height/2
    element.indicator.y = element.indicator.y - element.indicator.height/2
end

local function returnMain()
    sysntf:getGroup(1):toggleLockOnly()
    moreMenu:toggle()
end

local function updateVolume(element)
    local mouseMoving = screen.toScreenCoords(love.mouse.getX()) ~= (element.indicator.x + element.indicator.width / 2)

    if (element.ntr.isClicked or element.ntr.isHoldingClick) and mouseMoving then
        sfx.play('click')

        element.indicator.x = screen.toScreenCoords(love.mouse.getX())
        element.indicator.x = math.min(element.indicator.x, element.frame.x + element.frame.width)
        element.indicator.x = math.max(element.indicator.x, element.frame.x)

        local rate = (element.indicator.x - element.frame.x) / element.frame.width

        element.indicator.x = element.indicator.x - element.indicator.width / 2

        return true, rate
    else
        return false, nil
    end
end

local function updateButtons()
    if aboutButton.ntr.isClicked then
        print('a')
        about:toggle()
        sfx.play('click')
    end

    if backButton.ntr.isClicked then
        returnMain()
        sfx.play('click')
    end

    do
        local isUpdate, rate = updateVolume(masterVolume)

        if isUpdate then
            player.configuration.masterVolume = rate
            love.audio.setVolume(rate)
        end
    end

    do
        local isUpdate, rate = updateVolume(musicVolume)

        if isUpdate then
            player.configuration.musicVolume = rate
            musics.setVolume(rate)
        end
    end

    do
        local isUpdate, rate = updateVolume(SFXVolume)

        if isUpdate then
            player.configuration.SFXVolume = rate
            sfx.setVolume(rate)
        end
    end
end

moreMenu.event:add('update', function (dt)

    if about.isLocked then
        updateButtons()
    end

    if not isOpened then
        setupVolume(masterVolume)
        setupVolume(musicVolume)
        setupVolume(SFXVolume)

        isOpened = true
    end
end)

moreMenu.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(assets.getFont('small'))

    window:draw()
    overlay:draw()

    color.RGB(60, 163, 112, true)

    title:draw()
    SFXVolume.title:draw()
    musicVolume.title:draw()
    masterVolume.title:draw()

    color.conditionRGB(backButton.ntr.isHoldingClick, 0.5, 0.5, 0.5, 1, 1, 1, true)
    backButton.frame:draw()
    backButton.icon:draw()

    color.conditionRGB(masterVolume.ntr.isHoldingClick, 0.5, 0.5, 0.5, 1, 1, 1, true)
    masterVolume.frame:draw()
    masterVolume.indicator:draw()

    color.conditionRGB(musicVolume.ntr.isHoldingClick, 0.5, 0.5, 0.5, 1, 1, 1, true)
    musicVolume.frame:draw()
    musicVolume.indicator:draw()

    color.conditionRGB(SFXVolume.ntr.isHoldingClick, 0.5, 0.5, 0.5, 1, 1, 1, true)
    SFXVolume.frame:draw()
    SFXVolume.indicator:draw()

    color.conditionRGB(aboutButton.ntr.isHoldingClick, 0.5, 0.5, 0.5, 1, 1, 1, true)
    aboutButton.frame:draw()
    aboutButton.icon:draw()

    love.graphics.setColor(1, 1, 1, 1)
end)

return moreMenu