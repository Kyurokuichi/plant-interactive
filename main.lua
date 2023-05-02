--[[
    Project Growth

    An interactive plant simulator game for our APEC Digital Science Knowledge Fair 2023 & Science Expo 2023

    Created by: Research Project (3rd Quarter course) Group 1 of A07-12 STEM-S2-3
    
    Developers of this interactive:

    Evo Pasculado aka Yonichi4161 (Lead developer, Scripter, Graphics)
    Josiah Garillo (Sound, Graphics)
    Luis Panambo (Sound)

    Version history:
    version 1.0 ; First release
    version 2.0 ; To be release (polished verson, patches, & new features)
--]]

local
    screen,
    state,

    lastMX,
    lastMY,
    touchID

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- Forces the game on portrait mode (uncomment when release)
    --love.window.setMode(1, 2)

    screen = require 'scripts.screen'
    screen.initialize(144, 256)

    state = require 'scripts.state'
    state.initialize(
        {
            ['intro'] = require 'scripts.states.intro', -- Splash screen when the app is opened
            ['game'] = require 'scripts.states.game' -- Actual interactive game
        },

        'game'
    )

    lastMX, lastMY = 0, 0
end

if love.system.getOS() == 'android' then
    function love.touchpressed(id, x, y, dx, dy, pressure)
        if not touchID then
            touchID = id
        end

        if id == touchID then
            x, y = screen.toScreenCoords(x, y)

            state.call('mousepressed', x, y, 1, true, 1)
        end
    end

    function love.touchreleased(id, x, y, dx, dy, pressure)
        if not touchID then
            touchID = id
        end

        if id == touchID then
            x, y = screen.toScreenCoords(x, y)

            state.call('mousereleased', x, y, 1, true, 1)
        end
    end

    function love.touchmoved(id, x, y, dx, dy, pressure)
        if not touchID then
            touchID = id
        end

        if id == touchID then
            x, y = screen.toScreenCoords(x, y)
            dx = lastMX - x
            dy = lastMY - y

            state.call('mousemoved', x, y, dx, dy, true)

            lastMX, lastMY = x, y
        end
    end
else
    function love.mousepressed(x, y, button, isTouch, presses)
        x, y = screen.toScreenCoords(x, y)

        state.call('mousepressed', x, y, button, isTouch, presses)
    end

    function love.mousereleased(x, y, button, isTouch, presses)
        x, y = screen.toScreenCoords(x, y)

        state.call('mousereleased', x, y, button, isTouch, presses)
    end

    function love.mousemoved(x, y, dx, dy, isTouch)
        x, y = screen.toScreenCoords(x, y)
        dx = lastMX - x
        dy = lastMY - y

        state.call('mousemoved', x, y, dx, dy, isTouch)

        lastMX, lastMY = x, y
    end
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