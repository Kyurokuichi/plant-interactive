local enums = require('scripts.interface.enums')

local drwFrame = {}
drwFrame.__index = drwFrame

function drwFrame.new(image, x, y, width, height)
    local newObject = {
        image = image,
        x = x or 0,
        y = y or 0,
        width = width or 0,
        height = height or 0,
        borderScale = 1,

        quads = {},

        isVisible = true,

        __NTFTYPE = enums.key.type[enums.index.type.element],
        __NTFKIND = enums.key.element[enums.index.element.drawable]
    }

    setmetatable(newObject, drwFrame)

    newObject:setImage(image)

    return newObject
end

function drwFrame:draw()
    if not self.isVisible then return end

    local borderScale   = self.borderScale

    local width         = self.image:getWidth()/3
    local height        = self.image:getHeight()/3

    local widthScale    = self.width / width
    local heightScale   = self.height / height

    local scaledWidth   = borderScale * width
    local scaledHeight  = borderScale * height

    -- Center
    love.graphics.draw(
        self.image, self.quads[5], self.x, self.y, 0, widthScale, heightScale
    )

    -- Borders

    -- Top
    love.graphics.draw(
        self.image, self.quads[2], self.x, self.y-scaledHeight, 0, widthScale, borderScale
    )

    -- Left
    love.graphics.draw(
        self.image, self.quads[4], self.x-scaledWidth, self.y, 0, borderScale, heightScale
    )

    -- Bottom
    love.graphics.draw(
        self.image, self.quads[8], self.x, self.y+self.height, 0, widthScale, borderScale
    )
    -- Right
    love.graphics.draw(
        self.image, self.quads[6], self.x+self.width, self.y, 0, borderScale, heightScale
    )

    -- Border corners

    -- Top Left
    love.graphics.draw(
        self.image, self.quads[1], self.x-scaledWidth, self.y-scaledHeight, 0, borderScale, borderScale
    )

    -- Top Right
    love.graphics.draw(
        self.image, self.quads[3], self.x+self.width, self.y-scaledHeight, 0, borderScale, borderScale
    )

    -- Bottom right
    love.graphics.draw(
        self.image, self.quads[9], self.x+self.width, self.y+self.height, 0, borderScale, borderScale
    )

    -- Bottom left
    love.graphics.draw(
        self.image, self.quads[7], self.x-scaledWidth, self.y+self.height, 0, borderScale, borderScale
    )
end

function drwFrame:setImage(image)
    self.image = image

    local quadWidth  = image:getWidth()/3
    local quadHeight = image:getHeight()/3

    local index = 1

    for y = 0, 2 do
        for x = 0, 2 do
            local qx = quadWidth * x
            local qy = quadHeight * y

            if self.quads[index] then
                self.quads[index]:setViewport(
                    qx, qy, quadWidth, quadHeight, image:getWidth(), image:getHeight()
                )
            else
                self.quads[index] = love.graphics.newQuad(
                    qx, qy, quadWidth, quadHeight, image:getWidth(), image:getHeight()
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