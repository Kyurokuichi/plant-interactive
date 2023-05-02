local enums = require 'scripts.enums'
local overlay = require 'scripts.overlay'
local clock = require 'scripts.clock'
local sysntf = require 'scripts.sysntf'
local hint = require 'scripts.hint'
local sfx = require 'scripts.sfx'

-- Classes
local pot = require 'scripts.classes.pot'

local player = {
    phase = {},
    subPhase = {},

    pots = nil,

    alert = false,
    needAttentionPots = {},

    clock = clock,

    selected  = {
        potIndex = nil,
        musicIndex = nil,
        musicGenre = nil,
        previewIndex = nil,

        page = nil,
        genre = nil
    },

    configuration = {
        masterVolume = nil,
        musicVolume = nil,
        SFXVolume = nil
    }
}

function player.initialize()
    player.phase = enums.index.phase.pre

    player.pots = {
        pot.new(),
    }

    player.selected.potIndex = 1
    player.selected.page = 1
    player.selected.genre = 1

    player.configuration.masterVolume = 1
    player.configuration.musicVolume = 1
    player.configuration.SFXVolume = 1
end

function player.getPot(index)
    return player.pots[index]
end

function player.addPot()
    player.pots[#player.pots+1] = pot.new()
end

function player.reset()
    
end

function player.getSelectedPot()
    return player.pots[player.selected.potIndex]
end

function player.loadSimulation()
    -- Check pot if has assigned music

    local failed = false

    for index, pot in ipairs(player.pots) do
        if not pot:hasMusic() then
            local name, _, __ = pot:getInfo()

            hint.add('Pot named "' .. name .. '" doesn\'t have selected music')
            failed = true
        end
    end

    if failed then
        return
    end

    player.phase = enums.index.phase.peri

    for _, pot in ipairs(player.pots) do
        pot:initialize()
    end

    return true
end

function player.update(dt)
    local clock = player.clock

    if player.phase == enums.index.phase.peri then
        clock.update(dt)

        if player.subPhase == enums.index.subPhase.countdown then
            if clock.ranOut then
                clock.setup(7*60)

                player.subPhase = enums.index.subPhase.simulation

                for index, pot in ipairs(player.pots) do
                    pot:playMusic()

                    if player.selected.potIndex ~= index then
                        pot.music.audio:setVolume(0)
                    end
                end
            end
        elseif player.subPhase == enums.index.subPhase.simulation then
            player.alert = false

            for index, pot in ipairs(player.pots) do
                pot:update(dt)

                if pot.needAttention then
                    player.alert = true

                    if not player.needAttentionPots[index] then
                        local name, _, __ = pot:getInfo()

                        player.needAttentionPots[index] = true
                        hint.add('Pot named "' .. name .. '" needs your attention')
                        sfx.play('warning2')
                    end
                else
                    player.needAttentionPots[index] = false
                end
            end

            if clock.ranOut then
                player.phase = enums.index.phase.post

                for index, group in ipairs(sysntf.groups) do
                    if index == 1 then
                        group.isLocked = true
                    elseif index == 6 then
                        group.isLocked = false
                        group.isVisible = true
                    else
                        group.isLocked = true
                        group.isVisible = false
                    end
                end

                for _, pot in ipairs(player.pots) do
                    pot.music.audio:stop()
                end
            end
        else
            player.subPhase = enums.index.subPhase.countdown
            clock.setup(5)
        end
    end

    overlay.update(player.getSelectedPot())
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

function player.draw()
    local selectedPot = player.getSelectedPot()
    local waterLevel = selectedPot.waterLevel
    local r, g, b

    local wiltArea = (1-0.3)
    local swampArea = (1+0.3)

    if waterLevel < wiltArea then
        local t = math.min(math.max(waterLevel, 0), 1)
        t = t / (1-0.3)

        r = lerp(242, 186, t) / 255
        g = lerp(166, 97, t) / 255
        b = lerp(94, 86, t) / 255
    elseif waterLevel > swampArea then
        local t = math.min(math.max(waterLevel-1, 0), 1)
        t = t / (1-0.3)

        r = lerp(186, 140, t) / 255
        g = lerp(97, 63, t) / 255
        b = lerp(86, 93, t) / 255
    else
        r = 186 / 255
        g = 97 / 255
        b = 86 / 255
    end

    love.graphics.setColor(r, g, b, 1)

    love.graphics.rectangle('fill', 44, 115, 56, 15)

    love.graphics.setColor(1, 1, 1, 1)
    selectedPot:draw()
end

return player