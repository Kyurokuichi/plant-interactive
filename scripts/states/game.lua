local
    assets,
    player,
    perlin,
    sysntf,
    screen,
    cursor,
    sfx

local game = {}

function game.load()
    -- Initialize stuffs
    assets = require 'scripts.assets'
    assets.loadAll()

    screen = require 'scripts.screen'

    love.graphics.setFont(assets.getFont('small'))

    sfx = require 'scripts.sfx'
    sfx.initialize()

    perlin = require 'scripts.perlin'
    perlin.generate()

    player = require 'scripts.player'
    player.initialize()

    sysntf = require 'scripts.sysntf'
    sysntf:connect(require 'scripts.interfaces.main')
    sysntf:connect(require 'scripts.interfaces.pots-menu')
    sysntf:connect(require 'scripts.interfaces.music-menu')
    sysntf:connect(require 'scripts.interfaces.more-menu')
    sysntf:connect(require 'scripts.interfaces.start-menu')
    sysntf:connect(require 'scripts.interfaces.result-menu.init')

    cursor = require 'scripts.cursor'
end

function game.update(dt)
    player.update(dt)
    sysntf:emit('update', dt)
    cursor.update(dt)
end

function game.draw()
    sysntf:emit('draw')
    sysntf:reset()
    cursor.draw()
end

function game.mousepressed(x, y, button, isTouch, presses)
    sysntf:emit('mousepressed', x, y, button, isTouch, presses)
end

function game.mousereleased(x, y, button, isTouch, presses)
    sysntf:emit('mousereleased', x, y, button, isTouch, presses)
end

function game.mousemoved(x, y, dx, dy, isTouch)
    sysntf:emit('mousemoved', x, y, dx, dy, isTouch)
    cursor.trail(x, y)
end

return game