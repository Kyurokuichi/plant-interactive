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

function color.rgb(r, g, b, a)
    return r/255, g/255, b/255
end

function color.rgba(r, g, b, a)
    return r/255, g/255, b/255, a/55
end

return color