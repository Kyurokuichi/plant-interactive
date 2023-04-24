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
    assets,
    player,
    sysNtf,
    perlin

function love.load(arg, unfilteredArg)
    love.graphics.setDefaultFilter('linear', 'nearest')

    local desiredWidth, desiredHeight = 144, 256 -- 144x256

    screen = require 'scripts.screen'
    screen:initialize(desiredWidth, desiredHeight)

    assets = require 'scripts.assets'
    assets:initialize()

    love.graphics.setFont(assets.font.small)

    player = require 'scripts.player'
    player:initialize()

    sysNtf = require 'scripts.sysntf'
    sysNtf:connect( require 'scripts.interfaces.main' )         -- 1
    sysNtf:connect( require 'scripts.interfaces.menu-pots' )    -- 2
    sysNtf:connect( require 'scripts.interfaces.menu-musics' )  -- 3
    sysNtf:connect( require 'scripts.interfaces.menu-more' )    -- 4
    sysNtf:connect( require 'scripts.interfaces.menu-start')    -- 5

    perlin = require 'scripts.perlin'

    math.randomseed(os.time())
    perlin.generate()
end

function love.keypressed()
    
end

function love.keyreleased()
    
end

function love.mousepressed(x, y, button, isTouch, presses)
    x, y = screen:translate(x, y)
    sysNtf:emit('mousepressed', x, y, button, isTouch, presses)
end

function love.mousereleased(x, y, button, isTouch, presses)
    x, y = screen:translate(x, y)
    sysNtf:emit('mousereleased', x, y, button, isTouch, presses)
end

local lastDX, lastDY = 0, 0
function love.mousemoved(x, y, dx, dy, isTouch)
    x, y = screen:translate(x, y)
    dx = dx - lastDX
    dy = dy - lastDY

    sysNtf:emit('mousemoved', x, y, dx, dy, isTouch)
end

function love.resize(width, height)
    screen:resize(width, height)
end

function love.update(dt)
    player:update(dt)
    sysNtf:emit('update', dt)
end

function love.draw()
    screen:push()

    sysNtf:emit('draw')

    local mx, my = screen:translate(love.mouse.getPosition())
    love.graphics.circle('fill', mx, my, 4)

    screen:pop()

    screen:draw()

    sysNtf:emit('reset')
end