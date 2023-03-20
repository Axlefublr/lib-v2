#Include <Abstractions\MediaActions>
#Include <System\SoundPlayer>

NumpadDiv::MediaActions.SkipPrev()
NumpadMult::MediaActions.SkipNext()
NumpadSub::Send("{Volume_Down}")
NumpadAdd::Send("{Volume_Up}")
NumpadDot::Send("{Media_Play_Pause}")
NumLock::SoundPlayer.Storage["sus"].Play()
Numpad0::SoundPlayer.Storage["vine boom"].Play()
Numpad1::SoundPlayer.Storage["i just farted"].Play()
Numpad2::SoundPlayer.Storage["bruh sound effect"].Play()
Numpad3::SoundPlayer.Storage["hohoho"].Play()
Numpad4::SoundPlayer.Storage["heheheha"].Play()
Numpad5::SoundPlayer.Storage["faded than a hoe"].Play()
Numpad6::SoundPlayer.Storage["cartoon"].Play()
Numpad7:: {
    static counter := false
    counter := !counter
    if counter {
        SoundPlayer.Storage["bing chilling 1"].Play()
    } else {
        SoundPlayer.Storage["bing chilling 2"].Play()
    }
}
Numpad8::SoundPlayer.Storage["shutter"].Play()
Numpad9::SoundPlayer.Storage["rizz"].Play()
