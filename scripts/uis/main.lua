local assets    = require('scripts.assets')
local sysintf   = require('scripts.sysintf')

local color     = require('scripts.interface.color')

local drwImage  = require('scripts.interface.elements.drw-image')
local drwFrame  = require('scripts.interface.elements.drw-frame')
local drwText   = require('scripts.interface.elements.drw-text')
local ntrRect   = require('scripts.interface.elements.ntr-rect')

local main = require('scripts.interface.group').new()

local watermarkText = drwText.new('Made by A07-12 STEM-S2-3 Grp 1', 0, 246, 144, 8)

local innerBackground = drwImage.new(assets.image.room)

local frameButtonStart      = drwFrame.new(assets.image.frameStart , 45, 158, 54, 22)
local frameButtonPotsMenu   = drwFrame.new(assets.image.frameButton, 23, 216, 22, 22)
local frameButtonMusicMenu  = drwFrame.new(assets.image.frameButton, 61, 216, 22, 22)
local frameButtonMoreMenu   = drwFrame.new(assets.image.frameButton, 99, 216, 22, 22)

local iconButtonStart       = drwText.new('Start', 45, 158, 54, 22)
local iconButtonPotsMenu    = drwImage.new(assets.image.iconPotsMenu , 23, 216)
local iconButtonMusicMenu   = drwImage.new(assets.image.iconMusicMenu, 61, 216)
local iconButtonMoreMenu    = drwImage.new(assets.image.iconMoreMenu , 99, 216)

local ntrButtonStart        = ntrRect.new(45, 158, 54, 22)
local ntrButtonPotsMenu     = ntrRect.new(23, 216, 22, 22)
local ntrButtonMusicMenu    = ntrRect.new(61, 216, 22, 22)
local ntrButtonMoreMenu     = ntrRect.new(99, 216, 22, 22)

local waterMeter            = drwImage.new(assets.image.waterMeter, 32, 189)
local pot                   = drwImage.new(assets.image.pot, 40, 108)

main:connect(innerBackground)

main:connect(frameButtonStart)
main:connect(frameButtonPotsMenu)
main:connect(frameButtonMusicMenu)
main:connect(frameButtonMoreMenu)

main:connect(iconButtonStart)
main:connect(frameButtonPotsMenu)
main:connect(frameButtonMusicMenu)
main:connect(frameButtonMoreMenu)

main:connect(ntrButtonStart)
main:connect(ntrButtonPotsMenu)
main:connect(ntrButtonMusicMenu)
main:connect(ntrButtonMoreMenu)

main:connect(waterMeter)
main:connect(pot)

main.event:add('update', function (dt)
    if ntrButtonStart.isClicked then
        main.isLocked = true
    end

    if ntrButtonPotsMenu.isClicked then
        local group = sysintf:getGroup(2)
        group.isLocked = false
        group.isVisible = true
        main.isLocked = true
    end

    if ntrButtonMusicMenu.isClicked then
        local group = sysintf:getGroup(3)
        group.isLocked = false
        group.isVisible = true
        main.isLocked = true
    end

    if ntrButtonMoreMenu.isClicked then
        local group = sysintf:getGroup(4)
        group.isLocked = false
        group.isVisible = true
        main.isLocked = true
    end
end)

main.event:add('draw', function ()
    innerBackground:draw()

    pot:draw()

    love.graphics.setFont(assets.font.normal)
    color.condition(ntrButtonStart.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    frameButtonStart:draw()
    color.condition(ntrButtonStart.isCursorHovering, {60/255/2, 163/255/2, 112/255/2}, {60/255, 163/255, 112/255})
    iconButtonStart:draw()

    color.condition(ntrButtonPotsMenu.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    frameButtonPotsMenu:draw()
    iconButtonPotsMenu:draw()

    color.condition(ntrButtonMusicMenu.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    frameButtonMusicMenu:draw()
    iconButtonMusicMenu:draw()

    color.condition(ntrButtonMoreMenu.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    frameButtonMoreMenu:draw()
    iconButtonMoreMenu:draw()

    love.graphics.setFont(assets.font.small)

    love.graphics.setColor(1, 1, 1)

    waterMeter:draw()

    watermarkText:draw()

    love.graphics.setColor(1, 1, 1)
end)

return main