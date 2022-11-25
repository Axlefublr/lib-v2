#Include <Win>
#Include <Paths>

Class Steam {
   
   ; static winTitle :=
   static processExe := "steam.exe"
   static exeTitle := "ahk_exe " this.processExe
   static path     := "C:\Programs\Steam\steam.exe"
   static toClose  := "Steam - News"

   static winObj := Win({
      winTitle: this.exeTitle,
      exePath:  this.path,
      toClose:  this.toClose
   })
   
   static Close() {
      this.winObj.Close()
      ProcessClose(this.exeTitle)
   }
}