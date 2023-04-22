local enums = require 'scripts.interface.enums'

local check = {}

function check.enum(object)
    if not type(object) == 'table' then
        return nil
    end

    local enumType, enumKind

    -- Enum type check

    if not object.__NTFTYPE then
        return nil
    end

    enumType = enums.index.type[object.__NTFTYPE]

    if not enumType then
        return nil
    end

    -- Enum kind check

    if object.__NTFKIND then
        enumKind = enums.index[object.__NTFTYPE][object.__NTFKIND]
    end

    return enumType, enumKind
end

function check.compareType(object, enum)
    local enumType, enumKind = check.enum(object)

    -- Turn enum value to indices
    enum = enums.type[enum]

    -- Basically we're comparing their indices of corresponding type
    return enumType == enum
end

return check