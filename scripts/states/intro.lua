local screen = require 'scripts.screen'
local state = require 'scripts.state'
local assets = require 'scripts.assets'

local intro = {}

local
    trailsA,
    trailsB,

    timer,

    logoRotation,
    logoScale,

    wobbleRate,
    wobbleTime,
    wobbleScale,
    wobbleSpeed

local function lerp(a, b, t)
    t = math.min(t, 1)
    t = math.max(t, 0)

    return a + (b - a) * t
end

local function cerp(a, b, t)
    t = math.min(t, 1)
    t = math.max(t, 0)
    t = (1 - math.cos(t * math.pi)) / 2

    return a + (b - a) * t
end

function intro.load()
    timer = 0
    wobbleRate = 0
    wobbleTime = 0
    wobbleSpeed = 0

    trailsA = {}
    trailsB = {}

    assets.loadLeast()
end

function intro.update(dt)
    if love.timer.getTime() > 1 then
        dt = dt / 2

        timer = timer + dt

        wobbleTime = wobbleTime + dt * wobbleSpeed
        wobbleSpeed = lerp(32, 0, timer/2)
        wobbleRate = lerp(1, 0, timer/2)

        logoRotation = cerp(32, 0, timer/2)
        logoScale = cerp(0, 1, timer/2)

        local toBeDeletedTrailsA = {}

        -- Update trails

        for index, trail in ipairs(trailsA) do
            if trail.alpha > 0 then
                trail.alpha = trail.alpha - dt * 4
            else
                toBeDeletedTrailsA[#toBeDeletedTrailsA+1] = index
            end
        end

        -- Remove redundant trails
        if #toBeDeletedTrailsA > 0 then
            for index = #toBeDeletedTrailsA, 1, -1 do
                table.remove(trailsA, toBeDeletedTrailsA[index])
            end
        end

        if timer > 5 then
            state.switchTo('game')
        end
    end
end

function intro.draw()
    local logoImage = assets.getImage('einsteinSquad')

    local cos = math.cos(wobbleTime)
    local sin = math.sin(wobbleTime)
    local distance = 64 * wobbleRate

    local logoX = screen.width/2 + distance * cos
    local logoY = screen.height/2 + distance * sin
    local logoScale = logoScale
    local logoRotation = -logoRotation
    local logoOX = logoImage:getWidth()/2
    local logoOY = logoImage:getHeight()/2

    if timer < 2 then
        trailsA[#trailsA+1] = {
            x = logoX,
            y = logoY,
            rotation = logoRotation,
            scale = logoScale,

            red = math.random(0, 255) / 255,
            blue = math.random(0, 255) / 255,
            green = math.random(0, 255) / 255,
            alpha = 1
        }
    end

    for _, trail in ipairs(trailsA) do
        love.graphics.setColor(1, 1, 1, trail.alpha)

        love.graphics.draw(
            logoImage,
            trail.x,
            trail.y,
            trail.rotation,
            trail.scale,
            trail.scale,
            logoOX,
            logoOY
        )
    end

    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.draw(
        logoImage,
        logoX,
        logoY,
        logoRotation,
        logoScale,
        logoScale,
        logoOX,
        logoOY
    )
end

return intro