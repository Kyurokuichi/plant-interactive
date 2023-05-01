local enums = require 'scripts.interface.enums'

local drwTextScroll = {}
drwTextScroll.__index = drwTextScroll

function drwTextScroll.new(text, x, y, width, height, timeScroll, timeHalt, enabled)
    local newObject = {
        text = text,
        x = x or 0,
        y = y or 0,
        width = width,
        height = height,

        isEnabled = enabled,

        time = {
            scroll = timeScroll or 0.5,
            halt = timeHalt or 0.5,
        },

        lerp = {
            reverse = false,
            halted = false,
            time = 0,
            a = 0,
            b = 0
        },

        isVisible = true,

        __NTFTYPE = enums.key.type[enums.index.type.element],
        __NTFKIND = enums.key.element[enums.index.element.drawable]
    }

    setmetatable(newObject, drwTextScroll)

    newObject:setDimensions(width, height)
    newObject:setText(text)

    return newObject
end

function drwTextScroll:setDimensions(width, height, font)
    self.width = width
    self.height = height

    if self.text then
        if font then
            love.graphics.setFont(font)
        end

        local textWidth = love.graphics.getFont():getWidth(self.text)

        if self.lerp.b == self.x then
            self.lerp.a = self.x - textWidth + self.width
            self.lerp.b = self.x
        else
            self.lerp.a = self.x
            self.lerp.b = self.x - textWidth + self.width
        end
    end
end

function drwTextScroll:setText(text)
    if text then
        self.text = text

        local textWidth = love.graphics.getFont():getWidth(self.text)

        if self.lerp.b == self.x then
            self.lerp.a = self.x - textWidth + self.width
            self.lerp.b = self.x
        else
            self.lerp.a = self.x
            self.lerp.b = self.x - textWidth + self.width
        end
    end
end

function drwTextScroll:update(dt)
    if not self.isEnabled or not self.text then return end

    local textWidth  = love.graphics.getFont():getWidth(self.text)

    if textWidth > self.width then
        if not self.lerp.halted then
            if self.lerp.time < self.time.scroll then
                self.lerp.time = math.min(self.lerp.time + dt, self.time.scroll)
            else
                self.lerp.halted = true
                self.lerp.time = 0
                self.lerp.a, self.lerp.b = self.lerp.b, self.lerp.a
            end
        else
            if self.lerp.time < self.time.scroll then
                self.lerp.time = math.min(self.lerp.time + dt, self.time.halt)
            else
                self.lerp.halted = false
                self.lerp.time = 0
            end
        end
    end
end

function drwTextScroll:draw()
    if not self.isVisible or not self.text then return end

    local time

    if self.lerp.halted then
        time = 0
    else
        time = self.lerp.time
    end

    time = time / self.time.scroll

    -- Basically lerp function f(x) = x0 + (x1- x0) * t
    local x = self.lerp.a + (self.lerp.b - self.lerp.a) * time

    -- Stencil

    local textHeight = love.graphics.getFont():getHeight()

    local function stencil()
        love.graphics.rectangle('fill', self.x, self.y, self.width, textHeight)
    end

    love.graphics.stencil(stencil, 'replace', 1)

    love.graphics.setStencilTest('greater', 0)

    love.graphics.print(
        self.text,
        x,
        self.y
    )

    love.graphics.setStencilTest()
end

return drwTextScroll
