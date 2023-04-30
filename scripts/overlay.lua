local assets = require 'scripts.assets'
local enums = require 'scripts.enums'

local overlay = {
    current = nil,

    dry = {
        image = assets.getImage('overlayDry'),
        x = -6,
        y = 12,
    },

    healthy = {
        image = assets.getImage('overlayHealthy'),
        x = -2,
        y = -2
    },

    swamped = {
        image = assets.getImage('overlaySwamped'),
        x = 6,
        y = 17,
    }
}

function overlay.update(pot)
    local waterLevel = pot.waterLevel
    local health

    if waterLevel < (1-0.3) then
        health = enums.index.overlay.dry
    elseif waterLevel > (1+0.3) then
        health = enums.index.overlay.swamped
    else
        health = enums.index.overlay.healthy
    end

    health = enums.key.overlay[health]

    if overlay.current ~= health then
        overlay.current = health
    end
end

function overlay.draw()
    local current = overlay[overlay.current]

    love.graphics.draw(
        current.image,
        current.x,
        current.y
    )
end

return overlay