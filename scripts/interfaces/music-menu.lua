-- General
local assets  = require 'scripts.assets'
local screen = require 'scripts.screen'
local sysntf = require 'scripts.sysntf'
local player = require 'scripts.player'
local musics = require 'scripts.musics'
local enums = require 'scripts.enums'
local color = require 'scripts.color'
local sfx = require 'scripts.sfx'
local overlay = require 'scripts.overlay'

-- Interface classes
local drwImage = require 'scripts.interface.elements.drw-image'
local drwFrame = require 'scripts.interface.elements.drw-frame'
local drwText = require 'scripts.interface.elements.drw-text'
local drwTextScroll = require 'scripts.interface.elements.drw-textscroll'
local ntrRect = require 'scripts.interface.elements.ntr-rect'

local musicMenu = require('scripts.interface.group').new(false, true)

local window = drwFrame.new(assets.getImage('frameWindow1'), 26, 26, 92, 204)
local title = drwText.new('Music Selection', 26, 26, 92, 8)

local genreIndicator      = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 49, 43, 46, 6),
    name = drwText.new(nil, 49, 42, 46, 8)
}
local previousGenreButton = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 31, 43, 6, 6),
    icon = drwImage.new(assets.getImage('iconleftArrowSmall'), 31, 43),
    ntr = ntrRect.new(31, 43, 6, 6)
}
local nextGenreButton     = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 107, 43, 6, 6),
    icon = drwImage.new(assets.getImage('iconRightArrowSmall'), 107, 43),
    ntr = ntrRect.new(107, 43, 6, 6)
}
local pageIndicator = drwText.new('Page ? of ?', 26, 188, 92, 8)
local backButton = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 31, 203, 22, 22),
    icon = drwImage.new(assets.getImage('iconBack'), 31, 203),
    ntr = ntrRect.new(31, 203, 22, 22)
}
local previousPageButton  = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 65, 203, 18, 22),
    icon = drwImage.new(assets.getImage('iconleftArrow'), 63, 203),
    ntr = ntrRect.new(65, 203, 18, 22)
}
local nextPageButton      = {
    frame = drwFrame.new(assets.getImage('frameButton3'), 95, 203, 18, 22),
    icon = drwImage.new(assets.getImage('iconRightArrow'), 93, 203),
    ntr = ntrRect.new(95, 203, 18, 22)
}

musicMenu:connect(window)
musicMenu:connect(title)

musicMenu:connect(genreIndicator)
musicMenu:connect(previousGenreButton)
musicMenu:connect(nextGenreButton)
musicMenu:connect(pageIndicator)
musicMenu:connect(backButton)
musicMenu:connect(previousPageButton)
musicMenu:connect(nextPageButton)

local list = {}
local listActive = 5

for index = 1, 5 do
    local x = 31
    local y = 63 + 26 * (index - 1)

    list[index] = {
        isActive     = false,
        index        = 0,
        frame        = drwFrame.new(assets.image.frameButton1, x, y, 82, 14),
        previewFrame = drwFrame.new(assets.image.frameButton5, x+5, y+4, 6, 6),
        previewIcon  = drwImage.new(assets.image.iconPreview, x+5, y+4),
        name         = drwTextScroll.new(nil, x+18, y-1, 64, 8, 1, 1, true),
        artist       = drwTextScroll.new(nil, x+18, y+7, 63, 8, 1, 1, true),
        ntr          = ntrRect.new(x, y, 82, 14),
        previewNtr   = ntrRect.new(x+5, y+4, 6, 6)
    }

    musicMenu:connect(list[index])
end

local isOpened = false

local function setListElementActive(element, bool)
    element.isActive               = bool
    element.frame.isVisible        = bool
    element.previewFrame.isVisible = bool
    element.previewIcon.isVisible  = bool
    element.name.isVisible         = bool
    element.artist.isVisible       = bool
    element.ntr.isLocked           = not bool
    element.previewNtr.isLocked    = not bool
end

local function reIndexList()
    local genre = musics[enums.key.genre[player.selected.genre]]
    local offset = 5 * (player.selected.page - 1)

    local count = 0

    for index, element in ipairs(list) do
        local i = offset + index
        local music = genre[i]

        if music then
            element.index = i
            element.name:setText(music.name)
            element.artist:setText('by ' .. music.artist)

            element.name.lerp.time = 0
            element.artist.lerp.time = 0

            setListElementActive(element, true)
        else
            setListElementActive(element, false)
        end
    end

    listActive = count
end

local function stopPreview()
    local genre = musics[enums.key.genre[player.selected.genre]]
    local music

    if player.selected.previewIndex then
        music = genre[player.selected.previewIndex].audio

        if music:isPlaying() then
            music:stop()
        end

        player.selected.previewIndex = nil
    end
end

local function preview(index)
    local genre = musics[enums.key.genre[player.selected.genre]]
    local music

    if player.selected.previewIndex and player.selected.previewIndex ~= index then
        music = genre[player.selected.previewIndex].audio

        if music:isPlaying() then
            music:stop()
        end
    end

    music = genre[index].audio

    if not music:isPlaying() then
        music:play()
        player.selected.previewIndex = index
    else
        music:stop()
        player.selected.previewIndex = nil
    end
end

local function selectMusic(index)
    if player.selected.musicGenre == player.selected.genre and player.selected.musicIndex == index then
        player.selected.musicGenre = nil
        player.selected.musicIndex = nil
        player.getSelectedPot():setMusic(nil)
    else
        player.selected.musicGenre = player.selected.genre
        player.selected.musicIndex = index
    end
end

local function setMusic()
    if not player.selected.musicGenre or not player.selected.musicIndex then
        return
    end

    local genre = musics[enums.key.genre[player.selected.musicGenre]]
    local music = genre[player.selected.musicIndex]

    player.getPot(player.selected.potIndex):setMusic(music, player.selected.musicGenre, player.selected.musicIndex, player.selected.potIndex)

    player.selected.musicGenre = nil
    player.selected.musicIndex = nil
end

local function updateList()
    for index, element in ipairs(list) do
        if element.isActive then
            if element.previewNtr.isClicked then
                preview(element.index)
                sfx.play('click')
            elseif element.ntr.isClicked then
                selectMusic(element.index)
                sfx.play('click')
            end
        end
    end
end

local function drawList()
    for index, element in ipairs(list) do
        if element.isActive then
            color.conditionRGB(
                (element.ntr.isCursorHovering and not element.previewNtr.isCursorHovering) or (player.selected.genre == player.selected.musicGenre and player.selected.musicIndex == element.index),
                0.5, 0.5, 0.5,
                1, 1, 1,
                true
            )

            element.frame:draw()

            color.conditionRGB(
                element.previewNtr.isCursorHovering or player.selected.previewIndex == element.index,
                0.5, 0.5, 0.5,
                1, 1, 1,
                true
            )

            element.previewFrame:draw()
            element.previewIcon:draw()

            love.graphics.setColor(1, 1, 1)
            element.name:draw()

            color.RGB(126, 126, 143, true)
            element.artist:draw()
        end
    end
end

local function updatePageText()
    local genre = musics[enums.key.genre[player.selected.genre]]
    local pageAmount = math.ceil(#genre / 5)

    pageIndicator.text = 'Page ' .. player.selected.page .. ' of ' .. pageAmount
end

local function updateGenreText()
    genreIndicator.name.text = enums.key.genre[player.selected.genre]:gsub('^%l', string.upper)
end

local function changeGenre(next)
    stopPreview()

    if not next then
        player.selected.genre = (player.selected.genre-1-1) % #enums.key.genre + 1
    else
        player.selected.genre = (player.selected.genre-1+1) % #enums.key.genre + 1
    end

    updateGenreText()
end

local function changePage(next)
    local genre = musics[enums.key.genre[player.selected.genre]]
    local pageAmount = math.ceil(#genre / 5)

    if not next then
        player.selected.page = (player.selected.page-1-1) % pageAmount + 1
    else
        player.selected.page = (player.selected.page-1+1) % pageAmount + 1
    end

    updatePageText()
end

local function returnMain()
    sysntf:getGroup(1):toggleLockOnly()
    musicMenu:toggle()
    isOpened = false
    stopPreview()
    setMusic()
end

musicMenu.event:add('update', function (dt)
    if backButton.ntr.isClicked then
        returnMain()
        sfx.play('click')
    end

    local oldGenre = player.selected.genre

    if nextGenreButton.ntr.isClicked then
        changeGenre(true)
        sfx.play('click')
    elseif previousGenreButton.ntr.isClicked then
        changeGenre(false)
        sfx.play('click')
    end

    local oldPageNumber = player.selected.page

    if nextPageButton.ntr.isClicked then
        changePage(true)
        sfx.play('click')
    elseif previousPageButton.ntr.isClicked then
        changePage(false)
        sfx.play('click')
    end

    if player.selected.page ~= oldPageNumber or player.selected.genre ~= oldGenre or not isOpened then
        reIndexList()

        if not isOpened then
            isOpened = true
            updateGenreText()
            updatePageText()
        end
    end

    updateList()
end)

musicMenu.event:add('draw', function ()
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(assets.getFont('small'))

    window:draw()
    overlay:draw()

    genreIndicator.frame:draw()
    genreIndicator.name:draw()

    color.RGB(60, 163, 112, true)

    title:draw()
    pageIndicator:draw()

    color.conditionRGB(previousGenreButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    previousGenreButton.frame:draw()
    previousGenreButton.icon:draw()

    color.conditionRGB(nextGenreButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    nextGenreButton.frame:draw()
    nextGenreButton.icon:draw()

    color.conditionRGB(backButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    backButton.frame:draw()
    backButton.icon:draw()

    color.conditionRGB(previousPageButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    previousPageButton.frame:draw()
    previousPageButton.icon:draw()

    color.conditionRGB(nextPageButton.ntr.isCursorHovering, 0.5, 0.5, 0.5, 1, 1, 1, true)
    nextPageButton.frame:draw()
    nextPageButton.icon:draw()

    drawList()

    love.graphics.setColor(1, 1, 1, 1)
end)

return musicMenu