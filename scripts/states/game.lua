local
    screen,
    assets,
    sysntf,
    hint,
    sfx,
    color,
    player,
    cursor,
    perlin,
    letterboxQuad,
    letterboxImage

local game = {}

function game.load()
    -- Initialize stuffs
    assets = require 'scripts.assets'
    assets.loadAll()

    screen = require 'scripts.screen'

    letterboxImage = assets.getImage('backgroundLetterBox')
    letterboxImage:setWrap('repeat', 'repeat')
    letterboxQuad = love.graphics.newQuad(0, 0, love.graphics.getWidth(), love.graphics.getHeight(), letterboxImage:getWidth(), letterboxImage:getHeight())

    love.graphics.setFont(assets.getFont('small'))

    sfx = require 'scripts.sfx'
    sfx.initialize()

    perlin = require 'scripts.perlin'
    perlin.generate()

    player = require 'scripts.player'
    player.initialize()

    sysntf = require 'scripts.sysntf'
    sysntf:connect(require 'scripts.interfaces.main')             -- 1
    sysntf:connect(require 'scripts.interfaces.pots-menu')        -- 2
    sysntf:connect(require 'scripts.interfaces.music-menu')       -- 3
    sysntf:connect(require 'scripts.interfaces.more-menu.init')   -- 4
    sysntf:connect(require 'scripts.interfaces.start-menu')       -- 5
    sysntf:connect(require 'scripts.interfaces.result-menu.init') -- 6

    cursor = require 'scripts.cursor'

    color = require 'scripts.color'

    hint = require 'scripts.hint'
    hint.initialize()
end

function game.update(dt)
    -- Constantly updating letter box size (may not be a problem on affecting performance)
    letterboxQuad:setViewport(0, 0, love.graphics.getWidth(), love.graphics.getHeight(), letterboxImage:getWidth(), letterboxImage:getHeight())

    player.update(dt)
    sysntf:emit('update', dt)
    hint.update(dt)
    cursor.update(dt)
end

function game.draw()
    screen.pop()

    love.graphics.draw(letterboxImage, letterboxQuad, 0, 0)

    screen.push(true)

    sysntf:emit('draw')

    --color.RGB(255, 107, 151, true)
    hint.draw()
    --love.graphics.setColor(1, 1, 1)

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