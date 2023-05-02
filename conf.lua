function love.conf(configuration)
    -- The game specifically runs at version 11.3 of LOVE2d
    -- But you can possibly run in on newer or older version as long as it doesn't get errors or bugs
    configuration.version = '11.3'

    configuration.window.title = 'Project Growth'
    configuration.window.icon = 'assets/icon-game.png'

    -- Uncomment when development
    --[[
        configuration.console = true -- For debugging (will disable when release)
        configuration.window.width = 144*2
        configuration.window.height = 256*2
    --]]

    -- Uncomment when release (and also remove development code part)
    ---[[

    -- Swaps the resolution dimension from "width x height" to "height x width" in order to make the game in portrait mode
    configuration.window.width, configuration.window.height = configuration.window.height, configuration.window.width

    ---]]

    configuration.window.minwidth = configuration.window.width
    configuration.window.minheight = configuration.window.height
    configuration.window.resizable = true
end