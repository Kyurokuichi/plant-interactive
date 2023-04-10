local screen = {
    width = 0,
    height = 0,
    canvas = nil,
    scale = 0,
    offsetX = 0,
    offsetY = 0
}

-- Initialize screen (run only once on load)
function screen.initialize(width, height)
    screen.setDimension(width, height)
    screen.resize(love.graphics.getDimensions())
end
-- Resizes the screen on given dimension
function screen.resize(width, height)
    screen.scale = math.min(
        width / screen.width,
        height / screen.height
    )

    screen.offsetX = (width - screen.width * screen.scale) * 0.5
    screen.offsetY = (height - screen.height * screen.scale) * 0.5
end
-- Reset screen dimension
function screen.setDimension(width, height)
    screen.width = width
    screen.height = height

    if screen.canvas then
        screen.canvas:release()
    end

    screen.canvas = love.graphics.newCanvas(width, height)
end
-- Push drawables into the screen
function screen.push(noClear)
    love.graphics.setCanvas(screen.canvas)
    if not noClear then love.graphics.clear() end
end
-- Pop drawables out from screen
function screen.pop()
    love.graphics.setCanvas(nil)
end
-- Draw the screen
function screen.draw()
    love.graphics.push()

    love.graphics.translate(screen.offsetX, screen.offsetY)
    love.graphics.scale(screen.scale)

    love.graphics.draw(screen.canvas)

    love.graphics.pop()
end
-- Translate position into relative coordinate of the screen
function screen.translatePosition(x, y)
    x = x - screen.offsetX
    y = y - screen.offsetY

    x = x / (love.graphics.getWidth() - screen.offsetX * 2)
    y = y / (love.graphics.getHeight() - screen.offsetY * 2)

    x = x * screen.width
    y = y * screen.height

    return x, y
end
-- Untranslate position into normal coordinate
function screen.inverseTranslatePosition(x, y)
    local ux, uy
    
    ux = screen.offsetX * screen.width - 2 * screen.offsetX * x
    uy = screen.offsetY * screen.height - 2 * screen.offsetY * y

    ux = ux + love.graphics.getWidth() * x
    uy = uy + love.graphics.getHeight() * y

    ux = ux / screen.width
    uy = uy / screen.height

    return ux, uy
end

return screen