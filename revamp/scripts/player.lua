local enums = require 'scripts.enums'

local pot = require 'scripts.classes.pot'

local player = {
    phase = nil,
    pots = nil,

    selected  = {
        potIndex = nil,
        musicIndex = nil,
        musicGenre = nil,
        previewIndex = nil,
        previewGenre = nil,

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
        pot.new()
    }
end

function player:reset()
    
end

return player