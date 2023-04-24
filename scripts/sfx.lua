local assets = require 'scripts.assets'

local sfx = {
    audios = {
        click = assets.audio.sfxClick,
    }
}

function sfx:updateVolume(volume)
    for key, value in pairs(self.audios) do
        value:setVolume(volume)
    end
end

function sfx:emitSound(name)
    local audio = self.audios[name]
    
    if audio:isPlaying() then
        audio:stop()
    end

    audio:play()
end

return sfx