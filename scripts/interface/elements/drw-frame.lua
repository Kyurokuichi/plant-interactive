local enums = require('scripts.interface.enums')

local drwFrame = {}

function drwFrame.new(image, x, y, width, height)
    local newObject = {
        image = image,
        x = x or 0,
        y = y or 0,
        width = width or 0,
        height = height or 0,

        quads = {},

        isVisible = false
    }

    setmetatable(newObject, drwFrame)

    return newObject
end

function drwFrame:setImage(image)
    self.image = image

    local portionWidth  = image:getWidth():getWidth()/3
    local portionHeight = image:getHeight():getHeight()/3

    local index = 1

    for y = 0, 2 do
        for x = 0, 2 do
            local qx = portionWidth * x
            local qy = portionHeight * y

            if self.quads[enums.drwFrame.quad[index]] then
                self.quads[enums.drwFrame.quad[index]]:setViewport(
                    qx, qy, portionWidth, portionHeight, image:getWidth(), image:getHeight()
                )
            else
                self.quads[enums.drwFrame.quad[index]] = love.graphics.newQuad(
                    qx, qy, portionWidth, portionHeight, image:getWidth(), image:getHeight()
                )
            end

            index = index + 1
        end
    end
end

function drwFrame:setVisibility(bool)
    self.isVisible = bool
end

return drwFrame