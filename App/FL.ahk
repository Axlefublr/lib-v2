#Include <Win>
#Include <Paths>

Class FL {

   static exeTitle := "ahk_exe FL64.exe"
   ; static winTitle := ""
   static path := Paths.Ptf["FL preset"]
   
   static winObj := Win({
      winTitle: this.exeTitle,
      exePath: this.path 
   })
}