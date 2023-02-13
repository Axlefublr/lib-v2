#Include <Tools\Info>

#InputLevel 5

;; Modeless keys
*NumLock::SomeLockHint("NumLock")

;; Mode switching
NumpadEnter::Environment.NumLock := 12

#HotIf Environment.NumLock = 12
NumpadIns::   Environment.NumLock := 0
NumpadEnd::   Environment.NumLock := 1
NumpadDown::  Environment.NumLock := 2
NumpadPgDn::  Environment.NumLock := 3
NumpadLeft::  Environment.NumLock := 4
NumpadClear:: Environment.NumLock := 5
NumpadRight:: Environment.NumLock := 6
NumpadHome::  Environment.NumLock := 7
NumpadUp::    Environment.NumLock := 8
NumpadPgUp::  Environment.NumLock := 9
NumpadDel::   Environment.NumLock := 10
NumpadEnter:: Environment.NumLock := 11
NumpadDiv::   Environment.NumLock := 12
NumpadMult::  Environment.NumLock := 13
NumpadSub::   Environment.NumLock := 14

;; Mode 10 / Numbers
#HotIf Environment.NumLock = 11
NumpadIns::0
NumpadEnd::1
NumpadDown::2
NumpadPgDn::3
NumpadLeft::4
NumpadClear::5
NumpadRight::6
NumpadHome::7
NumpadUp::8
NumpadPgUp::9
NumpadDel::.
NumpadDiv::/
NumpadMult::*
NumpadSub::-
NumpadAdd::+

;; Mode 0
#HotIf Environment.NumLock = 0
*NumpadIns::SoundPlayer.Storage["vine boom"].Play()
*NumpadEnd::SoundPlayer.Storage["shall we"].Play()
*NumpadDown::SoundPlayer.Storage["bruh sound effect"].Play()
*NumpadPgDn::SoundPlayer.Storage["hohoho"].Play()
*NumpadLeft::SoundPlayer.Storage["heheheha"].Play()
*NumpadClear::SoundPlayer.Storage["faded than a hoe"].Play()
*NumpadRight::SoundPlayer.Storage["cartoon"].Play()
*NumpadHome:: {
    static counter := false
    counter := !counter
    if counter {
        SoundPlayer.Storage["bing chilling 1"].Play()
    } else {
        SoundPlayer.Storage["bing chilling 2"].Play()
    }
}
*NumpadUp::SoundPlayer.Storage["oh fr on god"].Play()
*NumpadPgUp::SoundPlayer.Storage["rizz"].Play()
*NumpadDel::SoundPlayer.Storage["sus"].Play()

;; Mode 1
#HotIf Environment.NumLock = 1
NumpadIns::return
NumpadEnd::SoundPlayer.Storage["i just farted"].Play()
NumpadDown::return
NumpadPgDn::return
NumpadLeft::return
NumpadClear::return
NumpadRight::return
NumpadHome::return
NumpadUp::return
NumpadPgUp::return
NumpadDel::return

#HotIf

;; Not implemented
NumpadIns::return
NumpadEnd::return
NumpadDown::return
NumpadPgDn::return
NumpadLeft::return
NumpadClear::return
NumpadRight::return
NumpadHome::return
NumpadUp::return
NumpadPgUp::return
NumpadDel::return
NumpadDiv::return
NumpadMult::return
NumpadSub::return

#InputLevel 5
