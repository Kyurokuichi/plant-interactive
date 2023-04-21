local enums = require 'scripts.enums'
local pot  = require 'scripts.classes.pot'

local player = {
    phase = nil,
    pots = nil,
    selected = {
        potIndex = nil,
        page = nil,
        genre = nil,
        musicIndex = nil,
        previewIndex = nil
    },

    settings = {
        masterVolume = 1,
        musicVolume = 1,
        SFXVolume = 1
    }
}

function player:initialize()
    self.phase = enums.phase.peri
    self.pots = {
        pot.new(),
    }

    self.selected.potIndex = 1
    self.selected.page     = 1
    self.selected.genre    = 1
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