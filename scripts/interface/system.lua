--[[
--  Interface system class
--  This handles groups and elements altogether so it's easy to update and draw groups and elements
--]]

local check = require('scripts.interface.check')
local enums = require('scripts.interface.enums')
local event = require('scripts.interface.event')

local system = {}
system.__index = system

function system.new()
    local newObject = {
        groups = {},
        event = event.new(),

        __INTFTYPE = enums.type.system,
        __INTFKIND = nil
    }

    return setmetatable(newObject, system)
end

function system:emit(name, ...)
    for index, group in ipairs(self.groups) do
        group:emit(name, ...)
    end
end

-- Shorthand function
function system:reset()
    self:emit('reset')
end

function system:connect(group)
    local enumType, enumKind = check(group)

    assert(enumType == enums.type[enums.type.group], 'No value passed / Not a group type')

    self.groups[#self.groups+1] = group
end

function system:remove(value)
    if type(value) == 'table' then
        for index, group in ipairs(self.groups) do
            -- Reference matching
            if value == group then
                value = index
                break
            end
        end
    else
        assert(type(value) ~= 'number', 'No value passed / Not a number or table')
    end

    table.remove(self.groups[value])
end

function system:invisibleAll(except)
    for _, group in ipairs(self.groups) do
        if not (except == group) then
            group.isVisible = false
        end
    end
end

function system:lockAll(except)
    for _, group in ipairs(self.groups) do
        if not (except == group) then
            group.isLocked = true
        end
    end
end

function system:swap(a, b)
    self.groups[a], self.groups[b] = self.groups[b], self.groups[a]
end

return system