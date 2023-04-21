local assets    = require('scripts.assets')
local sysintf   = require('scripts.sysintf')
local player    = require('scripts.player')
local screen    = require('scripts.screen')

local color     = require('scripts.interface.color')

local drwImage  = require('scripts.interface.elements.drw-image')
local drwFrame  = require('scripts.interface.elements.drw-frame')
local drwText   = require('scripts.interface.elements.drw-text')
local ntrRect   = require('scripts.interface.elements.ntr-rect')

local moreMenu = require('scripts.interface.group').new(false, true)

local window    = drwFrame.new(assets.image.frameWindow, 26, 26, 92, 204)
moreMenu:connect(window)

local title          = drwText.new('More', 26, 26, 98, 8)
moreMenu:connect(title)

local masterVolume = {
    title     = drwText.new('Master Volume', 26, 39, 98, 8),
    frame     = drwFrame.new(assets.image.frameButton1, 31, 58, 82, 6),
    indicator = drwImage.new(assets.image.iconIndicatorLarge),
    ntr       = ntrRect.new(31, 58, 82, 6)
}
moreMenu:connect(masterVolume.title)
moreMenu:connect(masterVolume.frame)
moreMenu:connect(masterVolume.indicator)
moreMenu:connect(masterVolume.ntr)

local musicVolume = {
    title     = drwText.new('Music Volume', 26, 75, 98, 8),
    frame     = drwFrame.new(assets.image.frameButton1, 31, 94, 82, 6),
    indicator = drwImage.new(assets.image.iconIndicatorLarge),
    ntr       = ntrRect.new(31, 94, 82, 6)
}
moreMenu:connect(musicVolume.title)
moreMenu:connect(musicVolume.frame)
moreMenu:connect(musicVolume.indicator)
moreMenu:connect(musicVolume.ntr)

local SFXVolume = {
    title     = drwText.new('SFX Volume', 26, 111, 98, 8),
    frame     = drwFrame.new(assets.image.frameButton1, 31, 130, 82, 6),
    indicator = drwImage.new(assets.image.iconIndicatorLarge),
    ntr       = ntrRect.new(31, 130, 82, 6)
}
moreMenu:connect(SFXVolume.title)
moreMenu:connect(SFXVolume.frame)
moreMenu:connect(SFXVolume.indicator)
moreMenu:connect(SFXVolume.ntr)

local setup = false

moreMenu.event:add('update', function (dt)
    if not setup then
        masterVolume.indicator.x = masterVolume.frame.x + masterVolume.frame.width * player.settings.masterVolume
        masterVolume.indicator.x = masterVolume.indicator.x - masterVolume.indicator.width/2
        masterVolume.indicator.y = masterVolume.frame.y + masterVolume.frame.height/2
        masterVolume.indicator.y = masterVolume.indicator.y - masterVolume.indicator.height/2

        musicVolume.indicator.x = musicVolume.frame.x + musicVolume.frame.width * player.settings.musicVolume
        musicVolume.indicator.x = musicVolume.indicator.x - musicVolume.indicator.width/2
        musicVolume.indicator.y = musicVolume.frame.y + musicVolume.frame.height/2
        musicVolume.indicator.y = musicVolume.indicator.y - musicVolume.indicator.height/2

        SFXVolume.indicator.x = SFXVolume.frame.x + SFXVolume.frame.width * player.settings.SFXVolume
        SFXVolume.indicator.x = SFXVolume.indicator.x - SFXVolume.indicator.width/2
        SFXVolume.indicator.y = SFXVolume.frame.y + SFXVolume.frame.height/2
        SFXVolume.indicator.y = SFXVolume.indicator.y - SFXVolume.indicator.height/2

        setup = true
    end

    if masterVolume.ntr.isClicked or masterVolume.ntr.isHoldingClick then
        local lastX = masterVolume.indicator.x

        masterVolume.indicator.x, _ = screen.translatePosition(love.mouse.getPosition())
        masterVolume.indicator.x = math.min(math.max(masterVolume.frame.x, masterVolume.indicator.x), masterVolume.frame.x + masterVolume.frame.width)
        masterVolume.indicator.x = masterVolume.indicator.x - masterVolume.indicator.width/2 
    end

    if musicVolume.ntr.isClicked or musicVolume.ntr.isHoldingClick then
        
    end

    if SFXVolume.ntr.isClicked or SFXVolume.ntr.isHoldingClick then
        
    end
end)

moreMenu.event:add('draw', function ()
    window:draw()
    love.graphics.setColor(color.rgb(60, 163, 112))
    title:draw()
    masterVolume.title:draw()
    musicVolume.title:draw()
    SFXVolume.title:draw()

    love.graphics.setColor(1, 1, 1)

    masterVolume.frame:draw()
    musicVolume.frame:draw()
    SFXVolume.frame:draw()

    masterVolume.indicator:draw()
    musicVolume.indicator:draw()
    SFXVolume.indicator:draw()
end)

return moreMenu