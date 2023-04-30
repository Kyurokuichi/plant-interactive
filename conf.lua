function love.conf(configuration)
    --[[
        The game specifically runs at version 11.3 of LOVE2d
        But you can possibly run in on newer or older version as long as it doesn't get errors or bugs
    --]]
    configuration.version = '11.3'

    configuration.console = true -- For debugging (will disable when release)

    configuration.window.title = 'Project Growth'
    configuration.window.icon = 'assets/icon-game.png'

    configuration.window.width = 144*2
    configuration.window.height = 256*2
    configuration.window.minwidth = configuration.window.width
    configuration.window.minheight = configuration.window.height

    configuration.window.resizable = true
end