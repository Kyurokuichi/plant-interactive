local clock = {
    time = 0
}

function clock.setup(duration)
    clock.time = duration
end

function clock.update(dt)
    clock.time = clock.time - dt
end

function clock.tellTime()
    local time = clock.time

    local seconds = math.floor(clock.time % 60)
    local minutes = math.floor(clock.time / 60)

    seconds = string.format('%02d', seconds)
    minutes = string.format('%02d', minutes)

    local text = 'T- ' .. minutes .. ':' .. seconds

    return text
end

return clock