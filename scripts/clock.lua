local clock = {
    time = 0
}

function clock:setup(duration)
    self.time = duration
end

function clock:update(dt)
    self.time = self.time - dt
end

function clock:tellTime()
    local time = self.time

    local seconds = math.floor(self.time % 60)
    local minutes = math.floor(self.time / 60)

    seconds = string.format('%02d', seconds)
    minutes = string.format('%02d', minutes)

    local text = 'T- ' .. minutes .. ':' .. seconds

    return text
end

return clock