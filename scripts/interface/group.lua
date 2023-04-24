--[[
--  Interface group class
--  Like tables, group contains interface elements (drawables, interactables), and another group
--]]

local event = require('scripts.interface.event')    -- Event class
local check = require('scripts.interface.check')    -- For checking enums of an interface object type and its kind
local enums = require('scripts.interface.enums')    -- Enums of interface type and kinds 

local group = {}
group.__index = group

function group.new(isVisible, isLocked)
    local newObject = {
        offsetX = 0,
        offsetY = 0,
        isVisible = isVisible == nil and true or isVisible,
        isLocked = isLocked == nil and false or isLocked,
        contents = {},
        event = event.new(),

        __NTFTYPE = enums.key.type[enums.index.type.group],
        __NTFKIND = nil,
    }

    return setmetatable(newObject, group)
end

-- Connects an element/group to the group
function group:connect(value)
    -- Type check
    local enumType, _ = check.enum(value)

    local function add(element)
        -- Type check
        local enumType, _ = check.enum(element)

        local isElement = enumType == enums.index.type.element
        local isGroup   = enumType == enums.index.type.group

        if (isElement or isGroup) then
             -- Add table reference to element or group
            element.group = self

            self.contents[#self.contents+1] = element
        else
            print('Warning on group:connect() : No value passed or wrong kind of element')
        end
    end

    if enumType then
        add(value)
    else
        if type(value) == 'table' then
            -- Find possible elements on indices and keys
            for _, element in ipairs(value) do
                add(element)
            end

            for key, element in pairs(value) do
                if type(key) == 'string' then
                    add(element)
                end
            end
        end
    end
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
            local enumType, _ = check.enum(member)
            if enumType == enums.index.type.group then
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
            local enumType, enumKind = check.enum(member)
            -- If member is an element and an interactable
            if enumType == enums.index.type.element then

                if enumKind == enums.index.element.interactable or name == 'update' then
                    local callback = member[name]

                    if callback then
                        callback(member, ...)
                    end
                end

            -- If member is a group
            elseif enumType == enums.index.type.group then
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

function group:toggleLockOnly()
    self.isLocked = not self.isLocked
end

function group:toggle()
    self.isVisible = not self.isVisible
    self.isLocked = not self.isLocked
end

return group