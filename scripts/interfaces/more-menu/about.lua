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
local drwTextScrollh = require 'scripts.interface.elements.drw-textscrollh'
local ntrRect = require 'scripts.interface.elements.ntr-rect'

local about = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.getImage('frameWindow1'), 26, 26, 92, 204)
local title = drwText.new('About us', 26, 26, 92, 8)

local description = 'We are Einstein\'s Squad (Research Project Group 1 A07-12 STEM-S2-3.) We created this interactive game for Digital Knowledge Fair and Science Expo 2023.\n\nMembers of the Group\nLuis Panambo\nEvo Pasculado\nJosiah Garillo\nLeon Llarinnas\nRalph Gomez\nJR Mabasa\n\n Thank you for playing our interactive!!\n\nAlso thank you participating on our booth and enjoying our game!!!!'

local info = drwTextScrollh.new(description, 26, 39, 95, 155, 10, 5, true)
info.lerp.halted = true

local backButton = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 53, 203, 38, 22),
    icon = drwImage.new(assets.getImage('iconBack'), 61, 203),
    ntr = ntrRect.new(53, 203, 38, 22)
}

about:connect(window)
about:connect(title)

about:connect(info)
about:connect(backButton)


about.event:add('update', function (dt)
    if backButton.ntr.isClicked then
        about:toggle()
    end

    info:update(dt)
end)

about.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1, 1)

    window:draw()

    color.RGB(60, 163, 112, true)
    title:draw()

    info:draw()

    color.conditionRGB(backButton.ntr.isHoldingClick, 0.5, 0.5, 0.5, 1, 1, 1, true)
    backButton.frame:draw()
    backButton.icon:draw()

    love.graphics.setColor(1, 1, 1, 1)
end)

return about