local enums= require 'scripts.enums'

local plant = {}
plant.__index = plant

function plant.new(pot)
    local newObject = {
        pot = pot,
        height = 0,
        stem = {
            internodes = {},
            petioles = {}
        }
    }

    return setmetatable(newObject, plant)
end

function plant:update(dt)
    
end

function plant:newInternode()
    
end

function plant:newPetiole()
    
end

function plant:getHealth()
    local waterLevel = self.pot.waterLevel

    if waterLevel < (1-0.3) or waterLevel > (1+0.3) then
        return enums.key.health[enums.index.health.wilting]
    else
        return enums.key.health[enums.index.health.healthy]
    end
end

return plant