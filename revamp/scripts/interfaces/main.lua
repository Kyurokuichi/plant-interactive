-- Modules
local assets = require 'scripts.assets'
local color = require 'scripts.interface.color'

local sysntf = require 'scripts.sysntf'
local player = require 'scripts.player'
local enums  = require 'scripts.enums'

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
    meter = drwImage.new(assets.image.waterLevel, 32, 189),
    icon  = drwImage.new(assets.image.iconWaterMeter, 18, 187)
}
local clock = {
    image = drwImage.new(assets.image.clock, 48, 0),
    time  = drwText.new('T- 00:00', 53, 10, 38, 8)
}
main:connect(waterLevel)
main:connect(clock)

-- Watermark
local watermark = drwText.new('Made by A07-12 STEM-S2-3 Grp 1', 0, 246, 144, 8)
main:connect(watermark)

-- Buttons
local startButton = {
    frame = drwFrame.new(assets.image.frameButton2, 45, 158, 54, 22),
    title = drwText.new('Start', 45, 158, 54, 22),
    ntr   = ntrRect.new(45, 158, 54, 22)
}
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
local waterButton = {
    frame = drwFrame.new(assets.image.frameButton6, 61, 216, 22, 22),
    icon  = drwImage.new(assets.image.iconWatering, 61, 216),
    ntr   = ntrRect.new(61, 216, 22, 22)
}
main:connect(startButton)
main:connect(menuPotsButton)
main:connect(menuMusicsButton)
main:connect(menuMoreButton)
main:connect(waterButton)

local currentPhase = nil

local function phaseSet()
    print(player.phase)

    if currentPhase ~= player.phase then
        if player.phase == enums.index.phase.pre then
            startButton.frame.isVisible = true
            startButton.title.isVisible = true
            startButton.ntr.isLocked = false

            menuMusicsButton.frame.isVisible = true
            menuMusicsButton.icon.isVisible = true
            menuMusicsButton.ntr.isLocked = false

            waterButton.frame.isVisible = false
            waterButton.icon.isVisible = false
            waterButton.ntr.isLocked = true
        elseif player.phase == enums.index.phase.peri then
            startButton.frame.isVisible = false
            startButton.title.isVisible = false
            startButton.ntr.isLocked = true

            menuMusicsButton.frame.isVisible = false
            menuMusicsButton.icon.isVisible = false
            menuMusicsButton.ntr.isLocked = true

            waterButton.frame.isVisible = true
            waterButton.icon.isVisible = true
            waterButton.ntr.isLocked = false
        end

        currentPhase = player.phase
    end
end

local function menuMusicsLoad()
    local selectedPot = player:getPot(player.selected.potIndex)

    if selectedPot.music then
        player.selected.musicIndex = selectedPot.music.musicIndex
        player.selected.musicGenre = selectedPot.music.genreIndex

        print(player.selected.musicIndex, player.selected.musicGenre)
    end
end

main.event:add('update', function (dt)
    phaseSet()
    --print(#main.contents)

    if menuPotsButton.ntr.isClicked then
        main:toggleLockOnly()
        sysntf:getGroup(2):toggle()
    end

    if menuMusicsButton.ntr.isClicked then
        main:toggleLockOnly()
        sysntf:getGroup(3):toggle()
        menuMusicsLoad()
    end

    if menuMoreButton.ntr.isClicked then
        main:toggleLockOnly()
        sysntf:getGroup(4):toggle()
    end

    if startButton.ntr.isClicked then
        main:toggleLockOnly()
        sysntf:getGroup(5):toggle()
    end
end)

main.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1)

    room:draw()
    pot:draw()
    leftSpeaker:draw()
    rightSpeaker:draw()

    waterLevel.meter:draw()
    waterLevel.icon:draw()

    clock.image:draw()

    color.RGB(255, 107, 151, true)
    clock.time:draw()

    color.conditionRGB(startButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    startButton.frame:draw()

    color.RGB(60, 163, 112, true)
    love.graphics.setFont(assets.font.normal)
    startButton.title:draw()

    love.graphics.setFont(assets.font.small)


    color.conditionRGB(menuPotsButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    menuPotsButton.frame:draw()
    menuPotsButton.icon:draw()

    color.conditionRGB(menuMusicsButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    menuMusicsButton.frame:draw()
    menuMusicsButton.icon:draw()

    color.conditionRGB(menuMoreButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    menuMoreButton.frame:draw()
    menuMoreButton.icon:draw()

    color.conditionRGB(waterButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    waterButton.frame:draw()
    waterButton.icon:draw()

    love.graphics.setColor(1, 1, 1)

    watermark:draw()
end)

return main