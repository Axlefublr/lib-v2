#Include <Tools\Info>
#Include <Environment>
#Include <Tools\Counter>
#Include <Tools\HoverScreenshot>

NumpadEnter::Environment.NumLock := 12

;; Mode none

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
NumpadAdd::return

;; Mode 12
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
NumpadAdd::   Environment.NumLock := 15

;; Mode 11 / Numbers
#HotIf Environment.NumLock = 11
NumpadIns::Send("0")
NumpadEnd::Send("1")
NumpadDown::Send("2")
NumpadPgDn::Send("3")
NumpadLeft::Send("4")
NumpadClear::Send("5")
NumpadRight::Send("6")
NumpadHome::Send("7")
NumpadUp::Send("8")
NumpadPgUp::Send("9")
NumpadDel::Send(".")
NumpadDiv::Send("/")
NumpadMult::Send("*")
NumpadSub::Send("-")
NumpadAdd::Send("{+}")

;; Mode 0
#HotIf Environment.NumLock = 0
NumpadIns::SoundPlayer.Storage["vine boom"].Play()
NumpadEnd::SoundPlayer.Storage["shall we"].Play()
NumpadDown::SoundPlayer.Storage["bruh sound effect"].Play()
NumpadPgDn::SoundPlayer.Storage["hohoho"].Play()
NumpadLeft::SoundPlayer.Storage["heheheha"].Play()
NumpadClear::SoundPlayer.Storage["faded than a hoe"].Play()
NumpadRight::SoundPlayer.Storage["cartoon"].Play()
NumpadHome:: {
    static counter := false
    counter := !counter
    if counter {
        SoundPlayer.Storage["bing chilling 1"].Play()
    } else {
        SoundPlayer.Storage["bing chilling 2"].Play()
    }
}
NumpadUp::SoundPlayer.Storage["oh fr on god"].Play()
NumpadPgUp::SoundPlayer.Storage["rizz"].Play()
NumpadDel::SoundPlayer.Storage["sus"].Play()
NumpadDiv::return
NumpadMult::return
NumpadSub::return
NumpadAdd::return

;; Mode 1
#HotIf Environment.NumLock = 1
NumpadIns::return
NumpadEnd::SoundPlayer.Storage["i just farted"].Play()
NumpadDown::return
NumpadPgDn::return
NumpadLeft::return
NumpadClear::SoundPlayer.Storage["shutter"].Play()
NumpadRight::return
NumpadHome::SoundPlayer.Storage["ting"].Play()
NumpadUp::return
NumpadPgUp::return
NumpadDel::return
NumpadDiv::return
NumpadMult::return
NumpadSub::return
NumpadAdd::return

;; Mode 5
#HotIf Environment.NumLock = 5
NumpadIns::return
NumpadEnd::return
NumpadDown::return
NumpadPgDn::return
NumpadLeft::return
NumpadClear::return
NumpadRight::return
NumpadHome:: {
    prevMode := Environment.NumLock
    Environment.NumLock := 11
    if !input := CleanInputBox().WaitForInput() {
        return false
    }
    Counter.num := input
    Counter.Show()
    Environment.NumLock := prevMode
}
NumpadUp::Counter.Send()
NumpadPgUp::Counter.Send().Increment()
NumpadDel::return
NumpadDiv::Counter.Reset().Show()
NumpadMult::Counter.Show()
NumpadSub::Counter.Decrement().Show()
NumpadAdd::Counter.Increment().Show()

;; Mode 7
#HotIf Environment.NumLock = 7
NumpadIns::return
NumpadEnd::return
NumpadDown::return
NumpadPgDn::HoverScreenshot(Paths.Ptf["femboy"]).Show()
NumpadLeft::return
NumpadClear::return
NumpadRight::return
NumpadHome::HoverScreenshot(Paths.Ptf["writing fire"]).Show()
NumpadUp::return
NumpadPgUp::HoverScreenshot(Paths.Ptf["urethra"]).Show()
NumpadDel::return
NumpadDiv::return
NumpadMult::return
NumpadSub::return
NumpadAdd::return

#HotIf
