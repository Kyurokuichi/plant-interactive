local state = {
    previous = nil,
    awaiting = nil,
    current = nil,

    modules = {},
}

function state.getState(name)
    return state.modules[name]
end

function state.getCurrent()
    return state.modules[state.current]
end

function state.getCurrentName()
    return state.current
end

function state.switchTo(stateName)
    state.awaiting = stateName
end

function state.revert()
    state.awaiting = state.previous
end

function state.call(callback, ...)
    local current = state.getCurrent()

    if current[callback] ~= nil then
        current[callback](...)
    end
end

-- This MUST be called at the end of love.draw()
function state.rectify()
    if not state.awaiting then
        return
    end
                                    -- Yonichi's Haiku
    state.previous = state.current  -- Put present to past
    state.current = state.awaiting  -- Awaiting to current
    state.awaiting = nil            -- Awaiting to none

    state.call('load')
end

function state.addState(name, table)
    state.modules[name] = table
end

function state.initialize(states, initialState)
    for key, module in pairs(states) do
        state.addState(key, module)
    end

    state.switchTo(initialState)
    state.rectify() -- force rectify state
end

return state