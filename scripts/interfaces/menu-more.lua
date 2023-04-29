-- Modules
local assets = require 'scripts.assets'
local color  = require 'scripts.interface.color'
local sysntf = require 'scripts.sysntf'
local screen = require 'scripts.screen'
local player = require 'scripts.player'
local musics = require 'scripts.musics'
local sfx    = require 'scripts.sfx'

-- Classes
local drwImage      = require 'scripts.interface.elements.drw-image'
local drwFrame      = require 'scripts.interface.elements.drw-frame'
local drwText       = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect       = require 'scripts.interface.elements.ntr-rect'

local menuMore = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.image.frameWindow1, 26, 26, 92, 204)
local overlay = drwImage.new(assets.image.overlayHealthy, -2, -2)
local title = drwText.new('More', 26, 26, 92, 8)
menuMore:connect(window)
menuMore:connect(overlay)
menuMore:connect(title)

local backButton = {
    frame = drwFrame.new(assets.image.frameButton3, 53, 203, 38, 22),
    icon  = drwImage.new(assets.image.iconBack, 61, 203),
    ntr   = ntrRect.new(53, 203, 38, 22)
}
local masterVolume = {
    title     = drwText.new('Master Volume', 26, 39, 98, 8),
    frame     = drwFrame.new(assets.image.frameButton3, 31, 58, 82, 6),
    indicator = drwImage.new(assets.image.iconIndicatorVolume, 31, 58),
    ntr       = ntrRect.new(31, 58, 82, 6)
}
local musicVolume = {
    title     = drwText.new('Music Volume', 26, 75, 98, 8),
    frame     = drwFrame.new(assets.image.frameButton3, 31, 94, 82, 6),
    indicator = drwImage.new(assets.image.iconIndicatorVolume, 31, 94),
    ntr       = ntrRect.new(31, 94, 82, 6)
}
local SFXVolume = {
    title     = drwText.new('SFX Volume', 26, 111, 98, 8),
    frame     = drwFrame.new(assets.image.frameButton3, 31, 130, 82, 6),
    indicator = drwImage.new(assets.image.iconIndicatorVolume, 31, 130),
    ntr       = ntrRect.new(31, 130, 82, 6)
}

local isOpened = false

menuMore:connect(backButton)
menuMore:connect(masterVolume)
menuMore:connect(musicVolume)
menuMore:connect(SFXVolume)

local function setupVolume(element)
    element.indicator.x = element.frame.x + element.frame.width * 1
    element.indicator.x = element.indicator.x - element.indicator.width/2

    element.indicator.y = element.frame.y + element.frame.height/2
    element.indicator.y = element.indicator.y - element.indicator.height/2
end

local function updateVolume(element)
    if element.ntr.isClicked or element.ntr.isHoldingClick then
        sfx:emitSound('click')

        element.indicator.x = screen:translate(love.mouse.getX())
        element.indicator.x = math.min(element.indicator.x, element.frame.x + element.frame.width)
        element.indicator.x = math.max(element.indicator.x, element.frame.x)

        local rate = (element.indicator.x - element.frame.x) / element.frame.width

        element.indicator.x = element.indicator.x - element.indicator.width / 2

        return rate
    end
end

local function returnMain()
    sysntf:getGroup(1):toggleLockOnly()
    menuMore:toggle()
end

menuMore.event:add('update', function (dt)
    if backButton.ntr.isClicked then
        returnMain()
        sfx:emitSound('click')
    end

    local oldMasterVolume = player.settings.masterVolume
    player.settings.masterVolume = updateVolume(masterVolume) or player.settings.masterVolume

    if player.settings.masterVolume ~= oldMasterVolume then
        love.audio.setVolume(player.settings.masterVolume)
    end

    local oldMusicVolume = player.settings.musicVolume
    player.settings.musicVolume = updateVolume(musicVolume) or player.settings.musicVolume

    if player.settings.musicVolume ~= oldMusicVolume then
        musics:setVolume(player.settings.musicVolume)
    end

    local oldSFXValue = player.settings.SFXVolume
    player.settings.SFXVolume = updateVolume(SFXVolume) or player.settings.SFXVolume

    if player.settings.SFXVolume ~= oldSFXValue then
        sfx:updateVolume(player.settings.SFXVolume)
    end

    if not isOpened then
        setupVolume(masterVolume)
        setupVolume(musicVolume)
        setupVolume(SFXVolume)

        isOpened = true
    end
end)

menuMore.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1)

    window:draw()
    overlay:draw()

    color.RGB(60, 163, 112, true)
    title:draw()
    SFXVolume.title:draw()
    musicVolume.title:draw()
    masterVolume.title:draw()

    color.conditionRGB(backButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    backButton.frame:draw()
    backButton.icon:draw()

    color.conditionRGB(masterVolume.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    masterVolume.frame:draw()
    masterVolume.indicator:draw()

    color.conditionRGB(musicVolume.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    musicVolume.frame:draw()
    musicVolume.indicator:draw()

    color.conditionRGB(SFXVolume.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    SFXVolume.frame:draw()
    SFXVolume.indicator:draw()

    love.graphics.setColor(1, 1, 1)
end)

return menuMore