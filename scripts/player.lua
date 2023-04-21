local enums = require 'scripts.enums'
local pot  = require 'scripts.classes.pot'

local player = {
    phase = nil,
    pots = nil,
    selected = {
        potIndex = nil,
    },

    potsHistory = nil
}

function player:initialize()
    self.phase = enums.phase.peri
    self.pots = {
        pot.new(),
    }

    self.selected.potIndex = 1
    self.potsHistory = {}
end

function player:initializeSimulation()
    for _, pot in ipairs(self.pots) do
        pot:initialize()
    end
end

function player:addPot()
    self.pots[#self.pots+1] = pot.new()
end

function player:getPot(index)
    return self.pots[index]
end

function player:update(dt)

end

return player