#Include <Paths>
#Include <Win>

Class Gimp {

   static exeTitle  := "ahk_exe gimp-2.10.exe"
   static winTitle  := "GIMP " this.exeTitle
   static path      := Paths.LocalAppData "\Programs\GIMP 2\bin\gimp-2.10.exe"
   static exception := "GIMP Startup"
   static toClose   := ""
   static closeWindow := "Quit GIMP " this.exeTitle
   
   static Presets := Map(
      "ahk second channel", Paths.Pictures "\Tools\ahk second channel.xcf",
      "ahk",                Paths.Pictures "\Tools\ahk.xcf",
      "nvim",               Paths.Pictures "\Tools\nvim.xcf",
      "vscode",             Paths.Pictures "\Tools\vscode.xcf",
      "wind",               Paths.Pictures "\Tools\wind.xcf",
      "csharp",             Paths.Pictures "\Tools\csharp.xcf",
   )
   
   static winObj := Win({
      winTitle:  this.winTitle,
      exePath:   this.path,
      toClose:   this.toClose,
      exception: this.exception,
      closeWindow: this.closeWindow
   })
   
   static Close() {
      this.winObj.Close()
      if !WinWait(this.closeWindow,, this.winObj.waitTime)
         return
      Send("{Left}{Enter}")
   }
   
   static ahk2Preset := Win({
      winTitle:  this.winTitle,
      exePath:   this.Presets["ahk second channel"],
      toClose:   this.toClose,
      exception: this.exception
   })
   
   static ahkPreset := Win({
      winTitle:  this.winTitle,
      exePath:   this.Presets["ahk"],
      toClose:   this.toClose,
      exception: this.exception
   })
   
   static nvimPreset := Win({
      winTitle:  this.winTitle,
      exePath:   this.Presets["nvim"],
      toClose:   this.toClose,
      exception: this.exception
   })
   
   static vscodePreset := Win({
      winTitle:  this.winTitle,
      exePath:   this.Presets["vscode"],
      toClose:   this.toClose,
      exception: this.exception
   })
   
   static windPreset := Win({
      winTitle:  this.winTitle,
      exePath:   this.Presets["wind"],
      exception: this.exception
   })
   
   static csharpPreset := Win({
      winTitle: this.winTitle,
      exePath: this.Presets["csharp"],
      exception: this.exception
   })
}