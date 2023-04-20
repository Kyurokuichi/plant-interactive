local assets    = require('scripts.assets')
local sysintf   = require('scripts.sysintf')

local color     = require('scripts.interface.color')

local drwImage  = require('scripts.interface.elements.drw-image')
local drwFrame  = require('scripts.interface.elements.drw-frame')
local drwText   = require('scripts.interface.elements.drw-text')
local ntrRect   = require('scripts.interface.elements.ntr-rect')

local window    = drwFrame.new(assets.image.frameWindow, 26, 26, 92, 204)

local musicMenu = require('scripts.interface.group').new(false, true)

local backButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 31, 203, 22, 22),
    icon    = drwImage.new(assets.image.iconBack, 34, 205),
    ntr     = ntrRect.new(31, 203, 22, 22)
}

local previousPageButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 65, 203, 18, 22),
    icon    = drwImage.new(assets.image.iconLeftArrow, 65, 203),
    ntr     = ntrRect.new(65, 203, 18, 22)
}

local nextPageButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 95, 203, 18, 22),
    icon    = drwImage.new(assets.image.iconRightArrow, 95, 203),
    ntr     = ntrRect.new(95, 203, 18, 22)
}

musicMenu:connect(backButton.frame)
musicMenu:connect(backButton.icon)
musicMenu:connect(backButton.ntr)

musicMenu:connect(previousPageButton.frame)
musicMenu:connect(previousPageButton.icon)
musicMenu:connect(previousPageButton.ntr)

musicMenu:connect(nextPageButton.frame)
musicMenu:connect(nextPageButton.icon)
musicMenu:connect(nextPageButton.ntr)

musicMenu.event:add('update', function (dt)
    if backButton.ntr.isClicked then
        local group = sysintf:getGroup(1)
        group.isLocked = false

        musicMenu.isVisible = false
        musicMenu.isLocked  = true

        return
    end
end)

musicMenu.event:add('draw', function ()
    window:draw()
    
    color.condition(backButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    backButton.frame:draw()
    backButton.icon:draw()

    color.condition(previousPageButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    previousPageButton.frame:draw()
    previousPageButton.icon:draw()

    color.condition(nextPageButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    nextPageButton.frame:draw()
    nextPageButton.icon:draw()

    love.graphics.setColor(1, 1, 1)
end)

return musicMenu