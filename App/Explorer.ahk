#Include <Paths>
#Include <Win>

Class Explorer {
   static winTitleRegex := "^[A-Z]: ahk_exe explorer\.exe"
   
   Class WinObj {
      static Pictures         := Win({exePath:  Paths.Pictures,  runOpt: "Min"})
      static Materials        := Win({exePath:  Paths.Materials, runOpt: "Min"})
      static Volume           := Win({exePath:  "C:\",           runOpt: "Min"})
      static VsCodeExtensions := Win({exePath:  Paths.VsCodeExtensions})
      static Prog             := Win({exePath:  Paths.Prog})
      static SavedScreenshots := Win({winTitle: Paths.SavedScreenshots})
   }
}