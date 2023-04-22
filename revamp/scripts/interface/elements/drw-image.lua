local enums = require('scripts.interface.enums')

local drwImage = {}
drwImage.__index = drwImage

function drwImage.new(image, x, y, width, height)
    local newObject = {
        image = image,
        x = x or 0,
        y = y or 0,
        width = width or image:getWidth(),
        height = height or image:getHeight(),
        isVisible = true,

        __NTFTYPE = enums.key.type[enums.index.type.element],
        __NTFKIND = enums.key.element[enums.index.element.drawable]
    }

    return setmetatable(newObject, drwImage)
end

-- Draws the image
function drwImage:draw()
    if not self.isVisible then return end

    love.graphics.draw(
        self.image,
        self.x,
        self.y,
        0,
        self.width/self.image:getWidth(),
        self.height/self.image:getHeight()
    )
end

function drwImage:setImage(image)
    self.image = image
end

function drwImage:setVisibility(bool)
    self.isVisible = bool
end

return drwImage