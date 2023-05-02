local color = require 'scripts.color'

local cursor = {
    trails = {},

    trailMaxWidth = 6,
    trailMaxLength = 14,
    trailDuration = 0.03,
    trailTimer = 0,
}

function cursor.trail(x, y)
    table.insert(cursor.trails, 1, y)
    table.insert(cursor.trails, 1, x)

    if #cursor.trails > cursor.trailMaxLength then
        for index = #cursor.trails, cursor.trailMaxLength*2+1, -1 do
            cursor.trails[index] = nil
        end
    end
end

function cursor.update(dt)
    if #cursor.trails > 2 then
        cursor.trailTimer = cursor.trailTimer + dt

        while cursor.trailTimer > cursor.trailDuration do
            cursor.trailTimer = cursor.trailTimer - cursor.trailDuration

            table.remove(cursor.trails, #cursor.trails)
            table.remove(cursor.trails, #cursor.trails)
        end
    end
end

function cursor.draw()
    local function getTrailWidth(index)
        return (#cursor.trails - (index + 1)) / #cursor.trails
    end

    color.RGB(207, 255, 112, true)

    if cursor.trails[1] then
        local width = cursor.trailMaxWidth * getTrailWidth(1)

        love.graphics.circle('fill', cursor.trails[1], cursor.trails[2], width/2)
    end

    for index = #cursor.trails-1, 3, -2 do
        local shade = getTrailWidth(index)
        local width = cursor.trailMaxWidth * shade

        color.RGBA(207, 255, 112, shade * 255, true)

        love.graphics.setLineWidth(width)

        love.graphics.line(cursor.trails[index-2], cursor.trails[index-1], cursor.trails[index], cursor.trails[index+1])
        love.graphics.circle('fill', cursor.trails[index], cursor.trails[index+1], width/2)
    end

    love.graphics.setColor(1, 1, 1)
end

return cursor