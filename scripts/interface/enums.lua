local enums = {
    -- interface hierarchy highest to lowest
    type = {
        [1] = 'system',
        [2] = 'group',
        [3] = 'element',
        [4] = 'event',
        [5] = 'signal',
    },

    element = {
        [1] = 'drawables',
        [2] = 'interactables'
    },

    signal = {
        [1] = 'slot'
    },

    drwFrame = {
        quad = {
            [1] = 'top-left',
            [2] = 'top',
            [3] = 'top-right',
            [4] = 'left',
            [5] = 'center',
            [6] = 'right',
            [7] = 'bottom-left',
            [8] = 'bottom',
            [9] = 'bottom-right'
        }
    }
}

-- Turn index into keys by swapping the value
for _, enum in ipairs(enums) do
    if type(enum) == 'table' then
        for index, value in ipairs(enum) do
            enum[value] = index
        end
    end
end

return enums