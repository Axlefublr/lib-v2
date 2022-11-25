#Include <Win>
#Include <Paths>

Class FL {

   static exeTitle := "ahk_exe FL64.exe"
   ; static winTitle := ""
   static path := "C:\Programs\FL Studio 20\FL64.exe"
   static presetPath := Paths.Ptf["FL preset"]
   static closeWindow := "Confirm " this.exeTitle
   
   static winObj := Win({
      winTitle: this.exeTitle,
      exePath: this.presetPath
   })
   
   static Close() {
      this.winObj.Close()
      if !WinWait(this.closeWindow,, this.winObj.waitTime)
         return
      Win({winTitle: closeWindow}).Activate()
      Send("{Right}{Enter}")
   }
}