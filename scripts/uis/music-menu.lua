local assets    = require('scripts.assets')
local sysintf   = require('scripts.sysintf')
local enums     = require('scripts.enums')
local player    = require('scripts.player')

local musics    = require('scripts.musics')

local color     = require('scripts.interface.color')

local drwImage  = require('scripts.interface.elements.drw-image')
local drwFrame  = require('scripts.interface.elements.drw-frame')
local drwText   = require('scripts.interface.elements.drw-text')
local drwTextScroll = require('scripts.interface.elements.drw-textscroll')
local ntrRect   = require('scripts.interface.elements.ntr-rect')

local window    = drwFrame.new(assets.image.frameWindow, 26, 26, 92, 204)

local musicMenu = require('scripts.interface.group').new(false, true)

local title     = drwText.new('Music selection', 26, 26, 92, 8)
musicMenu:connect(title)

local genre = {
    frame = drwFrame.new(assets.image.frameButton2, 49, 43, 46, 6),
    text  = drwText.new(enums.genre[1]:gsub('^%l', string.upper), 49, 42, 46, 8),
    --ntr   = ntrRect.new(49, 43, 46, 6)
}
musicMenu:connect(genre.frame)
--musicMenu:connect(genre.ntr)

local previousGenre = {
    frame = drwFrame.new(assets.image.frameButton2, 31, 43, 6, 6),
    icon  = drwImage.new(assets.image.iconLeftSmall, 31, 43),
    ntr   = ntrRect.new(31, 43, 6, 6)
}
musicMenu:connect(previousGenre.frame)
musicMenu:connect(previousGenre.icon)
musicMenu:connect(previousGenre.ntr)

local nextGenre = {
    frame = drwFrame.new(assets.image.frameButton2, 107, 43, 6, 6),
    icon  = drwImage.new(assets.image.iconRightSmall, 107, 43),
    ntr   = ntrRect.new(107, 43, 6, 6)
}
musicMenu:connect(nextGenre.frame)
musicMenu:connect(nextGenre.icon)
musicMenu:connect(nextGenre.ntr)

local backButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 31, 203, 22, 22),
    icon    = drwImage.new(assets.image.iconBack, 34, 205),
    ntr     = ntrRect.new(31, 203, 22, 22)
}
musicMenu:connect(backButton.frame)
musicMenu:connect(backButton.icon)
musicMenu:connect(backButton.ntr)

local previousPageButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 65, 203, 18, 22),
    icon    = drwImage.new(assets.image.iconLeftArrow, 65, 203),
    ntr     = ntrRect.new(65, 203, 18, 22)
}
musicMenu:connect(previousPageButton.frame)
musicMenu:connect(previousPageButton.icon)
musicMenu:connect(previousPageButton.ntr)

local nextPageButton = {
    frame   = drwFrame.new(assets.image.frameButton2, 95, 203, 18, 22),
    icon    = drwImage.new(assets.image.iconRightArrow, 95, 203),
    ntr     = ntrRect.new(95, 203, 18, 22)
}
musicMenu:connect(nextPageButton.frame)
musicMenu:connect(nextPageButton.icon)
musicMenu:connect(nextPageButton.ntr)

local pageIndicator = drwText.new(nil, 26, 188, 92, 8)
musicMenu:connect(pageIndicator)

local list = {}

musicMenu.event:add('update', function (dt)
    if backButton.ntr.isClicked then
        local group = sysintf:getGroup(1)
        group.isLocked = false

        musicMenu.isVisible = false
        musicMenu.isLocked  = true

        if player.selected.musicIndex then
            player:getPot(player.selected.potIndex):setMusic(musics[enums.genre[player.selected.genre]][player.selected.musicIndex])
        end

        return
    end

    local oldPlayerSelectedGenre = player.selected.genre

    if nextGenre.ntr.isClicked or previousGenre.ntr.isClicked then
        if previousGenre.ntr.isClicked then
            --player.selected.genre = math.max(player.selected.genre-1, 1)
            player.selected.genre = (player.selected.genre-1-1) % #enums.genre + 1
        else
            --player.selected.genre = math.min(player.selected.genre+1, #enums.genre)
            player.selected.genre = (player.selected.genre-1+1) % #enums.genre + 1
        end

        genre.text.text = enums.genre[player.selected.genre]:gsub('^%l', string.upper)
    end

    local oldPlayerSelectedPage = player.selected.page

    -- To be polish this under below
    if previousPageButton.ntr.isClicked then
        local pageAmount = #musics[enums.genre[player.selected.genre]] / 5
        pageAmount = math.ceil(pageAmount)

        player.selected.page = (player.selected.page-1-1) % pageAmount + 1

        pageIndicator.text = 'Page ' .. tostring(player.selected.page) .. ' of ' .. pageAmount

    elseif nextPageButton.ntr.isClicked then
        local pageAmount = #musics[enums.genre[player.selected.genre]] / 5
        pageAmount = math.ceil(pageAmount)

        player.selected.page = (player.selected.page-1+1) % pageAmount + 1

        pageIndicator.text = 'Page ' .. tostring(player.selected.page) .. ' of ' .. pageAmount
    end

    if #list == 0 or player.selected.genre ~= oldPlayerSelectedGenre or player.selected.page ~= oldPlayerSelectedPage then
        if player.selected.genre ~= oldPlayerSelectedGenre then
            player.selected.page = 1
        end

        if pageIndicator.text == '' then
            local pageAmount = #musics[enums.genre[player.selected.genre]] / 5
            pageAmount = math.ceil(pageAmount)

            pageIndicator.text = 'Page ' .. tostring(player.selected.page) .. ' of ' .. pageAmount
        end

        if #list > 0 then
            for index = #list, 1, -1 do
                local t = list[index]

                musicMenu:remove(t.frame)
                musicMenu:remove(t.framePreview)
                musicMenu:remove(t.iconPreview)
                musicMenu:remove(t.name)
                musicMenu:remove(t.artist)
                musicMenu:remove(t.ntrPreview)
                musicMenu:remove(t.ntr)

                t.frame        = nil
                t.framePreview = nil
                t.iconPreview  = nil
                t.name         = nil
                t.artist       = nil
                t.ntrPreview   = nil
                t.ntr          = nil
                t.index        = nil

                table.remove(list, index)
            end
        end

        local selectedGenre = musics[enums.genre[player.selected.genre]]

        local a = 5 * (player.selected.page-1) + 1
        local b = a + 4

        local count = 1

        for index = a, b do
           local music = selectedGenre[index]

           if music then
                local x = 31
                local y = 63 + 26 * (count-1)

                list[count] = {
                    frame        = drwFrame.new(assets.image.frameButton1, x, y, 82, 14),
                    framePreview = drwFrame.new(assets.image.frameButton4, x+5, y+4, 6, 6),
                    iconPreview  = drwImage.new(assets.image.iconPlaySmall, x+5, y+4),
                    name         = drwTextScroll.new(music.name, x+17, y-1, 64, 8, 1, 0.5, true),
                    artist       = drwTextScroll.new(('by ' .. music.artist), x+17, y+7, 64, 8, 1, 0.5, true),
                    ntrPreview   = ntrRect.new(x+5, y+4, 6, 6),
                    ntr          = ntrRect.new(x, y, 82, 14),
                    index        = index
                }

                musicMenu:connect(list[count].frame)
                musicMenu:connect(list[count].framePreview)
                musicMenu:connect(list[count].iconPreview)
                musicMenu:connect(list[count].name)
                musicMenu:connect(list[count].artist)
                musicMenu:connect(list[count].ntrPreview)
                musicMenu:connect(list[count].ntr)
            end

            count = count + 1
        end
    end

    local selectedGenre = musics[enums.genre[player.selected.genre]]
    for index, ui in ipairs(list) do
        if ui.ntrPreview.isClicked then
            if player.previewIndex ~= nil and player.previewIndex ~= ui.index then
                selectedGenre[player.previewIndex].audio:stop()
            end

            if not selectedGenre[ui.index].audio:isPlaying() then
                selectedGenre[ui.index].audio:play()
                player.previewIndex = ui.index
            else
                selectedGenre[ui.index].audio:stop()
                player.previewIndex = nil
            end
        end

        if ui.ntr.isClicked then
            if player.selected.musicIndex and player.selected.musicIndex ~= ui.index or player.selected.musicIndex == nil then
                player.selected.musicIndex = ui.index
            elseif player.selected.musicIndex == ui.index then
                player.selected.musicIndex = nil
            end
        end
    end
end)

musicMenu.event:add('draw', function ()
    window:draw()

    love.graphics.setColor(color.rgb(60, 163, 112))
    title:draw()
    pageIndicator:draw()

    --color.condition(genre.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    love.graphics.setColor(1, 1, 1)
    genre.frame:draw()

    love.graphics.setColor(1, 1, 1)
    genre.text:draw()

    color.condition(nextGenre.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    nextGenre.frame:draw()
    nextGenre.icon:draw()
    color.condition(previousGenre.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    previousGenre.frame:draw()
    previousGenre.icon:draw()

    color.condition(backButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    backButton.frame:draw()
    backButton.icon:draw()

    color.condition(previousPageButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    previousPageButton.frame:draw()
    previousPageButton.icon:draw()

    color.condition(nextPageButton.ntr.isCursorHovering, {0.5, 0.5, 0.5}, {1, 1, 1})
    nextPageButton.frame:draw()
    nextPageButton.icon:draw()

    love.graphics.setColor(1, 1, 1)

    local selectedGenre = musics[enums.genre[player.selected.genre]]
    for index, ui in ipairs(list) do
        color.condition(ui.ntr.isCursorHovering or player.selected.musicIndex == ui.index, {0.5, 0.5, 0.5}, {1, 1, 1})
        ui.frame:draw()

        color.condition(ui.ntrPreview.isCursorHovering or selectedGenre[ui.index].audio:isPlaying(), {0.5, 0.5, 0.5}, {1, 1, 1})
        ui.framePreview:draw()
        ui.iconPreview:draw()

        love.graphics.setColor(1, 1, 235/255)
        ui.name:draw()
        love.graphics.setColor(126/255, 126/255, 143/255)
        ui.artist:draw()
    end

    love.graphics.setColor(1, 1, 1)
end)

return musicMenu