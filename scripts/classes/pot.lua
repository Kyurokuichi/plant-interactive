local pot = {}

function pot.new()
    local newObject = {}

    return setmetatable(newObject, pot)
end

return pot