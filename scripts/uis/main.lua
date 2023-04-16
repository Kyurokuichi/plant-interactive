local assets    = require('scripts.assets')
local sysintf   = require('scripts.sysintf')

local drwImage  = require('scripts.interface.elements.drw-image')
local drwFrame  = require('scripts.interface.elements.drw-frame')
local drwText   = require('scripts.interface.elements.drw-text')

local main = require('scripts.interface.group').new()

local watermarkText = drwText.new('Made by A07-12 STEM-S2-3 Grp 1', 0, 246, 144, 8)

local innerBackground = drwImage.new(assets.image.room)

local frameButtonStart      = drwFrame.new(assets.image.frameStart , 45, 158, 54, 22)
local frameButtonPotsMenu   = drwFrame.new(assets.image.frameButton, 23, 216, 22, 22)
local frameButtonMusicMenu  = drwFrame.new(assets.image.frameButton, 61, 216, 22, 22)
local frameButtonMoreMenu   = drwFrame.new(assets.image.frameButton, 99, 216, 22, 22)

local iconButtonStart       = nil
local iconButtonPotsMenu    = drwImage.new(assets.image.iconPotsMenu , 23, 216)
local iconButtonMusicMenu   = drwImage.new(assets.image.iconMusicMenu, 61, 216)
local iconButtonMoreMenu    = drwImage.new(assets.image.iconMoreMenu , 99, 216)

main:connect(innerBackground)

main:connect(frameButtonStart)
main:connect(frameButtonPotsMenu)
main:connect(frameButtonMusicMenu)
main:connect(frameButtonMoreMenu)

--main:connect(iconButtonStart)
main:connect(frameButtonPotsMenu)
main:connect(frameButtonMusicMenu)
main:connect(frameButtonMoreMenu)

main.event:add('update', function (dt)

end)

main.event:add('draw', function ()
    innerBackground:draw()

    frameButtonStart:draw()

    frameButtonPotsMenu:draw()
    iconButtonPotsMenu:draw()

    frameButtonMusicMenu:draw()
    iconButtonMusicMenu:draw()

    frameButtonMoreMenu:draw()
    iconButtonMoreMenu:draw()

    watermarkText:draw()
end)

return main