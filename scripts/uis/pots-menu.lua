local assets    = require('scripts.assets')
local sysintf   = require('scripts.sysintf')

local player    = require('scripts.player')

local color     = require('scripts.interface.color')

local drwImage  = require('scripts.interface.elements.drw-image')
local drwFrame  = require('scripts.interface.elements.drw-frame')
local drwText   = require('scripts.interface.elements.drw-text')
local drwTextScroll = require('scripts.interface.elements.drw-textscroll')
local ntrRect   = require('scripts.interface.elements.ntr-rect')

local potsMenu = require('scripts.interface.group').new(false, true)

local window    = drwFrame.new(assets.image.frameWindow, 26, 26, 92, 204)
potsMenu:connect(window)

local title     = drwText.new('Pots selection', 26, 26, 92, 8)
potsMenu:connect(title)

local backButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 35, 203, 38, 22),
    icon    = drwImage.new(assets.image.iconBack, 46, 205),
    ntr     = ntrRect.new(35, 203, 38, 22)
}
potsMenu:connect(backButton.frame)
potsMenu:connect(backButton.icon)
potsMenu:connect(backButton.ntr)

local removeButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 87, 203, 22, 22),
    icon    = drwImage.new(assets.image.iconRemove, 87, 203),
    ntr     = ntrRect.new(87, 203, 22, 22)
}
potsMenu:connect(removeButton.frame)
potsMenu:connect(removeButton.icon)
potsMenu:connect(removeButton.ntr)

local list = {}

local addButton = {
    frame = drwFrame.new(assets.image.frameButton3, 31, 0, 82, 14),
    icon  = drwImage.new(assets.image.iconAdd, 65, 0),
    ntr   = ntrRect.new(31, 0, 82, 14)
}
potsMenu:connect(addButton.frame)
potsMenu:connect(addButton.icon)
potsMenu:connect(addButton.ntr)

local cancelButton = {
    frame = drwFrame.new(assets.image.frameButton2, 53, 203, 38, 22),
    icon  = drwImage.new(assets.image.iconClose, 63, 205),
    ntr   = ntrRect.new(53, 203, 38, 22)
}
cancelButton.frame.isVisible = false
cancelButton.icon.isVisible = false
cancelButton.ntr.isLocked = true

potsMenu:connect(cancelButton.frame)
potsMenu:connect(cancelButton.icon)
potsMenu:connect(cancelButton.ntr)

potsMenu.event:add('update', function (dt)
    if backButton.ntr.isClicked then
        sysintf:getGroup(1).isLocked = false

        potsMenu.isLocked = true
        potsMenu.isVisible = false
    end

    if addButton.ntr.isClicked then
        player:addPot()

        if #player.pots == 6 then
            addButton.frame.isVisible = false
            addButton.icon.isVisible = false
            addButton.ntr.isLocked = true
        end
    end

    if removeButton.ntr.isClicked then
        addButton.frame.isVisible = false
        addButton.icon.isVisible = false
        addButton.ntr.isLocked = true

        removeButton.frame.isVisible = false
        removeButton.icon.isVisible = false
        removeButton.ntr.isLocked = true

        backButton.frame.isVisible = false
        backButton.icon.isVisible = false
        backButton.ntr.isLocked = true

        cancelButton.frame.isVisible = true
        cancelButton.icon.isVisible = true
        cancelButton.ntr.isLocked = false
    elseif cancelButton.ntr.isClicked then
        if #player.pots < 6 then
            addButton.frame.isVisible = true
            addButton.icon.isVisible = true
            addButton.ntr.isLocked = false
        end

        cancelButton.frame.isVisible = false
        cancelButton.icon.isVisible = false
        cancelButton.ntr.isLocked = true

        removeButton.frame.isVisible = true
        removeButton.icon.isVisible = true
        removeButton.ntr.isLocked = false

        backButton.frame.isVisible = true
        backButton.icon.isVisible = true
        backButton.ntr.isLocked = false
    end

    if #list ~= #player.pots then
        if #list > 0 then
            for index = #list, 1, -1 do
                local t = list[index]

                potsMenu:remove(t.frame)
                potsMenu:remove(t.icon)
                potsMenu:remove(t.name)
                potsMenu:remove(t.info)
                potsMenu:remove(t.ntr)

                t.frame  = nil
                t.icon   = nil
                t.name   = nil
                t.info   = nil
                t.ntr    = nil

                table.remove(list, index)
            end
        end

        for index, pot in ipairs(player.pots) do
            local x = 31
            local y = 44 + 26 * (index - 1)

            local name, health, waterLevel = pot:getInfo()

            list[index] = {
                frame  = drwFrame.new(assets.image.frameButton1, x, y, 82, 14),
                icon   = drwImage.new(assets.image.iconPot, x+1, y+1),
                name   = drwText.new(name, x+18, y-1, 63, 8),
                info   = drwTextScroll.new(health, x+18, y+7, 63, 8, 0.5, 0.5, true),
                ntr    = ntrRect.new(x, y, 82, 14)
            }

            list[index].name:setAlign('left')
            --list[index].health:setAlign('left')

            potsMenu:connect(list[index].frame)
            potsMenu:connect(list[index].icon)
            potsMenu:connect(list[index].name)
            potsMenu:connect(list[index].info)
            potsMenu:connect(list[index].ntr)
        end

        local index = #player.pots+1
        local y = 44 + 26 * (index - 1)

        addButton.frame.y = y
        addButton.icon.y  = y
        addButton.ntr.y   = y
    end

    local deletePotIndex

    for index, pot in ipairs(list) do
        local name, health, waterLevel = player:getPot(index):getInfo()

        local ui = list[index]

        ui.info.text = (health .. ', Water Lvl:' .. waterLevel)

        if ui.ntr.isClicked then
            if not cancelButton.ntr.isLocked then
                if #player.pots > 1 then
                    print('There should be confirmation before deleting')
                    deletePotIndex = index
                else
                    print('You can\'t delete pot (Prevent deleting the first index of pot)')
                end
            else
                player.selected.potIndex = index

                sysintf:getGroup(1).isLocked = false

                potsMenu.isLocked = true
                potsMenu.isVisible = false

                break
            end
        end
    end

    if deletePotIndex then
        table.remove(player.pots, deletePotIndex)
    end
end)

potsMenu.event:add('draw', function ()
    window:draw()

    love.graphics.setFont(assets.font.small)
    love.graphics.setColor(color.rgb(60, 163, 112))
    title:draw()

    color.condition(backButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    backButton.frame:draw()
    backButton.icon:draw()

    color.condition(removeButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    removeButton.frame:draw()
    removeButton.icon:draw()

    love.graphics.setColor(1, 1, 1)

    for _, ui in ipairs(list) do
        color.condition(ui.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
        ui.frame:draw()
        ui.icon:draw()
        ui.name:draw()
        ui.info:draw()
    end

    

    color.condition(addButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    addButton.frame:draw()
    addButton.icon:draw()

    color.condition(cancelButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    cancelButton.frame:draw()
    cancelButton.icon:draw()

    love.graphics.setColor(1, 1, 1)
end)

return potsMenu