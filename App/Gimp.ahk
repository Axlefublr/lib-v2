#Include <Paths>

Class Gimp {

   static exeTitle  := "ahk_exe gimp-2.10.exe"
   static path := Paths.LocalAppData "\Programs\GIMP 2\bin\gimp-2.10.exe"
   static exception := "Startup"
   static toClose   := "GIMP Startup"
   
   static Presets := Map(
      "ahk second channel", Paths.Pictures "\Tools\ahk second channel.xcf",
      "ahk",                Paths.Pictures "\Tools\ahk.xcf",
      "nvim",               Paths.Pictures "\Tools\nvim.xcf",
      "vscode",             Paths.Pictures "\Tools\vscode.xcf",
   )
}