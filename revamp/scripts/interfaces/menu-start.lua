-- Modules
local assets = require 'scripts.assets'
local color = require 'scripts.interface.color'

local sysntf = require 'scripts.sysntf'
local enums  = require 'scripts.enums'
local player = require 'scripts.player'

-- Classes
local drwImage      = require 'scripts.interface.elements.drw-image'
local drwFrame      = require 'scripts.interface.elements.drw-frame'
local drwText       = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect       = require 'scripts.interface.elements.ntr-rect'

local menuStart = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.image.frameWindow1, 26, 82, 92, 92)
local title = drwText.new('Start Confirmation', 26, 82, 92, 8)
menuStart:connect(window)
menuStart:connect(title)

-- Buttons
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
menuStart:connect(description)
menuStart:connect(confirmButton)
menuStart:connect(cancelButton)

local function returnMain()
    sysntf:getGroup(1):toggleLockOnly()
    menuStart:toggle()
end

menuStart.event:add('update', function (dt)
    if cancelButton.ntr.isClicked then
        returnMain()
    end

    if confirmButton.ntr.isClicked then
        player.phase = enums.index.phase.peri
        returnMain()
    end
end)

menuStart.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1)
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

    love.graphics.setColor(1, 1, 1)
end)

return menuStart