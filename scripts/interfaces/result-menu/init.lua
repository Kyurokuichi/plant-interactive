local resultMenu = require('scripts.interface.group').new(false, true)

-- General
local assets  = require 'scripts.assets'
local screen = require 'scripts.screen'
local sysntf = require 'scripts.sysntf'
local player = require 'scripts.player'
local enums = require 'scripts.enums'
local musics = require 'scripts.musics'
local color = require 'scripts.color'
local sfx = require 'scripts.sfx'

-- Interface classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect = require 'scripts.interface.elements.ntr-rect'

local window = drwFrame.new(assets.getImage('frameWindow2'), 26, 26, 92, 204)
local title = drwText.new('Einstein TV', 26, 26, 92, 8)

-- Sprite
local TV = {
    antenna = drwImage.new(assets.getImage('tvAntenna'), 39, 1),
    speaker = drwImage.new(assets.getImage('tvSpeaker'), 26, 38),
    screen = drwImage.new(assets.getImage('tvScreen'), 26, 59),
    radio = drwImage.new(assets.getImage('tvRadio'), 44, 175),
    stand = drwImage.new(assets.getImage('tvStand'), 18, 231)
}

-- Buttons
local retxitButton = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 31, 203, 22, 22),
    icon = drwImage.new(assets.getImage('iconRetxit'), 31, 203),
    ntr = ntrRect.new(31, 203, 22, 22)
}
local switchNextMenu = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 95, 203, 18, 22),
    icon = drwImage.new(assets.getImage('iconRightArrow'), 93, 203),
    ntr = ntrRect.new(95, 203, 18, 22)
}
local switchPreviousMenu = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 65, 203, 18, 22),
    icon = drwImage.new(assets.getImage('iconleftArrow'), 63, 203),
    ntr = ntrRect.new(65, 203, 18, 22)
}

local nextButton = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 107, 180, 6, 6),
    icon = drwImage.new(assets.getImage('iconRightArrowSmall'), 107, 180),
    ntr = ntrRect.new(107, 180, 6, 6)
}

local previousButton = {
    frame = drwFrame.new(assets.getImage('frameButton7'), 31, 180, 6, 6),
    icon = drwImage.new(assets.getImage('iconleftArrowSmall'), 31, 180),
    ntr = ntrRect.new(31, 180, 6, 6)
}

-- Sub groups
local retxitMenu = require 'scripts.interfaces.result-menu.retxit-menu'

local topInfo = {
    title = drwText.new('Top pot', 36, 69, 72, 8, 'center'),
    name = drwText.new(nil, 36, 81, 72, 8, 'center'),
    height = drwText.new(nil, 36, 97, 72, 8, 'center')
}

local leaderboardInfo = {
    title = drwText.new('Leaderboard', 36, 69, 72, 8, 'center'),
    rank = {}
}

local graphInfo = {
    title = drwText.new('Graph O\' Pots', 36, 69, 72, 8, 'center'),
    name = drwText.new(nil, 36, 80, 72, 8, 'center'),
    indicator = drwImage.new(assets.getImage('graph'), 35, 90),
    graph = love.graphics.newCanvas(69, 45),
    yText = drwText.new(nil, 40, 90, 32, 8, 'left'),
    info = drwTextScroll.new(nil, 36, 141, 72, 8, 1, 1, true),
    page = drwText.new(nil, 36, 150, 72, 8)
}

resultMenu:connect(window)
resultMenu:connect(title)

resultMenu:connect(TV)

resultMenu:connect(switchNextMenu)
resultMenu:connect(switchPreviousMenu)
resultMenu:connect(retxitButton)

resultMenu:connect(nextButton)
resultMenu:connect(previousButton)

resultMenu:connect(retxitMenu)

local isOpened = false

local potRank = {}

local function drawTopInfo()
    topInfo.title:draw()
    topInfo.name:draw()
    topInfo.height:draw()
end

local function updateLeaderboardInfo(dt)
    for index, text in ipairs(leaderboardInfo.rank) do
        text:update(dt)
    end
end

local function drawLeaderboardInfo()
    leaderboardInfo.title:draw()

    for index, text in ipairs(leaderboardInfo.rank) do
        text:draw()
    end
end

local selectedGraphIndex = 1
local graphInfoUpdated = false

local function changeGraphInfo()
    local pot = player.getPot(selectedGraphIndex)

    local name, health, waterLevel = pot:getInfo()
    local height = math.floor(pot.plant:getHeight())

    graphInfo.page.text = 'Page ' .. selectedGraphIndex .. ' of ' .. #player.pots
    graphInfo.name.text = name
    graphInfo.info:setText('Health: ' .. health .. ', Water Lvl: ' .. waterLevel .. ', Height: ' .. height .. 'px')

    graphInfo.yText.text = height .. 'px'

    love.graphics.setCanvas(graphInfo.graph)

    love.graphics.clear()

    local dataHeight = pot.plant.dataHeight

    love.graphics.setColor(1, 1, 1)

    for index, data in ipairs(dataHeight) do
        data = math.floor(data)

        local barX = graphInfo.graph:getWidth() * (index / (#dataHeight+1))
        local barWidth = math.abs(barX -graphInfo.graph:getWidth() * ((index+1) / (#dataHeight+1)) )
        local barHeight = graphInfo.graph:getHeight() * (data / height)

        local barY = graphInfo.graph:getHeight() - barHeight

        love.graphics.rectangle('fill', barX, barY, barWidth, barHeight)
    end

    love.graphics.setCanvas(nil)
end

local function changePageGraphInfo(next)
    if not next then
        selectedGraphIndex = (selectedGraphIndex-1-1) % #player.pots + 1
    else
        selectedGraphIndex = (selectedGraphIndex-1+1) % #player.pots + 1
    end

    graphInfoUpdated = false
end

local function updateGraphInfo(dt)
    if not graphInfoUpdated then
        graphInfoUpdated = true
        changeGraphInfo()
    end

    if nextButton.ntr.isClicked then
        changePageGraphInfo(true)
    elseif previousButton.ntr.isClicked then
        changePageGraphInfo(false)
    end

    if switchNextMenu.ntr.isClicked or switchPreviousMenu.ntr.isClicked then
        selectedGraphIndex = 1
    end

    graphInfo.info:update(dt)
end

local function drawGraphInfo()
    graphInfo.indicator:draw()
    love.graphics.draw(graphInfo.graph, 40, 90) -- graph

    graphInfo.title:draw()
    graphInfo.yText:draw()
    graphInfo.name:draw()
    graphInfo.info:draw()
    graphInfo.page:draw()
end

local info = {
    {
        update = nil,
        draw = drawTopInfo
    },
    {
        update = updateLeaderboardInfo,
        draw = drawLeaderboardInfo
    },
    {
        update = updateGraphInfo,
        draw = drawGraphInfo
    }
}
local infoIndex = 1

local function changeInfoIndex(next)
    if not next then
        infoIndex = (infoIndex-1-1) % #info + 1
    else
        infoIndex = (infoIndex-1+1) % #info + 1
    end
end

local function updateInfo(dt)
    local update = info[infoIndex].update

    if update then
        update(dt)
    end
end

local function drawInfo()
    local draw = info[infoIndex].draw

    if draw then
        draw()
    end
end

local function rankPot()
    for index, pot in ipairs(player.pots) do
        potRank[index] = index
    end

    table.sort(potRank, function (a, b)
        local potA = player.getPot(a)
        local potB = player.getPot(b)

        --print(potA.plant:getHeight(), potB.plant:getHeight(), potA.plant:getHeight() > potB.plant:getHeight())

        return potA.plant:getHeight() > potB.plant:getHeight()
    end)

    topInfo.name.text = player.getPot(potRank[1]).name
    topInfo.height.text = 'Height: ' .. math.floor(player.getPot(potRank[1]).plant.height)

    --for index, value in ipairs(player.getPot(potRank[1]).plant.dataHeight) do
        --print(index, value, 'data')
    --end

    local ox = 36
    local oy = 82

    for index, no in ipairs(potRank) do
        local pot = player.getPot(no)
        --print(index, no, pot.plant.height)

        local x = ox
        local y = oy + 12 * (index-1)

        leaderboardInfo.rank[#leaderboardInfo.rank+1] = drwTextScroll.new(
            '#' .. index .. ' "' .. pot.name .. '" ; Height: ' .. math.floor(pot.plant:getHeight()),
            x,
            y,
            72,
            8,
            1,
            1,
            true
        )
    end
end

-- Events
resultMenu.event:add('update', function (dt)
    if not isOpened then
        rankPot()
        isOpened = true
    end

    if not retxitMenu.isLocked then
        return
    end

    if retxitButton.ntr.isClicked then
        retxitMenu:toggle()
        sfx.play('click')
    end

    if switchNextMenu.ntr.isClicked then
        changeInfoIndex(true)
        sfx.play('click')
    elseif switchPreviousMenu.ntr.isClicked then
        changeInfoIndex(false)
        sfx.play('click')
    end

    updateInfo(dt)

    if nextButton.ntr.isClicked then
        sfx.play('click')
    end

    if previousButton.ntr.isClicked then
        sfx.play('click')
    end
end)

resultMenu.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(assets.getFont('small'))

    window:draw()
    title:draw()

    TV.antenna:draw()
    TV.speaker:draw()
    TV.screen:draw()
    TV.radio:draw()
    TV.stand:draw()

    drawInfo()

    color.conditionRGB(switchNextMenu.ntr.isHoldingClick and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    switchNextMenu.frame:draw()
    switchNextMenu.icon:draw()

    color.conditionRGB(switchPreviousMenu.ntr.isHoldingClick and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    switchPreviousMenu.frame:draw()
    switchPreviousMenu.icon:draw()

    color.conditionRGB(retxitButton.ntr.isHoldingClick and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    retxitButton.frame:draw()
    retxitButton.icon:draw()

    color.conditionRGB(nextButton.ntr.isHoldingClick and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    nextButton.frame:draw()
    nextButton.icon:draw()

    color.conditionRGB(previousButton.ntr.isHoldingClick and retxitMenu.isLocked, 0.5, 0.5, 0.5, 1, 1, 1, true)
    previousButton.frame:draw()
    previousButton.icon:draw()

    love.graphics.setColor(1, 1, 1, 1)
end)

return resultMenu