#Include <Utils\Win>

Class LosslessCut {

   static exePath  := "ahk_exe LosslessCut.exe"
   static winTitle := "LosslessCut " this.exePath
   static path     := A_ProgramFiles "\LosslessCut\LosslessCut.exe"
   
   static winObj := Win({
      winTitle: this.winTitle, 
      exePath: this.path
   })
}