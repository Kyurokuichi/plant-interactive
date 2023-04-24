--[[
--  I know what you're thinking its not what it is lmao
--  ntr is shorthand for "interactable". You see it sounds like een-teer. Now u know XD
--]]

local enums = require('scripts.interface.enums')

local ntrRect = {}
ntrRect.__index = ntrRect

function ntrRect.new(x, y, width, height)
    local newObject = {
        x = x or 0,
        y = y or 0,
        width = width or 0,
        height = height or 0,

        isClicked = false,
        isHoldingClick = false,
        isCursorHovering = false,

        isLocked = false,

        __NTFTYPE = enums.key.type[enums.index.type.element],
        __NTFKIND = enums.key.element[enums.index.element.interactable]
    }

    return setmetatable(newObject, ntrRect)
end

function ntrRect:checkIntersect(x, y)
    if self.isLocked then return end

    return x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.height)
end

function ntrRect:mousepressed(x, y, button, isTouch, presses)
    if self.isLocked then return end

    local intersect = self:checkIntersect(x, y)

    if button == 1 then
        if intersect then
            self.isHoldingClick = true
        end
    end
end

function ntrRect:mousereleased(x, y, button, isTouch, presses)
    if self.isLocked then return end

    local intersect = self:checkIntersect(x, y)

    if button == 1 then
        self.isHoldingClick = false

        if intersect then
            self.isClicked = true
        end
    end
end

function ntrRect:mousemoved(x, y, dx, dy, isTouch)
    if self.isLocked then return end

    local intersect = self:checkIntersect(x, y)
    self.isCursorHovering = intersect
end

function ntrRect:reset()
    if self.isClicked then
        self.isClicked = false
    end

    if self.group.isLocked or self.isLocked then
        if self.isHoldingClick then
            self.isHoldingClick = false
        end
        if self.isCursorHovering then
            self.isCursorHovering = false
        end
    end
end

function ntrRect:setLock(bool)
    self.isLocked = bool
end

return ntrRect