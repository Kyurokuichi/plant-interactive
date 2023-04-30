-- Watering mechanics for plant simulator
local player = require 'scripts.player'

local watering = {
    enabled = false,
    stopped = false,
    canceled = false,
    speed = 0,
    time = 0,
    x = 0,  -- not real x coordinate but rather a point from water level meter (0 - 2)
    a = 0,
    b = 0,
    --areaX0 = 0,
    --areaX1 = 0,
}

function watering.trigger()
    watering.enabled = true

    if not watering.canceled then
        watering.speed = math.random(4, 16)
    end
end

function watering.cancel()
    watering.canceled = true
    watering.enabled = false
    watering.time = 0
end

function watering.stop()
    local pot = player.getSelectedPot()

    watering.enabled = false
    watering.stopped = true
    watering.time = 0
    watering.a = pot.waterLevel
    watering.b = watering.x
end

function watering.update(dt)
    local pot = player.getSelectedPot()

    if watering.enabled then
        watering.time = watering.time + dt

        local area = (2 - pot.waterLevel) / 2

        watering.x = pot.waterLevel + area + area * -math.cos(watering.time * watering.speed)
    elseif watering.stopped then
        watering.time = watering.time + dt

        if watering.time < 1 then
            pot.waterLevel = watering.a + (watering.b - watering.a) * watering.time
        else
            watering.enabled = false
            watering.stopped = false
            watering.canceled = false
            watering.x = 0
            watering.a = 0
            watering.b = 0
        end
    elseif watering.canceled then
        watering.x = pot.waterLevel
    end
end

function watering.draw(waterLevelIntf)
    if not watering.enabled then
        return
    end

    local pot = player.getPot(player.selected.potIndex)
    local area = (2 - pot.waterLevel) / 2
    local areaWidth = waterLevelIntf.meter.width * area
    local areaX = waterLevelIntf.indicator.x

    love.graphics.setColor(0.5, 0.5, 0.5, 0.5)

    love.graphics.rectangle(
        'fill',
        areaX,
        waterLevelIntf.meter.y,
        areaWidth,
        waterLevelIntf.meter.height
    )


    areaWidth = waterLevelIntf.meter.width - 8
    areaX = waterLevelIntf.meter.x + 4

    local indicatorX = areaX + areaWidth * (watering.x / 2) - waterLevelIntf.indicator.width/2

    love.graphics.setColor(1, 0, 0, 1)

    love.graphics.draw(
        waterLevelIntf.indicator.image,
        indicatorX,
        waterLevelIntf.indicator.y
    )

    love.graphics.setColor(1, 1, 1, 1)
end


return watering