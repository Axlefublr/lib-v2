#Include <Paths>
#Include <Win>

Class Gimp {

   static exeTitle  := "ahk_exe gimp-2.10.exe"
   static winTitle  := this.exeTitle
   static path      := Paths.LocalAppData "\Programs\GIMP 2\bin\gimp-2.10.exe"
   static exception := "Startup"
   static toClose   := "GIMP Startup"
   static closeWindow := "Quit GIMP " this.exeTitle
   
   static Presets := Map(
      "ahk second channel", Paths.Pictures "\Tools\ahk second channel.xcf",
      "ahk",                Paths.Pictures "\Tools\ahk.xcf",
      "nvim",               Paths.Pictures "\Tools\nvim.xcf",
      "vscode",             Paths.Pictures "\Tools\vscode.xcf",
   )
   
   static winObj := Win({
      winTitle:  this.exeTitle,
      exePath:   this.path,
      toClose:   this.toClose,
      exception: this.exception
   })
   
   static Close() {
      this.winObj.Close()
      if !WinWait(this.closeWindow,, this.winObj.waitTime)
         return
      Win({winTitle: this.closeWindow}).Activate()
      Send("{Left}{Enter}")
   }
   
   static ahk2Preset := Win({
      winTitle:  this.exeTitle,
      exePath:   this.Presets["ahk second channel"],
      toClose:   this.toClose,
      exception: this.exception
   })
   
   static ahkPreset := Win({
      winTitle:  this.exeTitle,
      exePath:   this.Presets["ahk"],
      toClose:   this.toClose,
      exception: this.exception
   })
   
   static nvimPreset := Win({
      winTitle:  this.exeTitle,
      exePath:   this.Presets["nvim"],
      toClose:   this.toClose,
      exception: this.exception
   })
   
   static vscodePreset := Win({
      winTitle:  this.exeTitle,
      exePath:   this.Presets["vscode"],
      toClose:   this.toClose,
      exception: this.exception
   })
}