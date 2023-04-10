local event = require('scripts.interface.event')

local group = {}
group.__index = group

function group.new(isVisible, isLocked)
    local newObject = {
        isVisible = isVisible == nil and true or isVisible,
        isLocked = isLocked == nil and false or isLocked,
        contents = {}
    }

    return setmetatable(newObject, group)
end

return group