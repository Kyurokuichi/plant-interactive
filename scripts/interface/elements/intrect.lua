-- Interactable type rectangle
local enums = require('scripts.interface.enums')

local intrect = {}
-- Creates new interactable rectangle (intrect) object
function intrect.new(x, y, width, height)
    local newObject = {
        x = x or 0,
        y = y or 0,
        width = width or 0,
        height = height or 0,

        isClicked = false,
        isHoldingClick = false,
        isCursorHovering = false,

        group = nil,
        _fromInterface = true,
        _type = enums.element.interactable
    }
    return setmetatable(newObject, intrect)
end
-- Check if a point has intersected
function intrect:checkIntersect(x, y)
    return x >= self.x and x <= (self.x + self.width) and y >= self.y and x <= (self.y + self.height)
end
-- Callback function event for mousepressed
function intrect:mousepressed(x, y, button, isTouch, presses)
    local intersect = self:checkIntersect(x, y)

    if button == 1 then
        if intersect then
            self.isHoldingClick = true
        end
    end
end
-- Callback function event for mousereleased
function intrect:mousereleased(x, y, button, isTouch, presses)
    local intersect = self:checkIntersect(x, y)

    if button == 1 then
        self.isHoldingClick = false

        if intersect then
            self.isClicked = true
        end
    end
end
-- Callback function event for mousemoved
function intrect:mousemoved(x, y, dx, dy, isTouch)
    local intersect = self:checkIntersect(x, y)
    self.isCursorHovering = intersect
end
-- Callback function event for reset
function intrect:reset()
    if self.isClicked then
        self.isClicked = false
    end

    if self.group.isLocked then
        if self.isHoldingClick then
            self.isHoldingClick = false
        end
        if self.isCursorHovering then
            self.isCursorHovering = false
        end
    end
end

return intrect