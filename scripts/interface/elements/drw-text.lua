local enums = require('scripts.interface.enums')

local drwText = {}
drwText.__index = drwText

function drwText.new(text, x, y, width, height, align)
    local newObject = {
        text = text or '',
        x = x or 0,
        y = y or 0,
        width = width or 0,
        height = height or 0,

        alignment = align or 'center',
        alignCenterY = true,

        isVisible = true,

        __NTFTYPE = enums.key.type[enums.index.type.element],
        __NTFKIND = enums.key.element[enums.index.element.drawable]
    }

    return setmetatable(newObject, drwText)
end

function drwText:draw()
    if not self.isVisible then return end

    local textWidth     = love.graphics.getFont():getWidth(self.text)
    local textHeight    = love.graphics.getFont():getHeight() * math.ceil(textWidth / self.width)

    local y

    if self.alignCenterY then
        y = self.y + (self.height - textHeight)/2
    else
        y = self.y
    end

    love.graphics.printf(
        self.text,
        self.x,
        y,
        self.width,
        self.alignment
    )
end

function drwText:setVisibility(bool)
    self.isVisible = bool
end

function drwText:setAlign(align)
    self.alignment = align
end

return drwText

