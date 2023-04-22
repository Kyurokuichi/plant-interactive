-- Modules
local assets = require 'scripts.assets'
local color = require 'scripts.interface.color'

local sysntf = require 'scripts.sysntf'

-- Classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText  = require 'scripts.interface.elements.drw-text'
local ntrRect  = require 'scripts.interface.elements.ntr-rect'

local main = require('scripts.interface.group').new(true, false)

-- Room background

local room          = drwImage.new(assets.image.backgroundRoom, 0, 0)
local pot           = drwImage.new(assets.image.pot, 40, 108)
local leftSpeaker   = drwImage.new(assets.image.leftSpeaker, 0, 63)
local rightSpeaker  = drwImage.new(assets.image.rightSpeaker, 101, 63)
main:connect(room)
main:connect(pot)
main:connect(leftSpeaker)
main:connect(rightSpeaker)

-- Functionals
local waterLevel = {
    meter = drwImage.new(assets.image.waterLevel, 32, 189)
}
main:connect(waterLevel)

-- Buttons

local menuPotsButton = {
    frame = drwFrame.new(assets.image.frameButton1, 23, 216, 22, 22),
    icon  = drwImage.new(assets.image.iconMenuPots, 23, 216),
    ntr   = ntrRect.new(23, 216, 22, 22)
}
local menuMusicsButton = {
    frame = drwFrame.new(assets.image.frameButton1, 61, 216, 22, 22),
    icon  = drwImage.new(assets.image.iconMenuMusics, 61, 216),
    ntr   = ntrRect.new(61, 216, 22, 22)
}
local menuMoreButton = {
    frame = drwFrame.new(assets.image.frameButton1, 99, 216, 22, 22),
    icon  = drwImage.new(assets.image.iconMenuMore, 99, 216),
    ntr   = ntrRect.new(99, 216, 22, 22)
}
main:connect(menuPotsButton)
main:connect(menuMusicsButton)
main:connect(menuMoreButton)

main.event:add('update', function (dt)
    print(#main.contents)

    if menuPotsButton.ntr.isClicked then
        main:toggleLockOnly()
        sysntf:getGroup(2):toggle()
    end

    if menuMusicsButton.ntr.isClicked then
        
    end

    if menuPotsButton.ntr.isClicked then
        
    end
end)

main.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1)

    room:draw()
    pot:draw()
    leftSpeaker:draw()
    rightSpeaker:draw()

    waterLevel.meter:draw()

    color.conditionRGB(menuPotsButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    menuPotsButton.frame:draw()
    menuPotsButton.icon:draw()

    color.conditionRGB(menuMusicsButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    menuMusicsButton.frame:draw()
    menuMusicsButton.icon:draw()

    color.conditionRGB(menuMoreButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    menuMoreButton.frame:draw()
    menuMoreButton.icon:draw()

    love.graphics.setColor(1, 1, 1)
end)

return main