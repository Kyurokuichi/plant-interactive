local screen = require 'scripts.screen'

local hint = {
    x = nil,
    y = nil,
    width = nil,
    texts = nil,
    duration = nil,
}

function hint.initialize()
    hint.width = 128

    hint.x = screen.width/2 - hint.width/2
    hint.y = screen.height * 0.1

    hint.texts = {}
    hint.duration = 4
end

function hint.add(text)
    hint.texts[#hint.texts+1] = {
        text = text,
        timer = 0,
    }
end

function hint.update(dt)
    local deleteText = {}

    for index, text in ipairs(hint.texts) do
        if text.timer >= hint.duration then
            deleteText[#deleteText+1] = index
        else
            text.timer = text.timer + dt
        end
    end

    if #deleteText > 0 then
        for index = #deleteText, 1, -1 do
            table.remove(hint.texts, deleteText[index])
        end
    end
end

function hint.draw()
    local offsetY = 0

    for _, text in ipairs(hint.texts) do
        local textWidth = love.graphics.getFont():getWidth(text.text)
        local textHeight = love.graphics.getFont():getHeight() * math.ceil(textWidth / hint.width)

        local x = hint.x
        local y = hint.y + offsetY

        love.graphics.printf(text.text, x, y, hint.width, 'center')

        offsetY = offsetY + textHeight
    end
end

return hint