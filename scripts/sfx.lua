local assets = require 'scripts.assets'

local sfx = {
    effects = {}
}

function sfx.initialize()
    local effects = sfx.effects

    effects['click'] = assets.getAudio('sfxClick')
    effects['warning'] = assets.getAudio('sfxWarning')
    effects['waterProduction'] = assets.getAudio('sfxWatering')
end

function sfx.setVolume(volume)
    for _, effect in pairs(sfx.effects) do
        effect:setVolume(volume)
    end
end

function sfx.play(name)
    local effect = sfx.effects[name]

    if effect then
        if effect:isPlaying() then
            effect:stop()
        end

        effect:play()
    end
end

return sfx