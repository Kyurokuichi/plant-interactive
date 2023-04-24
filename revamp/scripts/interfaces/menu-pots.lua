-- Modules
local assets = require 'scripts.assets'
local color = require 'scripts.interface.color'

local sysntf = require 'scripts.sysntf'
local enums  = require 'scripts.enums'
local player = require 'scripts.player'

-- Classes
local drwImage      = require 'scripts.interface.elements.drw-image'
local drwFrame      = require 'scripts.interface.elements.drw-frame'
local drwText       = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect       = require 'scripts.interface.elements.ntr-rect'

local menuPots = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.image.frameWindow1, 26, 26, 92, 204)
local overlay = drwImage.new(assets.image.overlayHealthy, -2, -2)
local title = drwText.new('Pots Selection', 26, 26, 92, 8)
menuPots:connect(window)
menuPots:connect(overlay)
menuPots:connect(title)

local backButton = {
    frame = drwFrame.new(assets.image.frameButton3, 35, 203, 38, 22),
    icon  = drwImage.new(assets.image.iconBack, 43, 203),
    ntr   = ntrRect.new(35, 203, 38, 22)
}
local addButton = {
    frame = drwFrame.new(assets.image.frameButton4, 0, 0, 82, 14),
    icon  = drwImage.new(assets.image.iconAdd, 0, 0),
    ntr   = ntrRect.new(0, 0, 82, 14)
}
local removeButton = {
    frame = drwFrame.new(assets.image.frameButton3, 87, 203, 22, 22),
    icon  = drwImage.new(assets.image.iconRemove, 87, 203),
    ntr   = ntrRect.new(87, 203, 22, 22)
}
local cancelButton = {
    frame = drwFrame.new(assets.image.frameButton3, 53, 203, 38, 22),
    icon  = drwImage.new(assets.image.iconClose, 61, 203),
    ntr   = ntrRect.new(53, 203, 38, 22)
}
cancelButton.frame.isVisible = false
cancelButton.icon.isVisible = false
cancelButton.ntr.isLocked = true

menuPots:connect(backButton)
menuPots:connect(addButton)
menuPots:connect(removeButton)
menuPots:connect(cancelButton)

local currentPhase = nil
local isOpened = false

local function phaseSet()
    if currentPhase ~= player.phase then
        if player.phase == enums.index.phase.pre then
            addButton.frame.isVisible = true
            addButton.icon.isVisible = true
            addButton.ntr.isLocked = false

            removeButton.frame.isVisible = true
            removeButton.icon.isVisible = true
            removeButton.ntr.isLocked = false

            backButton.frame.x = 35
            backButton.frame.y = 203
            backButton.frame.width = 38
            backButton.frame.height = 22

            backButton.icon.x = 43
            backButton.icon.y = 203

            backButton.ntr.x = 35
            backButton.ntr.y = 203
            backButton.ntr.width = 38
            backButton.ntr.height = 22

        elseif player.phase == enums.index.phase.peri then
            addButton.frame.isVisible = false
            addButton.icon.isVisible = false
            addButton.ntr.isLocked = true

            removeButton.frame.isVisible = false
            removeButton.icon.isVisible = false
            removeButton.ntr.isLocked = true

            backButton.frame.x = 53
            backButton.frame.y = 203
            backButton.frame.width = 38
            backButton.frame.height = 22

            backButton.icon.x = 61
            backButton.icon.y = 203

            backButton.ntr.x = 53
            backButton.ntr.y = 203
            backButton.ntr.width = 38
            backButton.ntr.height = 22
        end

        currentPhase = player.phase
    end
end

local list = {}
local listActive = 6

for index = 1, 6 do
    local x = 31
    local y = 44 + 26 * (index - 1)

    list[index] = {
        isActive = false,
        frame = drwFrame.new(assets.image.frameButton1, x, y, 82, 14),
        icon  = drwImage.new(assets.image.iconPot, x, y),
        name  = drwText.new(nil, x+18, y-1, 63, 8),
        info  = drwTextScroll.new(nil, x+18, y+7, 63, 8, 1, 1, true),
        ntr   = ntrRect.new(x, y, 82, 14)
    }

    list[index].name:setAlign('left')

    menuPots:connect(list[index])
end

local function setElementActive(element, bool)
    element.isActive = bool
    element.frame.isVisible = bool
    element.icon.isVisible  = bool
    element.name.isVisible  = bool
    element.info.isVisible  = bool
    element.ntr.isLocked    = not bool
end

local function enableRemoveMode(bool)
    backButton.frame.isVisible = not bool
    backButton.icon.isVisible = not bool
    backButton.ntr.isLocked = bool

    addButton.frame.isVisible = not bool
    addButton.icon.isVisible = not bool
    addButton.ntr.isLocked = bool

    removeButton.frame.isVisible = not bool
    removeButton.icon.isVisible = not bool
    removeButton.ntr.isLocked = bool

    cancelButton.frame.isVisible = bool
    cancelButton.icon.isVisible = bool
    cancelButton.ntr.isLocked = not bool
end

local function enableAddButton(bool)
    addButton.frame.isVisible = bool
    addButton.ntr.isLocked = not bool
end

local function rePositionAddButton()
    local x = 31
    local y = 44 + 26 * #player.pots

    addButton.frame.x = x
    addButton.frame.y = y
    addButton.icon.x = x + 34
    addButton.icon.y = y
    addButton.ntr.x = x
    addButton.ntr.y = y
end

local function reIndexList()
    local count = 0

    for index, element in ipairs(list) do
        local pot = player:getPot(index)

        if pot ~= nil then
            count = count + 1

            local name, health, waterLvl = pot:getInfo()

            element.name.text = name
            element.info:setText('Status: ' .. health .. ' Water Lvl: ' .. waterLvl)

            element.info.lerp.time = 0

            setElementActive(element, true)
        else
            setElementActive(element, false)
        end
    end

    if #player.pots < 6 then
        enableAddButton(true)
        rePositionAddButton()
    else
        enableAddButton(false)
    end

    listActive = count
end

local function returnMain()
    sysntf:getGroup(1):toggleLockOnly()
    menuPots:toggle()
    isOpened = false
end

local function updateList()
    for index, element in ipairs(list) do
        if element.isActive then
            if element.ntr.isClicked then

                if cancelButton.ntr.isLocked then
                    player.selected.potIndex = index
                    returnMain()
                else
                    table.remove(player.pots, index)
                end
            end
        end
    end
end

local function drawList()
    for index, element in ipairs(list) do
        if element.isActive then
            color.conditionRGB(element.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
            element.frame:draw()

            color.conditionRGB(player.selected.potIndex == index, 0.5, 0.5, 0.5, 1, 1, 1, true)
            element.icon:draw()
            element.name:draw()
            element.info:draw()
        end
    end
end

menuPots.event:add('update', function (dt)
    phaseSet()
    --print(#menuPots.contents)

    if backButton.ntr.isClicked then
        returnMain()
    end

    if removeButton.ntr.isClicked then
        enableRemoveMode(true)
    elseif cancelButton.ntr.isClicked then
        enableRemoveMode(false)
    end

    if listActive ~= #player.pots or not isOpened then
        reIndexList()

        if not isOpened then
            isOpened = true
        end
    end

    if addButton.ntr.isClicked then
        player:addPot()
    end

    updateList()
end)

menuPots.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(assets.font.small)

    window:draw()
    overlay:draw()

    color.RGB(60, 163, 112, true)
    title:draw()

    color.conditionRGB(backButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    backButton.frame:draw()
    backButton.icon:draw()

    color.conditionRGB(removeButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    removeButton.frame:draw()
    removeButton.icon:draw()

    color.conditionRGB(addButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    addButton.frame:draw()
    addButton.icon:draw()

    color.conditionRGB(cancelButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    cancelButton.frame:draw()
    cancelButton.icon:draw()

    drawList()

    love.graphics.setColor(1, 1, 1)
end)

return menuPots