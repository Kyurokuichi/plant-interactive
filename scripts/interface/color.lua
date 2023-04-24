local color = {}

-- Shorthand RGB function for switching colors by using conditions
function color.conditionRGB(condition, r1, g1, b1, r2, g2, b2, setColor)
    if condition then
        if setColor then
            love.graphics.setColor(r1, g1, b1)
        else
            return r1, g1, b1
        end
    else
        if setColor then
            love.graphics.setColor(r2, b2, g2)
        else
            return r2, b2, g2
        end
    end
end

-- Shorthand RGBA function for switching colors by using conditions
function color.conditionRGBA(condition, r1, g1, b1, a1, r2, g2, b2, a2, setColor)
    if condition then
        if setColor then
            love.graphics.setColor(r1, g1, b1, a1)
        else
            return r1, g1, b1, a1
        end
    else
        if setColor then
            love.graphics.setColor(r2, b2, g2, a2)
        else
            return r2, b2, g2, a2
        end
    end
end

-- Converts RGB to 0-1 values
function color.RGB(r, g, b, setColor)
    r = r / 255
    g = g / 255
    b = b / 255

    if setColor then
        love.graphics.setColor(r, g, b)
    else
        return r, g, b
    end
end

-- Converts RGBA to 0-1 values
function color.RGBA(r, g, b, a, setColor)
    r = r / 255
    g = g / 255
    b = b / 255
    a = a / 255

    if setColor then
        love.graphics.setColor(r, g, b, a)
    else
        return r, g, b, a
    end
end

-- Lerp between two RGB colors like transition
function color.lerpRGB(ra, ga, ba, rb, gb, bb, time, setColor)
    local r, g, b

    r = ra + (rb - ra) * time
    g = ga + (gb - ga) * time
    b = ba + (bb - ba) * time

    if setColor then
        love.graphics.setColor(r, g, b)
    else
        return r, g, b
    end
end

-- Lerp between two RGBA colors like transition
function color.lerpRGBA(ra, ga, ba, aa, rb, gb, bb, ab, time, setColor)
    local r, g, b, a

    r = ra + (rb - ra) * time
    g = ga + (gb - ga) * time
    b = ba + (bb - ba) * time
    a = aa + (ab - aa) * time

    if setColor then
        love.graphics.setColor(r, g, b, a)
    else
        return r, g, b, a
    end
end

-- https://love2d.org/wiki/HSV_color
function color.hsv(h, s, v)
    if s <= 0 then
        return v, v, v
    end

    h = h * 6

    local c = v * s
    local x = (1 - math.abs(h % 2) - 1) * c

    local m, r, g, b = (v - c), 0, 0, 0

    if h < 1 then
        r, g, b = c, x, 0
    elseif h < 2 then
        r, g, b = x, c, 0
    elseif h < 3 then
        r, g, b = 0, c, x
    elseif h < 4 then
        r, g, b = 0, x, c
    elseif h < 5 then
        r, g, b = x, 0, c
    else
        r, g, b = c, 0, x
    end

    return r+m, g+m, b+m
end

return color