#Include <Abstractions\MediaActions>
#Include <System\SoundPlayer>

NumLock::return
NumpadEnter::return
NumpadDiv::MediaActions.SkipPrev()
NumpadMult::MediaActions.SkipNext()
NumpadSub::Send("{Volume_Down}")
NumpadAdd::Send("{Volume_Up}")
NumpadDot::Send("{Media_Play_Pause}")

Numpad0::return
Numpad1::return
Numpad2::return
Numpad3::return
Numpad4::return
Numpad5::return
Numpad6::return
Numpad7::return
Numpad8::return
Numpad9::return
