

return function (x, y, type)
    local bare = {
        x = x,
        y = y,
        group = nil,
        isVisible = false,
        __INTFTYPE = 1,
        __OBJTYPE = type,
    }

    function bare:setVisibility(bool)
        self.isVisible = bool
    end

    function bare:setGroup()
        
    end

    function bare:getGroup()
        return self.group
    end

    return bare
end