-- Event handler for group object

local signal = require('scripts.interface.signal')

local event = {}
event.__index = event
-- Creates new event object
function event.new(...)
    local newObject = {callbacks = {}}
    setmetatable(newObject, event)

    local args = {...}

    -- Format : {name, function, function, function...}
    if args > 0 then
        for _, callback in ipairs(args) do
            if #callback then
                local funcs = {}

                for index = 2, #args do
                    funcs[#funcs+1] = callback[index]
                end

                newObject:add(callback[1], table.unpack(funcs))
            else
                newObject:add(callback[1])
            end
        end
    end

    return newObject
end
-- Emit specified event callback
function event:emit(name, ...)
    self.callbacks[name]:emit(...)
end
-- Get the specified event callback
function event:get(name)
    return self.callbacks[name]
end
-- Add event callback with optional list of functions
function event:add(name, ...)
    if self.callbacks[name] then
        print('Event ' .. ' already exists')
        return
    end

    self.callbacks[name] = signal.new()

    local args = {...}

    if #args > 0 then
        for index, func in ipairs(args) do
            self.callbacks[name]:connect(func)
        end
    end
end
-- Remove event callback
function event:remove(name)
    if not self.callbacks[name] then
        print('Event ' .. ' already doesn\'t exist')
    end

    self.callbacks[name] = nil
end
-- Remove all event callbacks
function event:removeAll()
    for name, callback in pairs(self.callbacks) do
        callback = nil
    end
end

return event