#Include <Paths>
#Include <Utils\Win>

Class Gimp {

   static exeTitle  := "ahk_exe gimp-2.10.exe"
   static winTitle  := "GIMP " this.exeTitle
   static path      := Paths.LocalAppData "\Programs\GIMP 2\bin\gimp-2.10.exe"
   static exception := "GIMP Startup"
   static toClose   := ""
   static closeWindow := "Quit GIMP " this.exeTitle
   
   static winObj := Win({
      winTitle:    this.winTitle,
      exePath:     this.path,
      toClose:     this.toClose,
      exception:   this.exception,
   })
   
   static Close() {
      this.winObj.Close()
      if !WinWait(this.closeWindow,, this.winObj.waitTime)
         return
      Send("{Left}{Enter}")
   }
}