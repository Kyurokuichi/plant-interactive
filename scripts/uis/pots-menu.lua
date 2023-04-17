local assets    = require('scripts.assets')
local sysintf   = require('scripts.sysintf')

local color     = require('scripts.interface.color')

local drwImage  = require('scripts.interface.elements.drw-image')
local drwFrame  = require('scripts.interface.elements.drw-frame')
local drwText   = require('scripts.interface.elements.drw-text')
local ntrRect   = require('scripts.interface.elements.ntr-rect')


local potsMenu = require('scripts.interface.group').new(false, true)

local window    = drwFrame.new(assets.image.frameWindow, 26, 26, 92, 204)
potsMenu:connect(window)

local title     = drwText.new('Pots selection', 26, 26, 92, 8)
potsMenu:connect(title)

local backButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 35, 203, 38, 22),
    icon    = drwImage.new(assets.image.iconBack, 46, 205),
    ntr     = ntrRect.new(35, 203, 38, 22)
}
potsMenu:connect(backButton.frame)
potsMenu:connect(backButton.icon)
potsMenu:connect(backButton.ntr)

local removeButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 87, 203, 22, 22),
    icon    = drwImage.new(assets.image.iconRemove, 87, 203),
    ntr     = ntrRect.new(87, 203, 22, 22)
}
potsMenu:connect(removeButton.frame)
potsMenu:connect(removeButton.icon)
potsMenu:connect(removeButton.ntr)

potsMenu.event:add('update', function (dt)
    if backButton.ntr.isClicked then
        sysintf:getGroup(1).isLocked = false

        potsMenu.isLocked = true
        potsMenu.isVisible = false
    end
end)

potsMenu.event:add('draw', function ()
    window:draw()

    love.graphics.setFont(assets.font.small)
    love.graphics.setColor(color.rgb(60, 163, 112))
    title:draw()

    color.condition(backButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    backButton.frame:draw()
    backButton.icon:draw()

    color.condition(removeButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    removeButton.frame:draw()
    removeButton.icon:draw()

    love.graphics.setColor(1, 1, 1)
end)

return potsMenu