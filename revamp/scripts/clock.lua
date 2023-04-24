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

    local seconds = self.time % 60
    local minutes = math.floor(self.time / 60)

    seconds = tostring(seconds)
    seconds = seconds:format('%02x', seconds)

    minutes = tostring(minutes)
    minutes = minutes:format('%02x', minutes)

    local text = 'T- ' .. minutes .. ':' .. seconds

    return text
end

return clock