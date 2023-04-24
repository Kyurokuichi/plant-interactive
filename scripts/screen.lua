local screen = {
    width = 0,
    height = 0,
    canvas = nil,
    scale = 0,
    offsetX = 0,
    offsetY = 0
}

-- Initializes screen
function screen:initialize(width, height)
    self:setDimensions(width, height)
    self:resize(love.graphics.getDimensions())
end

-- Resizes the screen using specified window dimensions
function screen:resize(width, height)
    self.scale = math.min(
        width / self.width,
        height / self.height
    )

    self.offsetX = (width - self.width * self.scale) / 2
    self.offsetY = (height - self.height * self.scale) / 2
end

-- Sets new desired dimensions to screen
function screen:setDimensions(width, height)
    self.width = width
    self.height = height

    if self.canvas then
        self.canvas:release()
    end

    self.canvas = love.graphics.newCanvas(self.width, self.height)
end

-- Makes the drawables draw on the screen
function screen:push(noclear)
    love.graphics.setCanvas({screen.canvas, stencil = true})
    if not noclear then love.graphics.clear() end
end

-- Makes the drawables don't draw on the screen (NOTE: call this function if it's done drawing all drawables intended for screen)
function screen:pop()
    love.graphics.setCanvas(nil)
end

-- Draws the screen
function screen:draw()
    love.graphics.push()

    love.graphics.translate(self.offsetX, self.offsetY)
    love.graphics.scale(self.scale)

    love.graphics.draw(self.canvas)

    love.graphics.pop()
end

-- Translates normal coordinates into relative to screen coordinates
function screen:translate(x, y)
    if x ~= nil then
        x = x - self.offsetX
        x = x / (love.graphics.getWidth() - self.offsetX * 2)
        x = x * self.width
    end

    if y ~= nil then
        y = y - self.offsetY
        y = y / (love.graphics.getHeight() - self.offsetY * 2)
        y = y * self.height
    end

    if x ~= nil and y ~= nil then
        return x, y
    elseif x ~= nil then
        return x
    else
        return y
    end
end

-- Inverse function of translate. Basically untranslates back to normal coordinates
function screen:inverseTranslate(x, y)
    local ux, uy

    if x ~= nil then
        ux = self.offsetX * screen.width - 2 * screen.offsetX * x
        ux = ux + love.graphics.getWidth() * x
        ux = ux / self.width
    end

    if y ~= nil then
        uy = self.offsetY * screen.height - 2 * screen.offsetY * y
        uy = uy + love.graphics.getHeight() * y
        uy = uy / self.height
    end

    if x ~= nil and y ~= nil then
        return ux, uy
    elseif x ~= nil then
        return ux
    else
        return uy
    end
end

return screen