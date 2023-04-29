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
    },

    watering = {
        speed = 5,
        time = 0,
        x = 0,
        waterLevel = 0,
        activated = false,
    }
}

function player:initialize()
    self.phase = enums.index.phase.pre

    self.pots = {
        pot.new(),
    }

    self.selected.potIndex = 1
    self.selected.page = 1
    self.selected.genre = 1

    self.settings.masterVolume = 1
    self.settings.musicVolume = 1
    self.settings.SFXVolume = 1
end

function player:loadSimulation()
    -- Check pot if has assigned music

    for index, pot in ipairs(self.pots) do
        if not pot:hasMusic() then
            return false
        end
    end

    self.phase = enums.index.phase.peri

    for _, pot in ipairs(self.pots) do
        pot:initialize()
    end

    return true
end

function player:update(dt)
    if self.phase == enums.index.phase.peri then
        self:updateWaterMechanic(dt)

        self.clock:update(dt)

        if self.semiphase == enums.index.semiphase.countdown then
            if self.clock.time < 0 then
                self.clock:setup(60*7)
                self.semiphase = enums.index.semiphase.simulation

                for index, pot in ipairs(self.pots) do
                    pot:playMusic()

                    if self.selected.potIndex == index then
                        pot.music.audio:setVolume(self.settings.musicVolume)
                    else
                        pot.music.audio:setVolume(0)
                    end
                end
            end
        elseif self.semiphase == enums.index.semiphase.simulation then
            for _, pot in ipairs(self.pots) do
                pot:update(dt)
            end
        else
            self.semiphase = enums.index.semiphase.countdown
            self.clock:setup(3)
        end
    end
end

function player:enableWaterMechanic(bool)
    self.watering.activated = bool
end

function player:updateWaterMechanic(dt)
    if not self.watering.activated then return end

    local pot = self:getPot(self.selected.potIndex)

    local watering = self.watering

    watering.time = watering.time + dt

    local area = (2 - pot.waterLevel) / 2

    watering.x = pot.waterLevel + area + area * math.cos(watering.time * watering.speed)
end

function player:stopWaterMechanic()
    local watering = self.watering
    local pot = self:getPot(self.selected.potIndex)
    pot.waterLevel = watering.x
    watering.activated = false
end

function player:draw()
    local pot = self:getPot(self.selected.potIndex)
    pot:draw()
end

function player:getPot(index)
    return self.pots[index]
end

function player:addPot()
    self.pots[#self.pots+1] = pot.new()
end

function player:reset()
    
end

function player:getSelectedPot()
    return self.pots[self.selected.potIndex]
end

return player