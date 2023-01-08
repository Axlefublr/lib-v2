#Include <Paths>
#Include <Utils\Win>

Class Explorer {
   static exeTitle := "ahk_exe explorer.exe"
   static winTitleRegex := "^[A-Z]:|Downloads|Documents|This PC|OneDrive|Network|Linux|Desktop|File Explorer ahk_exe explorer\.exe"
   
   static winObjRegex := Win({winTitle: this.winTitleRegex})
   
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