local assets = require 'scripts.assets'
local enums  = require 'scripts.enums'
local player = require 'scripts.player'

local overlay = {
    overlay = nil,

    dry = {
        image = assets.image.overlayDry,
        x = -6,
        y = 12
    },
    healthy = {
        image = assets.image.overlayHealthy,
        x = -2,
        y = -2
    },
    swamped = {
        image = assets.image.overlaySwamped,
        x = 6,
        y = 17
    }
}

function overlay:draw()
    local pot = player:getSelectedPot()
    local waterLevel = pot.waterLevel

    local areaOfHealthy = 0.3

    local image, x, y

    if waterLevel > (1+areaOfHealthy) then
        image = self.swamped.image
        x = self.swamped.x
        y = self.swamped.y
    elseif waterLevel < (1-areaOfHealthy) then
        image = self.dry.image
        x = self.dry.x
        y = self.dry.y
    else
        image = self.healthy.image
        x = self.healthy.x
        y = self.healthy.y
    end

    love.graphics.draw(
        image,
        x,
        y
    )
end

return overlay