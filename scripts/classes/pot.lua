local enums = require 'scripts.enums'
local musics = require 'scripts.musics'
local plant = require 'scripts.classes.plant'

local pot = {}
pot.__index = pot

local index = 1

function pot.new()
    local newObject = {
        name  = index,
        plant = nil,
        music = nil,
        waterLevel = 1,
    }

    newObject.plant = plant.new(newObject)

    index = index + 1

    return setmetatable(newObject, pot)
end

function pot:initialize()
    local music = self.music

    -- Loop music when its duration is less than 7 mins
    if music.audio:getDuration('seconds') < (7*60) then
        music.audio:setLooping(true)
    end

    -- Play music upon initialized
    music.audio:play()
end

function pot:setMusic(music)
    if self.music == nil then
        self.music = {}
    end

    self.music.name   = music.name
    self.music.artist = music.artist
    self.music.audio  = music.audio
    self.music.path   = music.path
    self.music.data   = love.sound.newSoundData(music.data)

    for key, genre in pairs(musics) do
        for _, value in ipairs(genre) do
            -- Table reference matching
            if music == value then
                self.name = key
                return
            end
        end
    end

    -- If not found
    error('Specified music not found')
end

--[[
    Returns:

    pot name,
    plant health,
    water level
--]]
function pot:getInfo()
    return (self.name or 'No genre'), (self.plant:checkHealth()), (self.waterLevel * 100 .. '%')
end

return pot