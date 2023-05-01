-- General
local assets  = require 'scripts.assets'
local screen = require 'scripts.screen'
local sysntf = require 'scripts.sysntf'
local player = require 'scripts.player'
local enums = require 'scripts.enums'
local color = require 'scripts.color'
local sfx = require 'scripts.sfx'

-- Interface classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect = require 'scripts.interface.elements.ntr-rect'

local startMenu = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.getImage('frameWindow1'), 26, 82, 92, 92)
local title = drwText.new('Start Simulation?', 26, 82, 92, 8)

local description = drwText.new('Are you sure you want to start simulation?', 26, 94, 92, 42)
local confirmButton = {
    frame = drwFrame.new(assets.image.frameButton3, 82, 147, 22, 22),
    icon  = drwImage.new(assets.image.iconCheck, 82, 147),
    ntr   = ntrRect.new(82, 147, 22, 22)
}
local cancelButton = {
    frame = drwFrame.new(assets.image.frameButton3, 39, 147, 22, 22),
    icon  = drwImage.new(assets.image.iconBack, 39, 147),
    ntr   = ntrRect.new(39, 147, 22, 22)
}

startMenu:connect(window)
startMenu:connect(title)

startMenu:connect(confirmButton)
startMenu:connect(cancelButton)
startMenu:connect(description)

local function returnMain()
    sysntf:getGroup(1):toggleLockOnly()
    startMenu:toggle()
end

startMenu.event:add('update', function (dt)
    if cancelButton.ntr.isClicked then
        returnMain()
        sfx.play('click')
    end

    if confirmButton.ntr.isClicked then
        local status = player.loadSimulation()

        if not status then
            print('cannot start the game')
            sfx.play('warning')
        else
            returnMain()
            sfx.play('confirm')
        end
    end
end)

startMenu.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(assets.getFont('small'))

    window:draw()
    description:draw()

    color.RGB(60, 163, 112, true)
    title:draw()

    color.conditionRGB(confirmButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    confirmButton.frame:draw()
    confirmButton.icon:draw()

    color.conditionRGB(cancelButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    cancelButton.frame:draw()
    cancelButton.icon:draw()

    love.graphics.setColor(1, 1, 1, 1)
end)

return startMenu