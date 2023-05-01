-- General
local assets  = require 'scripts.assets'
local screen = require 'scripts.screen'
local sysntf = require 'scripts.sysntf'
local player = require 'scripts.player'
local enums = require 'scripts.enums'
local color = require 'scripts.color'
local sfx = require 'scripts.sfx'
local hint = require 'scripts.hint'
local watering = require 'scripts.watering'

-- Interface classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText = require 'scripts.interface.elements.drw-text'
local ntrRect = require 'scripts.interface.elements.ntr-rect'

local main = require('scripts.interface.group').new(true, false)

local background = {
    city = drwImage.new(assets.getImage('backgroundCity'), 0, 0),
    town = drwImage.new(assets.getImage('backgroundTown'), 0, 0),
    powerLines = drwImage.new(assets.getImage('backgroundPowerLines'), 0, 0),
    leavesInner = drwImage.new(assets.getImage('backgroundLeavesInner'), 0 ,0),
    leavesInner2 = drwImage.new(assets.getImage('backgroundLeavesInner2'), 0, 0),
    leavesOuter = drwImage.new(assets.getImage('backgroundLeavesOuter'), 0, 0)
}

local room = drwImage.new(assets.getImage('backgroundRoom'), 0, 0)
local pot = drwImage.new(assets.getImage('pot'), 40, 108)
local leftSpeaker = drwImage.new(assets.getImage('leftSpeaker'), 0, 63)
local rightSpeaker = drwImage.new(assets.getImage('rightSpeaker'), 101, 63)
local clock = {
    image = drwImage.new(assets.image.clock, 48, 0),
    time  = drwText.new('T- 00:00', 53, 10, 38, 8)
}

local waterLevel = {
    meter = drwImage.new(assets.image.waterLevel, 32, 189),
    indicator = drwImage.new(assets.image.meterIndicator, 78, 187),
    icon  = drwImage.new(assets.image.iconWaterMeter, 18, 187)
}

-- Buttons
local startButton = {
    frame = drwFrame.new(assets.getImage('frameButton2'), 45, 158, 54, 22),
    title = drwText.new('Start', 45, 158, 54, 22),
    ntr = ntrRect.new(45, 158, 54, 22)
}
local potsMenuButton = {
    frame = drwFrame.new(assets.getImage('frameButton1'), 23, 216, 22, 22),
    icon = drwImage.new(assets.getImage('iconMenuPots'), 23, 216),
    ntr = ntrRect.new(23, 216, 22, 22)
}
local musicMenuButton = {
    frame = drwFrame.new(assets.getImage('frameButton1'), 61, 216, 22, 22),
    icon = drwImage.new(assets.getImage('iconMenuMusics'), 61, 216),
    ntr = ntrRect.new(61, 216, 22, 22)
}
local moreMenuButton = {
    frame = drwFrame.new(assets.getImage('frameButton1'), 99, 216, 22, 22),
    icon  = drwImage.new(assets.getImage('iconMenuMore'), 99, 216),
    ntr   = ntrRect.new(99, 216, 22, 22)
}

-- Peri phase buttons
local waterButton = {
    frame = drwFrame.new(assets.getImage('frameButton6'), 61, 216, 22, 22),
    icon  = drwImage.new(assets.getImage('iconWatering'), 61, 216),
    ntr   = ntrRect.new(61, 216, 22, 22)
}
local wateringButton = {
    frame = drwFrame.new(assets.getImage('frameButton6'), 37, 216, 22, 22),
    icon  = drwImage.new(assets.getImage('iconWatering'), 37, 216),
    ntr   = ntrRect.new(37, 216, 22, 22)
}
local cancelWaterButton = {
    frame = drwFrame.new(assets.getImage('frameButton1'), 85, 216, 22, 22),
    icon  = drwImage.new(assets.getImage('iconClose'), 85, 216),
    ntr   = ntrRect.new(85, 216, 22, 22)
}

local alertIcon = drwImage.new(assets.getImage('iconWarn'), 43, 208)

main:connect(background)
main:connect(room)
main:connect(pot)
main:connect(leftSpeaker)
main:connect(rightSpeaker)
main:connect(clock)

main:connect(waterLevel)

main:connect(startButton)
main:connect(potsMenuButton)
main:connect(moreMenuButton)
main:connect(musicMenuButton)

main:connect(waterButton)
main:connect(wateringButton)
main:connect(cancelWaterButton)

main:connect(alertIcon)

local currentPhase = nil

local function rectifyFromPhase()
    if currentPhase ~= player.phase then
        if player.phase == enums.index.phase.pre then
            startButton.frame.isVisible = true
            startButton.title.isVisible = true
            startButton.ntr.isLocked = false

            musicMenuButton.frame.isVisible = true
            musicMenuButton.icon.isVisible = true
            musicMenuButton.ntr.isLocked = false

            waterButton.frame.isVisible = false
            waterButton.icon.isVisible = false
            waterButton.ntr.isLocked = true

            wateringButton.frame.isVisible = false
            wateringButton.icon.isVisible = false
            wateringButton.ntr.isLocked = true

            --wateringLevel.meter.isVisible = false
            --wateringLevel.indicator.isVisible = false

            cancelWaterButton.frame.isVisible = false
            cancelWaterButton.icon.isVisible = false
            cancelWaterButton.ntr.isLocked = true

            alertIcon.isVisible = false

            require 'scripts.special'
        elseif player.phase == enums.index.phase.peri then
            startButton.frame.isVisible = false
            startButton.title.isVisible = false
            startButton.ntr.isLocked = true

            musicMenuButton.frame.isVisible = false
            musicMenuButton.icon.isVisible = false
            musicMenuButton.ntr.isLocked = true

            waterButton.frame.isVisible = true
            waterButton.icon.isVisible = true
            waterButton.ntr.isLocked = false
        end

        currentPhase = player.phase
    end
end

local function updateLeavesMovement()
    local leavesInner2 = background.leavesInner2
    local leavesInner = background.leavesInner
    local leavesOuter = background.leavesOuter

    local sin = math.sin(love.timer.getTime() * 2)
    local cos = math.cos(love.timer.getTime() * 2)

    leavesInner2.x = sin
    leavesInner2.y = sin

    leavesInner.x = -cos
    leavesInner.y = -cos

    leavesOuter.x = -cos
    leavesOuter.y = -sin
end

local function updateClock()
    clock.time.text = player.clock:tellTime()
end

local function updateWaterLevel()
    local pot = player.getPot(player.selected.potIndex)
    local percent = pot.waterLevel / 2

    local areaWidth = waterLevel.meter.width - 8
    local areaX = waterLevel.meter.x + 4

    local x = areaX + areaWidth * percent
    waterLevel.indicator.x = x - waterLevel.indicator.width / 2
end

local function musicMenuLoad()
    local selectedPot = player.getSelectedPot()

    if selectedPot.music then
        player.selected.musicIndex = selectedPot.music.musicIndex
        player.selected.musicGenre = selectedPot.music.genreIndex
    end
end

local function enabledWaterMode(bool)
    potsMenuButton.frame.isVisible = not bool
    potsMenuButton.icon.isVisible = not bool
    potsMenuButton.ntr.isLocked = bool

    moreMenuButton.frame.isVisible = not bool
    moreMenuButton.icon.isVisible = not bool
    moreMenuButton.ntr.isLocked = bool

    waterButton.frame.isVisible = not bool
    waterButton.icon.isVisible = not bool
    waterButton.ntr.isLocked = bool

    wateringButton.frame.isVisible = bool
    wateringButton.icon.isVisible = bool
    wateringButton.ntr.isLocked = not bool

    cancelWaterButton.frame.isVisible = bool
    cancelWaterButton.icon.isVisible = bool
    cancelWaterButton.ntr.isLocked = not bool

    if bool then
        watering.trigger()
    else
        watering.cancel()
    end
end

main.event:add('update', function (dt)
    rectifyFromPhase()
    updateLeavesMovement()
    updateClock()
    updateWaterLevel()

    if player.phase == enums.index.phase.peri then
        watering.update(dt)

        if player.subPhase == enums.index.subPhase.simulation then
            if waterButton.ntr.isClicked then
                enabledWaterMode(true)
                sfx.play('click')
            elseif wateringButton.ntr.isClicked then
                enabledWaterMode(false)
                watering.stop()
                sfx.play('waterProduction')
            elseif cancelWaterButton.ntr.isClicked then
                enabledWaterMode(false)
                sfx.play('click')
            end

            if potsMenuButton.ntr.isClicked and not watering.stopped then
                main:toggleLockOnly()
                sysntf:getGroup(2):toggle()
                sfx.play('click')
            end

            if player.alert and potsMenuButton.frame.isVisible then
                alertIcon.isVisible = true
            else
                alertIcon.isVisible = false
            end
        end

    elseif player.phase == enums.index.phase.pre then
        if potsMenuButton.ntr.isClicked then
            main:toggleLockOnly()
            sysntf:getGroup(2):toggle()
            sfx.play('click')
        end
    end

    if musicMenuButton.ntr.isClicked then
        musicMenuLoad()
        main:toggleLockOnly()
        sysntf:getGroup(3):toggle()
        sfx.play('click')
    end

    if moreMenuButton.ntr.isClicked then
        main:toggleLockOnly()
        sysntf:getGroup(4):toggle()
        sfx.play('click')
    end

    if startButton.ntr.isClicked then
        main:toggleLockOnly()
        sysntf:getGroup(5):toggle()
        sfx.play('click')
    end
end)

main.event:add('draw', function ()
    color.RGB(143, 248, 226, true)

    love.graphics.rectangle('fill', 0, 0, screen.width, screen.height)

    love.graphics.setColor(1, 1, 1, 1)

    background.city:draw()
    background.town:draw()
    background.powerLines:draw()
    background.leavesOuter:draw()
    background.leavesInner:draw()
    background.leavesInner2:draw()

    room:draw()
    pot:draw()
    leftSpeaker:draw()
    rightSpeaker:draw()

    player.draw()

    waterLevel.meter:draw()
    waterLevel.icon:draw()
    waterLevel.indicator:draw()

    if player.phase == enums.index.phase.peri then
        watering.draw(waterLevel)
    end

    clock.image:draw()

    color.RGB(255, 107, 151, true)
    clock.time:draw()

    color.conditionRGB(startButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    startButton.frame:draw()

    color.RGB(60, 163, 112, true)
    love.graphics.setFont(assets.getFont('normal'))
    startButton.title:draw()

    love.graphics.setFont(assets.getFont('small'))

    color.conditionRGB(potsMenuButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    potsMenuButton.frame:draw()
    potsMenuButton.icon:draw()

    color.conditionRGB(musicMenuButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    musicMenuButton.frame:draw()
    musicMenuButton.icon:draw()

    color.conditionRGB(moreMenuButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    moreMenuButton.frame:draw()
    moreMenuButton.icon:draw()

    color.conditionRGB(waterButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    waterButton.frame:draw()
    waterButton.icon:draw()

    color.conditionRGB(wateringButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    wateringButton.frame:draw()
    wateringButton.icon:draw()

    color.conditionRGB(cancelWaterButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    cancelWaterButton.frame:draw()
    cancelWaterButton.icon:draw()

    if player.phase == enums.index.phase.peri then
        alertIcon:draw()
    end

    love.graphics.setColor(1, 1, 1, 1)
end)

return main