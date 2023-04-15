local drwImage = {}

function drwImage.new(image, x, y, width, height)
    local newObject = {
        image = image,
        x = x or 0,
        y = y or 0,
        width = width or image:getWidth(),
        height = height or image:getHeight(),
        isVisible = true
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
        self.image:getWidth()/self.width,
        self.image:getHeight()/self.height
    )
end

function drwImage:setImage(image)
    self.image = image
end

function drwImage:setVisibility(bool)
    self.isVisible = bool
end

return drwImage