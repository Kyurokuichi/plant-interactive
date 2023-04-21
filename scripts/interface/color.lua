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

function color.lerpRGB(colorA, colorB, time)
    local r = colorA[1] + (colorB[1]-colorA[1]) * time
    local g = colorA[2] + (colorB[2]-colorA[2]) * time
    local b = colorA[3] + (colorB[3]-colorA[3]) * time

    return r, g, b
end

return color