--[[
    Plant interactive
--]]

local screen
local assets
local sysintf

function love.load(arg, unfilteredArg)
    local desiredWidth, desiredHeight = 144, 256

    love.graphics.setDefaultFilter('nearest', 'nearest')

    screen = require('scripts.screen')
    screen.initialize(desiredWidth, desiredHeight)

    love.graphics.setDefaultFilter('nearest', 'nearest') -- Prevent lowres images blurry
    assets = require('scripts.assets')
    assets.initialize()

    sysintf = require('scripts.sysintf')
    sysintf:connect(require('scripts.uis.main'))
end

function love.update(dt)
    sysintf:emit('update', dt)
end

function love.draw()
    screen.push()

    love.graphics.setFont(assets.font.small)

    sysintf:emit('draw')

    local x, y = screen.translatePosition(love.mouse.getPosition())
    love.graphics.circle('fill', x, y, 16)

    screen.pop()

    screen.draw()

    love.graphics.setColor(1, 1, 1)
    sysintf:reset()
end

function love.resize(width, height)
    screen.resize(width, height)
end

function love.mousepressed(x, y, button, isTouch, presses)
    x, y = screen.translatePosition(x, y)
    sysintf:emit('mousepressed', x, y, button, isTouch, presses)
end

function love.mousereleased(x, y, button, isTouch, presses)
    x, y = screen.translatePosition(x, y)
    sysintf:emit('mousereleased', x, y, button, isTouch, presses)
end

local lastDX, lastDY = 0, 0
function love.mousemoved(x, y, dx, dy, isTouch)
    x, y = screen.translatePosition(x, y)
    dx = dx - lastDX
    dy = dy - lastDY

    sysintf:emit('mousemoved', x, y, dx, dy, isTouch)

    lastDX, lastDY = dx, dy
end
