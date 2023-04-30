local screen = {
    x = 0,              -- Offset X
    y = 0,              -- Offset Y
    width = 0,
    height = 0,
    scale = 0,
    canvas = nil        -- Frame of the screen
}

---- Methods ----

function screen.resize()
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()

    screen.scale = math.min(
        windowWidth / screen.width,
        windowHeight / screen.height
    )

    screen.x = (windowWidth - screen.width * screen.scale) / 2
    screen.y = (windowHeight - screen.height * screen.scale) / 2
end

function screen.setDimensions(desiredWidth, desiredHeight)
    screen.width = desiredWidth
    screen.height = desiredHeight

    if screen.canvas then
        screen.canvas:release()
    end

    screen.canvas = love.graphics.newCanvas(screen.width, screen.height)
end

function screen.initialize(desiredWidth, desiredHeight)
    screen.setDimensions(desiredWidth, desiredHeight)
    screen.resize()
end

function screen.push(noclear)
    love.graphics.setCanvas({screen.canvas, stencil = true})

    if not noclear then
        love.graphics.clear()
    end
end

function screen.pop()
    love.graphics.setCanvas() -- Supposedly "love.graphics.setCanvas(nil)" but yellow highlight warning made me annoyed
end

function screen.draw()
    love.graphics.push()

    love.graphics.translate(screen.x, screen.y)
    love.graphics.scale(screen.scale)

    love.graphics.draw(screen.canvas, 0, 0)

    love.graphics.pop()
end

---- Additional Methods ----

function screen.toScreenCoords(x, y)
    if x ~= nil then
        x = x - screen.x
        x = x / (love.graphics.getWidth() - screen.x * 2)
        x = x * screen.width
    end

    if y ~= nil then
        y = y - screen.y
        y = y / (love.graphics.getHeight() - screen.y * 2)
        y = y * screen.height
    end

    if x ~= nil and y ~= nil then
        return x, y
    elseif x ~= nil then
        return x
    else
        return y
    end
end

function screen.toWindowCoords(x, y)
    local rx, ry

    if x ~= nil then
        rx = screen.x * screen.width - 2 * screen.x * x
        rx = rx + love.graphics.getWidth() * x
        rx = rx / screen.width
    end

    if y ~= nil then
        ry = screen.y * screen.width - 2 * screen.x * y
        ry = ry + love.graphics.getWidth() * y
        ry = ry / screen.width
    end

    if x ~= nil and y ~= nil then
        return rx, ry
    elseif x ~= nil then
        return rx
    else
        return ry
    end
end

return screen