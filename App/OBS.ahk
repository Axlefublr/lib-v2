#Include <Paths>
#Include <Win>

Class OBS {
   
   exeTitle := "ahk_exe obs64.exe"
   winTitle := "OBS " this.exeTitle
   path     := A_ProgramFiles "\obs-studio\bin\64bit\obs64.exe"
   startIn  := A_ProgramFiles "\obs-studio\bin\64bit"

   static winObj := Win({
      winTitle: this.winTitle,
      exePath: this.path,
      startIn: this.startIn
   })

}