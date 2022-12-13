#Include <Paths>
#Include <Win>

Class Explorer {
   static winTitleRegex := "^[A-Z]: ahk_exe explorer\.exe"
   
   Class WinObj {
      static Pictures         := Win({exePath: Paths.Pictures,   runOpt: "Min"})
      static Materials        := Win({exePath: Paths.Materials,  runOpt: "Min"})
      static Volume           := Win({exePath: "C:\",            runOpt: "Min"})
      static VideoTools       := Win({exePath: Paths.VideoTools, runOpt: "Min"})
      static VsCodeExtensions := Win({exePath: Paths.VsCodeExtensions})
      static Prog             := Win({exePath: Paths.Prog})
      static SavedScreenshots := Win({exePath: Paths.SavedScreenshots})
   }
}