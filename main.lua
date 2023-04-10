--[[
    Plant interactive
--]]

local screen
local assets

function example()
    
end

print(tostring(example):gsub('function: ', ''))

function love.load(arg, unfilteredArg)
    local desiredWidth, desiredHeight = 144, 256

    screen = require('scripts.screen')
    screen.initialize(desiredWidth, desiredHeight)

    love.graphics.setDefaultFilter('nearest', 'nearest') -- Prevent lowres images blurry
    assets = require('scripts.assets')
    assets.initialize()
end

function love.update(dt)
    
end

function love.draw()
    screen.push()

    local x, y = screen.translatePosition(love.mouse.getPosition())

    love.graphics.circle('fill', x, y, 16)

    screen.pop()

    screen.draw()

    love.graphics.setColor(1, 1, 1)
end

function love.resize(width, height)
    screen.resize(width, height)
end

function love.mousepressed(x, y, button, isTouch, presses)
    
end

function love.mousereleased(x, y, button, isTouch, presses)
    
end

function love.mousemoved(x, y, dx, dy, isTouch)
    
end
