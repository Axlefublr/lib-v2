#Include <Tools\Info>

#InputLevel 6

;; Modeless keys
*NumpadDiv::F13
*NumpadMult::F14
*NumpadSub::OBS.winObj.App()
*NumLock::SomeLockHint("NumLock")

;; Mode switching
U_Numlock := 0
*NumpadEnter::return
*NumpadAdd::Infos(U_Numlock, 500)

NumpadEnter & NumpadIns::   global U_Numlock := 0
NumpadEnter & NumpadEnd::   global U_Numlock := 1
NumpadEnter & NumpadDown::  global U_Numlock := 2
NumpadEnter & NumpadPgDn::  global U_Numlock := 3
NumpadEnter & NumpadLeft::  global U_Numlock := 4
NumpadEnter & NumpadClear:: global U_Numlock := 5
NumpadEnter & NumpadRight:: global U_Numlock := 6
NumpadEnter & NumpadHome::  global U_Numlock := 7
NumpadEnter & NumpadUp::    global U_Numlock := 8
NumpadEnter & NumpadPgUp::  global U_Numlock := 9
NumpadEnter & NumpadDel::   global U_Numlock := 10

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
