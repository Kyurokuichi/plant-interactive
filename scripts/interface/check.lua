local enums = require('scripts.interface.enums')

-- Returns two values: name of the type and kind
local function checkEnum(object)
    if not type(object) == 'table' then return nil end  -- Variable type check

    local enumType, enumKind

    -- Enum type check
    if not object.__INTFTYPE then return nil end        -- Check if interface type on that object exists

    enumType = enums.type[object.__INTFTYPE]
    if not enumType then return nil end                 -- Check if that interface type value exists on enums type table

    if object.__INTFKIND and enums[enumType] then       -- Check if an object have interface kind of type and if it exists on enums
        enumKind = enums[object.__INTFKIND]
    end

    return enumType, enumKind
end

return checkEnum