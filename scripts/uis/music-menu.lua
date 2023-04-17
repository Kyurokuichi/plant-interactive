local assets    = require('scripts.assets')
local sysintf   = require('scripts.sysintf')

local color     = require('scripts.interface.color')

local drwImage  = require('scripts.interface.elements.drw-image')
local drwFrame  = require('scripts.interface.elements.drw-frame')
local drwText   = require('scripts.interface.elements.drw-text')
local ntrRect   = require('scripts.interface.elements.ntr-rect')

local window    = drwFrame.new(assets.image.frameWindow, 26, 26, 92, 204)

local musicMenu = require('scripts.interface.group').new(false, true)

local backButton = drwImage.new(assets.image.iconBack)

musicMenu:connect(window)

musicMenu.event:add('update', function (dt)
    
end)

musicMenu.event:add('draw', function ()
    window:draw()
end)

return musicMenu