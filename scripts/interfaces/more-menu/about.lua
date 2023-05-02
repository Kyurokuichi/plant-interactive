-- General
local assets  = require 'scripts.assets'
local screen = require 'scripts.screen'
local sysntf = require 'scripts.sysntf'
local player = require 'scripts.player'
local enums = require 'scripts.enums'
local musics = require 'scripts.musics'
local color = require 'scripts.color'
local sfx = require 'scripts.sfx'
local overlay = require 'scripts.overlay'

-- Interface classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect = require 'scripts.interface.elements.ntr-rect'

local about = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.getImage('frameWindow1'), 26, 26, 92, 204)
local title = drwText.new('More', 26, 26, 92, 8)

about:connect(window)
about:connect(title)

about.event:add('update', function (dt)
    
end)

about.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1, 1)

    window:draw()
    title:draw()
end)

return about