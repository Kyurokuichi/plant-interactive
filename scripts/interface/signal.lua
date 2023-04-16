-- Lua implementation of Qt signal and slot under 41 (Yonichi) lines of codes
local signal = {}
signal.__index = signal
-- Creates new signal object
function signal.new()
    local newObject = {slots = {}}
    return setmetatable(newObject, signal)
end
-- Emit signal
function signal:emit(...)
    for _, slot in ipairs(self.slots) do
        slot(...)
    end
end
-- Connect function to signal
function signal:connect(func)
    assert(type(func) == 'function', 'Not a function')
    self.slots[#self.slots+1] = func
end
-- Remove function from signal
function signal:remove(x)
    if type(x) == 'function' then
        for index, slot in ipairs(self.slot) do
            if x == slot then
                x = index; break
            end
        end
    elseif not type(x) == 'number' then
        error('wrong input', 1)
    end

    table.remove(self.slot, x)
end
-- Remove all functions from signal
function signal:removeAll()
    for index = #self.slots, 1, -1 do
        table.remove(self.slots, index)
    end
end

return signal