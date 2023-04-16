local color = {}

function color.condition(condition, colorA, colorB)
    if condition then
        love.graphics.setColor(colorA)
    else
        if colorB then
            love.graphics.setColor(colorB)
        end
    end
end

return color