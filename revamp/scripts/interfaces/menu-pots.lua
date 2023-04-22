-- Modules
local assets = require 'scripts.assets'
local color = require 'scripts.interface.color'

local player = require 'scripts.player'

-- Classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText  = require 'scripts.interface.elements.drw-text'
local ntrRect  = require 'scripts.interface.elements.ntr-rect'

local menuPots = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.image.frameWindow1, 26, 26, 92, 204)
menuPots:connect(window)
local overlay = drwImage.new()

local backButton = {
    frame = drwFrame.new(assets.image.frameButton3, 35, 203, 38, 22),
    icon  = drwImage.new(assets.image.iconBack, 43, 203)
}
menuPots:connect(backButton)

menuPots.event:add('update', function (dt)
    
end)

menuPots.event:add('draw', function ()
    window:draw()

    backButton.frame:draw()
    backButton.icon:draw()
end)

return menuPots