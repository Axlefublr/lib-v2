#Include <Paths>
#Include <Win>

Class Explorer {
   static winTitleRegex := "^[A-Z]: ahk_exe explorer\.exe"
   
   Class WinObj {
      static Pictures  := Win({winTitle: Paths.Pictures})
      static Materials := Win({winTitle: Paths.Materials})
   }
}