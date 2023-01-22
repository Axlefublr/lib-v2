#Include <Tools\Info>

#InputLevel 5

;; Modeless keys
*NumpadDiv::F13
*NumpadMult::F14
*NumpadSub::OBS.winObj.App()
*NumLock::SomeLockHint("NumLock")

;; Mode switching
U_Numlock := 0
*NumpadEnter::global U_Numlock := 12
*NumpadAdd::Infos(U_Numlock, 500)

#HotIf U_Numlock = 12
NumpadIns::   global U_Numlock := 0
NumpadEnd::   global U_Numlock := 1
NumpadDown::  global U_Numlock := 2
NumpadPgDn::  global U_Numlock := 3
NumpadLeft::  global U_Numlock := 4
NumpadClear:: global U_Numlock := 5
NumpadRight:: global U_Numlock := 6
NumpadHome::  global U_Numlock := 7
NumpadUp::    global U_Numlock := 8
NumpadPgUp::  global U_Numlock := 9
NumpadDel::   global U_Numlock := 10
NumpadEnter:: global U_Numlock := 11

;; Mode 10 / Numbers
#HotIf U_Numlock = 11
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
#HotIf U_Numlock = 0
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
#HotIf U_Numlock = 1
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
#InputLevel 5
