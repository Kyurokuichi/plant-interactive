local enums = require('scripts.interface.enums')

local drwTextScroll = {}
drwTextScroll.__index = drwTextScroll

function drwTextScroll.new(text, x, y, width, height, scrollTime, haltTime, scroll)
    local newObject = {
        text = text,
        x = x or x,
        y = y or y,
        width = width,
        height = height,

        scroll = scroll ~= nil and scroll or true,

        time = {
            halt = haltTime or 1,
            scroll = scrollTime or 2,
        },

        timer = {
            invert = false,
            halt = 0,
            scroll = 0,
        },

        isVisible = false,

        __INTFTYPE = enums.type.element,
        __INTFKIND = enums.element.drawable
    }

    return setmetatable(newObject, drwTextScroll)
end

function drwTextScroll:draw()
    local textWidth     = love.graphics.getFont():getWidth(self.text)
    local textHeight    = love.graphics.getFont():getHeight()

    if self.scroll and textWidth > self.width then
        if self.timer.invert and self.timer.scroll > 0 or (not self.timer.invert and self.timer.scroll < self.time.scroll) then
            if not self.timer.invert then
                self.timer.scroll = math.min(self.timer.scroll + love.timer.getDelta(), self.time.scroll)
            else
                self.timer.scroll = math.max(self.timer.scroll - love.timer.getDelta(), 0)
            end
        else
            if self.timer.halt < self.time.halt then
                self.timer.halt = self.timer.halt + love.timer.getDelta()
            else
                self.timer.invert = not self.timer.invert
                self.timer.halt = 0
            end
        end
    end

    local percentage = self.timer.scroll / self.time.scroll

    -- Basically Lerp function
    local offsetX

    local a = self.x
    local b = (self.x + textWidth - self.width)

    offsetX = a - (b - a) * percentage

    local function stencil()
        love.graphics.rectangle('fill', self.x, self.y, self.width, textHeight)
    end

    love.graphics.stencil(stencil, 'replace', 1)

    love.graphics.setStencilTest('greater', 0)

    love.graphics.print(
        self.text,
        offsetX,
        self.y
    )

    love.graphics.setStencilTest()

    --love.graphics.rectangle('fill', self.x, self.y, self.width, textHeight)
end

function drwTextScroll:setVisibility(bool)
    self.isVisible = bool
end

return drwTextScroll