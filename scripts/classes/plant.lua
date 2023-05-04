local enums = require 'scripts.enums'
local perlin = require 'scripts.perlin'
local assets = require 'scripts.assets'

-- General Properties
local constantGrowth = 0.1
local bonusGrowthRate = 0.5
local sampleThreshold = 0.01

-- Plant Properties
local startingX, startingY = 72, 122
local noiseThreshold       = 0.01 + 3 - math.pi
local noiseHeight          = 48
local minHeightPercent     = 0.5

-- Functions to be use
local function rotatePoint(x, y, cx, cy, angle)
    local lengthX = x - cx
    local lengthY = y - cy

    local sinAngle = math.sin(angle)
    local cosAngle = math.cos(angle)

    return (cx + lengthX*cosAngle - lengthY*sinAngle), (cy + lengthX*sinAngle + lengthY*cosAngle)
end

local function clamp(n, min, max)
    return math.min(math.max(min, n), max)
end

local plant = {}
plant.__index = plant

function plant.new(pot)
    local newObject = {
        pot = pot,
        height = 0,

        internodes = {
            maxLength        = 12,
            minLengthPercent = 50/100,
            lastSide         = math.random(0, 1) == 1
        },
        petioles = {
            maxLength        = 8,
            minLengthPercent = 75/100,
            lastSide         = nil
        },

        _time = 0,
        _timeLast = 0,
        _sampleSum = 0,
        _sampleCount = 0,

        dataHeight = {}
    }

    return setmetatable(newObject, plant)
end

function plant:getHealth()
    local waterLevel = self.pot.waterLevel

    if waterLevel < (1-0.3) or waterLevel > (1+0.3) then
        return enums.key.health[2]
    else
        return enums.key.health[1]
    end
end

function plant:newInternodeAngleNoise(x, y)
    local internodes = self.internodes

    local noise = perlin.noise(
        x * noiseThreshold * math.random() * 255,
        y * noiseThreshold * math.random() * 255
    )

    -- Right
    if internodes.lastSide and noise >= 0.5 then
        noise = 0.5 + (0.5 - noise)
    -- Left
    elseif not internodes.lastSide and noise < 0.5 then
        noise = 0.5 - (noise - 0.5)
    end

    internodes.lastSide = not internodes.lastSide

    return noise
end

function plant:newInternodeLengthNoise(x, y, min)
    local noise = perlin.noise(
        x * noiseThreshold * math.random() * 255,
        y * noiseThreshold * math.random() * 255
    )

    if not min then
        min = self.internodes.minLengthPercent
    end

    return min + noise * (1 - min)
end

function plant:createNewInternode(latest)
    local internodes = self.internodes
    local ax, ay, bx, by, angle, length

    if not latest then
        ax, ay = startingX, startingY
    else
        ax, ay = latest.bx, latest.by
    end

    if #internodes == 0 then
        angle = math.rad(50 + 80 * self:newInternodeAngleNoise(ax, ay))
        length = internodes.maxLength
    elseif #internodes == 1 then
        angle = math.rad(45 + 90 * self:newInternodeAngleNoise(ax, ay))
        length = internodes.maxLength * self:newInternodeLengthNoise(ax, ay, 0.75)
    else
        angle = math.rad(40 + 100 * self:newInternodeAngleNoise(ax, ay))
        length = internodes.maxLength * self:newInternodeLengthNoise(ax, ay)
    end

    bx, by = rotatePoint(
        ax-length, ay, ax, ay, angle
    )

    -- New internode
    internodes[#internodes+1] = {
        ax = ax,
        ay = ay,
        bx = bx,
        by = by,
        lengthCurrent = 0,
        length = length,
        angle = angle
    }
end

function plant:getLatestInternode()
    return self.internodes[#self.internodes]
end

function plant:newPetioleLengthNoise(x, y)
    local noise = perlin.noise(
        x * noiseThreshold * math.random() * 255,
        y * noiseThreshold * math.random() * 255
    )

    local min = self.petioles.minLengthPercent

    return min + noise * (1 - min)
end

function plant:createNewPetiole(latest)
    local petioles = self.petioles
    local internodes = self.internodes

    if not latest then return end -- Safety feature

    local ax, ay, bx, by, length, angle

    local done = false
    local side = internodes.lastSide

    ax, ay = latest.bx, latest.by

    ::anotherBranch::

    if side then                            -- Right
        angle = latest.angle + math.rad(60)
    else                                    -- Left
        angle = latest.angle - math.rad(60)
    end

    if #internodes == 2 then
        length = petioles.maxLength
    else
        length = petioles.maxLength * self:newPetioleLengthNoise(ax, ay)
    end

    bx, by = rotatePoint(
        ax-length, ay, ax, ay, angle
    )

    petioles[#petioles+1] = {
        ax = ax,
        ay = ay,
        bx = bx,
        by = by,
        lengthCurrent = 0,
        length = length,
        angle = angle,
        side = side
    }

    if #internodes == 2 and not done then
        done = not done -- O rly? lol
        side = not side
        goto anotherBranch
    end
end

function plant:updatePlant(dt, growth)
    local internodes = self.internodes
    local petioles   = self.petioles

    local latestInternode = self:getLatestInternode()

    if not latestInternode then
        self:createNewInternode(nil)
        latestInternode = self:getLatestInternode()
    end

    if latestInternode.lengthCurrent < latestInternode.length and latestInternode.lengthCurrent ~= latestInternode.length then
        latestInternode.lengthCurrent = latestInternode.lengthCurrent + growth
        latestInternode.lengthCurrent = math.min(latestInternode.lengthCurrent, latestInternode.length)
    else
        self:createNewInternode(latestInternode)
        self:createNewPetiole(latestInternode)
    end

    for _, petiole in ipairs(self.petioles) do
        if petiole.lengthCurrent < petiole.length and petiole.lengthCurrent ~= petiole.length then
            petiole.lengthCurrent = petiole.lengthCurrent + growth
            petiole.lengthCurrent = math.min(petiole.lengthCurrent, petiole.length)
        end
    end
end

function plant:update(dt)
    local pot = self.pot

    if self._time > 1 then
        pot.waterLevel = pot.waterLevel - 0.008
        pot.waterLevel = math.min(pot.waterLevel, 2)
        pot.waterLevel = math.max(pot.waterLevel, 0)

        local average = self._sampleSum / self._sampleCount * 10

        -- Growth Algorithm 

        local constant = constantGrowth
        local loudness = bonusGrowthRate * 1024^(-(average-1)^4)
        local health   = -(pot.waterLevel-1)^2 + 1

        local growth   = health * (constant + loudness)

        self:updatePlant(dt, growth)


        self.height = self:getHeight()
        self.dataHeight[#self.dataHeight+1] = self.height

        self._sampleSum = 0
        self._sampleCount = 0
        self._time = 0
    else
        local music = pot.music

        local audio = music.audio
        local data = music.data
        
        if audio:isPlaying() then -- fail safe feature

            --[[
            local sample
            local channels = audio:getChannelCount()

            if channels > 1 then
                sample = 0

                for index = 1, channels do
                    local audioSample = data:getSample(audio:tell('samples'), index)

                    audioSample = math.max(audioSample, 0)
                    audioSample = math.min(audioSample, music.audio:getDuration('samples'))

                    sample = sample + math.abs(audioSample)
                end

                sample = sample / channels
            else
                local audioSample = data:getSample(audio:tell('samples'))

                audioSample = math.max(audioSample, 0)
                audioSample = math.min(audioSample, music.audio:getDuration('samples'))

                sample = math.abs(audioSample)
            end
            --]]

            -- ^^^ Commented this code part because of a bug which caused getting an out of range sample

            local currentSample = audio:tell('samples')

            -- Clamp sample
            currentSample = math.min(currentSample, music.audio:getDuration('samples')
            currentSample = math.max(0, currentSample)

             local audioSample = data:getSample (currentSample)
             audioSample = math.abs(audioSample)

            self._sampleSum = self._sampleSum + audioSample
            self._sampleCount = self._sampleCount + 1

            self._time = self._time + dt
        end
    end
end

function plant:draw()
    local image = assets.image.internode

    for _, internode in ipairs(self.internodes) do
        love.graphics.draw(
            image,
            internode.ax,
            internode.ay,
            internode.angle + math.rad(90),
            1,
            (internode.length / image:getHeight()) * (internode.lengthCurrent / internode.length),
            image:getWidth()/2
        )
    end

    for _, petiole in ipairs(self.petioles) do
        love.graphics.draw(
            image,
            petiole.ax,
            petiole.ay,
            petiole.angle + math.rad(90),
            1,
            (petiole.length / image:getHeight()) * (petiole.lengthCurrent / petiole.length),
            image:getWidth()/2
        )
    end

    image = assets.image.leaf

    for _, petiole in ipairs(self.petioles) do
        local x, y, angle, sx, sy, ox, oy

        local percent = petiole.lengthCurrent / petiole.length

        x  = petiole.ax + (petiole.bx - petiole.ax) * percent
        y  = petiole.ay + (petiole.by - petiole.ay) * percent
        sx = percent
        sy = percent
        ox = image:getWidth()
        oy = image:getHeight()/2

        if petiole.side then
            angle = petiole.angle - math.rad(120)
            sx = -sx
        else
            angle = petiole.angle - math.rad(60)
        end

        love.graphics.draw(
            image,
            x,
            y,
            angle,
            sx,
            sy,
            ox,
            oy
        )
    end
end

function plant:getHeight()
    local height = 0

    for index, internode in ipairs(self.internodes) do
        height = height + math.abs(internode.by - internode.ay) * (internode.lengthCurrent/internode.length)
    end

    return height
end

return plant