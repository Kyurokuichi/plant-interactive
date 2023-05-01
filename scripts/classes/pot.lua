local enums = require 'scripts.enums'
local musics = require 'scripts.musics'

local plant = require 'scripts.classes.plant'

local pot = {}
pot.__index = pot

function pot.new(name)
    local newObject = {
        name = name,
        plant = nil,
        music = nil,
        waterLevel = 0,
        needAttention = false
    }

    setmetatable(newObject, pot)
    newObject.plant = plant.new(newObject)

    return newObject
end

function pot:update(dt)
    self.plant:update(dt)

    local health = self.plant:getHealth()

    if health == enums.key.health[enums.index.health.healthy] then
        self.needAttention = false
    else
        self.needAttention = true
    end
end

function pot:draw()
    self.plant:draw()
end

-- Initializes the pot before starting the simulation
function pot:initialize()
    local music = self.music

    -- Set loop when the selected music is less than 7 mins (which is the intended simulation time)
    if music.audio:getDuration('seconds') < (7*60) then
        music.audio:setLooping(true)
    end

    -- Load the sound data for use of algorithm
    self.music.data = love.sound.newSoundData(music.path)
end

function pot:playMusic()
    -- Plays the music
    self.music.audio:play()
end

function pot:setMusic(music, indexGenre, indexMusic, index)
    if self.music == nil then
        self.music = {}
    end

    if music == nil then
        self.name = nil
        self.music = nil
        return
    end

    -- Set the music table values of pot

    self.music.name       = music.name
    self.music.artist     = music.artist
    self.music.audio      = music.audio
    self.music.path       = music.path
    self.music.genreIndex = indexGenre
    self.music.musicIndex = indexMusic

    -- Set the name of the pot based on specified genre

    for genre, list in pairs(musics) do
        if type(list) == 'table' then
            for _, table in ipairs(list) do
                -- Finding the same table specified using table reference for comparisons
                if music == table then
                    self.name = index .. '. ' ..  tostring(genre):gsub('^%l', string.upper)
                    return
                end
            end
        end
    end

    -- If the specified music hasn't found (out of bounds from identified genre or just wrong input)
    error('Specified music not found')
end

function pot:hasMusic()
    return self.music
end

-- Returns name of the pot, health of the pot, and water level of the pot
function pot:getInfo()
    local waterLevel = self.waterLevel
    waterLevel = math.floor(waterLevel * 100 + 0.5)

    if waterLevel >= 200 then
        waterLevel = '+200%'
    elseif waterLevel <= 0 then
        waterLevel = '-0%'
    else
        waterLevel = waterLevel .. '%'
    end

    return (self.name or 'No genre'), self.plant:getHealth(), waterLevel
end

function pot:getAdditionalInfo()
    
end


return pot