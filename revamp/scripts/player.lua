local enums = require 'scripts.enums'

local clock = require 'scripts.clock'

local pot = require 'scripts.classes.pot'

local player = {
    phase = nil,
    semiphase = nil,
    pots = nil,

    clock = clock,

    selected  = {
        potIndex = nil,
        musicIndex = nil,
        musicGenre = nil,
        previewIndex = nil,
        --previewGenre = nil,

        page = nil,
        genre = nil
    },

    settings = {
        masterVolume = nil,
        musicVolume = nil,
        SFXVolume = nil
    }
}

function player:initialize()
    self.phase = enums.index.phase.pre

    self.pots = {
        pot.new(),
        pot.new()
    }

    self.selected.potIndex = 1
    self.selected.page = 1
    self.selected.genre = 1
end

function player:getPot(index)
    return self.pots[index]
end

function player:addPot()
    self.pots[#self.pots+1] = pot.new()
end

function player:reset()
    
end

return player