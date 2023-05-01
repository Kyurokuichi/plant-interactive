local clock = {
    time = 0,
    ranOut = true
}

function clock.setup(duration)
    clock.time = duration
    clock.ranOut = false
end

function clock.update(dt)
    if clock.ranOut then
        return
    end

    clock.time = clock.time - dt
    clock.time = math.max(clock.time, 0) -- Prevents the timer going down to negative value

    if clock.time <= 0 then
        clock.ranOut = true
    end
end

function clock.tellTime()
    local time = clock.time

    local seconds = math.floor(time % 60)
    local minutes = math.floor(time / 60)

    seconds = string.format('%02d', seconds)
    minutes = string.format('%02d', minutes)

    local text = 'T- ' .. minutes .. ':' .. seconds

    return text
end

function clock.tellRunning()
    return not clock.ranOut
end

return clock