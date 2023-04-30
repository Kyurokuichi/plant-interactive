--[[
    Project Growth

    An interactive plant simulator game for our APEC Digital Science Knowledge Fair 2023 & Science Expo 2023

    Created by: Research Project (3rd Quarter course) Group 1 of A07-12 STEM-S2-3
    
    Developers of this interactive:

    Evo Pasculado aka Yonichi4161 (Lead developer, Scripter, Graphics)
    Josiah Garillo (Sound, Graphics)
    Luis Panambo (Sound)
--]]
local
    screen,
    state

function love.load()
    love.graphics.setDefaultFilter('linear', 'nearest')

    screen = require 'scripts.screen'
    screen.initialize(144, 256)

    state = require 'scripts.state'
    state.initialize(
        {
            ['intro'] = require 'scripts.states.intro',
            ['game'] = require 'scripts.states.game'
        },

        'game'
    )
end

function love.mousepressed(x, y, button, isTouch, presses)
    x, y = screen.toScreenCoords(x, y)

    state.call('mousepressed', x, y, button, isTouch, presses)
end

function love.mousereleased(x, y, button, isTouch, presses)
    x, y = screen.toScreenCoords(x, y)

    state.call('mousereleased', x, y, button, isTouch, presses)
end

local lastX, lastY = 0, 0
function love.mousemoved(x, y, dx, dy, isTouch)
    x, y = screen.toScreenCoords(x, y)
    dx = dx - lastX
    dy = dy - lastY

    state.call('mousemoved', x, y, dx, dy, isTouch)

    lastX, lastY = x, y
end

function love.resize(width, height)
    screen.resize()
end

function love.update(dt)
    state.call('update', dt)
end

function love.draw()
    screen.push()
    state.call('draw')
    screen.pop()

    screen.draw()

    state.rectify()
end