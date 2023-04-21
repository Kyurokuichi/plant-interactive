local assets = require('scripts.assets')
local screen = require('scripts.screen')

local sysintf = require('scripts.sysintf')
local ntrRect = require('scripts.interface.elements.ntr-rect')

local special = {
    sequences = {
        {
            pattern = {'up', 'up', 'down', 'down', 'left', 'right', 'left', 'right'},
            activated = false,
            funcActivated = function (self)
                assets.audio.konami:play()
            end,
            funcUpdate = function (self, dt)

            end,
            funcDraw = function (self)
                if assets.audio.konami:isPlaying() then
                    love.graphics.setColor(1, 1, 1, 1)

                    local image = assets.image.nahida
                    love.graphics.draw(image, 0, 0, 0, screen.width/image:getWidth(), screen.height/image:getHeight())

                    -- Random color flicker (epilepsy warning)
                    love.graphics.setColor(
                        math.random(127,255) / 255,
                        math.random(127,255) / 255,
                        math.random(127,255) / 255
                    )

                    -- Ah yes classic impact font
                    love.graphics.setFont(assets.font.impact)

                    local text = 'SIKE THERE\'S NO CHEAT HAHAHA'

                    love.graphics.printf(text, screen.width/2, 13, screen.width, 'center', 0, 0.8 + 0.2 * math.random(), 0.8 + 0.2 * math.random(), screen.width/2, math.ceil(love.graphics.getFont():getWidth(text)/(screen.width))/2)

                    text = 'BOTTOM TEXT'

                    love.graphics.printf(text, screen.width/2, 230, screen.width, 'center', 0, 0.8 + 0.2 * math.random(), 0.8 + 0.2 * math.random(), screen.width/2, math.ceil(love.graphics.getFont():getWidth(text)/(screen.width))/2)

                    love.graphics.setColor(1, 1, 1)
                else
                    self.activated = false
                end
            end
        },

        {
            pattern = {'up', 'up', 'up', 'up', 'down', 'down', 'down', 'down'},
            activated = false,
            funcActivated = function (self)
                assets.video.konami:play()
            end,
            funcUpdate = function (self, dt)

            end,
            funcDraw = function (self)
                if assets.video.konami:isPlaying() then
                    love.graphics.setColor(1, 1, 1, 1)

                    local video = assets.video.konami

                    love.graphics.draw(
                        video,
                        screen.width/2,
                        screen.height/2,
                        0,
                        screen.width/video:getWidth(),
                        screen.height/video:getHeight(),
                        video:getWidth()/2,
                        video:getHeight()/2
                    )
                else
                    self.activated = false
                end
            end
        }
    },

    buttons = {
        up = ntrRect.new(screen.width*1/3, screen.height*0/3, screen.width*1/3, screen.height*1/3),
        left = ntrRect.new(screen.width*0/3, screen.height*1/3, screen.width*1/3, screen.height*1/3),
        down = ntrRect.new(screen.width*1/3, screen.height*2/3, screen.width*1/3, screen.height*1/3),
        right = ntrRect.new(screen.width*2/3, screen.height*1/3, screen.width*1/3, screen.height*1/3)
    },

    lastPress = 0,
    timeLimit = 2,

    pointer = 1
}

-- Secretly bind to main interface heheheheh

sysintf:getGroup(1):connect(special.buttons.up)
sysintf:getGroup(1):connect(special.buttons.down)
sysintf:getGroup(1):connect(special.buttons.left)
sysintf:getGroup(1):connect(special.buttons.right)

if not sysintf:getGroup(1).event:get('update') then
    sysintf:getGroup(1).event:add('update')
end

if not sysintf:getGroup(1).event:get('draw') then
    sysintf:getGroup(1).event:add('draw')
end

if not sysintf:getGroup(1).event:get('mousereleased') then
    sysintf:getGroup(1).event:add('mousereleased')
end

if not sysintf:getGroup(1).event:get('keypressed') then
    sysintf:getGroup(1).event:add('keypressed')
end

sysintf:getGroup(1).event:get('update'):connect(function (dt)
    for _, sequence in ipairs(special.sequences) do
        if sequence.activated then
            local func = sequence.funcUpdate

            if func then
                func(sequence, dt)
            end
        end
    end
end)

sysintf:getGroup(1).event:get('draw'):connect(function ()
    for _, sequence in ipairs(special.sequences) do
        if sequence.activated then
            local func = sequence.funcDraw

            if func then
                func(sequence)
            end
        end
    end

    --[[
    for _, value in pairs(special.buttons) do
        love.graphics.rectangle('fill', value.x, value.y, value.width, value.height)
    end
    --]]
end)

sysintf:getGroup(1).event:get('mousereleased'):connect(function (x, y, button, isTouch, presses)
    local enums = {
        [1] = 'up',
        [2] = 'down',
        [3] = 'left',
        [4] = 'right',
    }

    local key

    for _, value in ipairs(enums) do
        special.buttons[value]:mousereleased(x, y, button, isTouch, presses)

        if special.buttons[value].isClicked then
            key = value
        end
    end

    if key then
        local increment = false

        for _, sequence in ipairs(special.sequences) do
            if key == sequence.pattern[special.pointer] then
                increment = true

                if special.pointer >= #sequence.pattern then
                    sequence.activated = true
                    sequence.funcActivated(sequence)
                    increment = false
                end
            end
        end

        if increment and (love.timer.getTime() - special.lastPress) <= special.timeLimit then
            special.pointer = special.pointer + 1
        else
            special.pointer = 1
        end

        special.lastPress = love.timer.getTime()
    else
        special.pointer = 1
    end
end)

sysintf:getGroup(1).event:get('keypressed'):connect(function (key)
    local increment = false

    for _, sequence in ipairs(special.sequences) do
        if key == sequence.pattern[special.pointer] then
            increment = true

            if special.pointer >= #sequence.pattern then
                sequence.activated = true
                sequence.funcActivated(sequence)
                increment = false
            end
        end
    end

    if increment and (love.timer.getTime() - special.lastPress) <= special.timeLimit then
        special.pointer = special.pointer + 1
    else
        special.pointer = 1
    end

    special.lastPress = love.timer.getTime()
end)
