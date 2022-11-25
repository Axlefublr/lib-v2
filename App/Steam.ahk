#Include <Win>
#Include <Paths>

Class Steam {
   
   ; static winTitle :=
   static exeTitle := "ahk_exe steam.exe"
   static path     := "C:\Programs\Steam\steam.exe"
   static toClose  := "Steam - News"

   static winObj := Win({
      winTitle: this.exeTitle,
      exePath:  this.path,
      toClose:  this.toClose
   })
}