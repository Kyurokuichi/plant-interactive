local assets = {}

-- Run only once function
-- NOTE: this function commits suicide when execute (pun joke)
function assets.initialize()
    assets.initialize = nil
end

return assets