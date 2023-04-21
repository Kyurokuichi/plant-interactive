local enums = require 'scripts.enums'

local plant = {}
plant.__index = plant

function plant.new(pot)
    local newObject = {
        pot = pot,
        height = 0,
        stem = {
            internodes = {},
            petioles = {}
        },
    }

    return setmetatable(newObject, plant)
end

function plant:update(dt)
    
end

function plant:newInternode()
    
end

function plant:newPetiole()
    
end

function plant:checkHealth()
    local waterLevel = self.pot.waterLevel

    if waterLevel < (0.7) or waterLevel > (1.3) then
        return enums.health[2]
    else
        return enums.health[1]
    end
end

return plant