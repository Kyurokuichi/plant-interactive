--[[
--  Interface group class
--  Like tables, group contains interface elements (drawables, interactables), and another group
--]]


local event = require('scripts.interface.event')    -- Event class
local check = require('scripts.interface.check')    -- For checking enums of an interface object type and its kind
local enums = require('scripts.interface.enums')    -- Enums of interface type and kinds 

local group = {}
group.__index = group

-- Creates group object
function group.new(isVisible, isLocked)
    local newObject = {
        offsetX = 0,
        offsetY = 0,
        isVisible = isVisible == nil and true or isVisible,
        isLocked = isLocked == nil and false or isLocked,
        contents = {},
        event = event.new(),

        __INTFTYPE = enums.type.group,
        __INTFKIND = nil,
    }

    return setmetatable(newObject, group)
end

-- Connects an element/group to the group
function group:connect(element)
    -- Type check
    local enumType, enumKind = check(element)

    local isElement = enumType == enums.type[3] and (enumKind == enums.element[1] or enumKind == enums.element[2])
    local isGroup   = enumType == enums.type[2]

    if not (isElement or isGroup) then
        error('No value passed or wrong kind of element')
    end

    element.group = self

    self.contents[#self.contents+1] = element
end

function group:remove(element)
    if type(element) == 'table' then
        for index, value in ipairs(self.contents) do
            -- Table reference matching
            if element == value then
                element = index
            end
        end
    end

    table.remove(self.contents, element)
end

-- Emits specified callback to contents and group itself
function group:emit(name, ...)
    -- For drawables
    if name == 'draw' then
        -- Return if the group visibility is disabled
        if not self.isVisible then return end

        love.graphics.push()
        love.graphics.translate(self.offsetX, self.offsetY)
        -- Foremost group draws first
        self.event:emit(name, ...)
        love.graphics.pop()

        -- Then rest of the groups inside foremost group's content draws
        for _, member in ipairs(self.contents) do
            local enumType, _ = check(member)
            if enumType == enums.type.group then
                member:emit(name, ...)
            end
        end

    -- For interactables
    else
        -- Return if the group is locked but don't return when the callback name is 'reset'
        if self.isLocked and name ~= 'reset' then return end

        self.event:emit(name, ...)

        -- Emit a signal for specific event callback
        for _, member in ipairs(self.contents) do
            local enumType, enumKind = check(member)
            -- If member is an element and an interactable
            if enumType == enums.type[3] and enumKind == enums.element[2] then
                local callback = member[name]

                if callback then
                    callback(member, ...)
                end
            -- IF member is a group
            elseif enumType == enums.type[2] then
                member:emit(name, ...)
            end
        end
    end
end

-- Translates positions of drawables inside contents using specified offsets
function group:setOffset(x, y)
    self.offsetX = x
    self.offsetY = y
end

return group