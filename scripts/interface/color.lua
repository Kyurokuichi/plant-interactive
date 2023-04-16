local color = {}

function color.colorIfTrue(condition, color_true, color_false)
    if condition then
        love.graphics.setColor(color_true)
    else
        love.graphics.setColor(color_false)
    end
end

return color