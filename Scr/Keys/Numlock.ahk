#InputLevel 6

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
*NumpadDel::return

*NumpadDiv::F13
*NumpadMult::F14
*NumpadSub::OBS.winObj.App()
*NumpadAdd::F15
*NumpadEnter::SomeLockHint("NumLock")

NumLock::SomeLockHint("NumLock")

#InputLevel 5
