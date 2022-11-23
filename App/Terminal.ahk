#Include <Win>

Class Terminal {

   static exeTitle := "ahk_exe WindowsTerminal.exe"
   static winTitle := "ahk_group Terminal " this.exeTitle
   static path := A_ProgramFiles "\WindowsApps\Microsoft.WindowsTerminal_1.14.2281.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe"

   static winTitles := Map(

      "Linux",    "Linux " this.winTitle,
      "Cmd",      "Cmd " this.winTitle,
      "Psh",      "PowerShell " this.winTitle,
      "Git Bash", "Git Bash " this.winTitle,
      "Settings", "Settings " this.winTitle

   )
   
   static winObj := Win({
      winTitle: this.winTitle,
      exePath: this.path
   })
   
   static SetupGroup() {
      
      static ranAlready := false
      
      if ranAlready {
         return
      }

      for key, value in this.winTitles {
         GroupAdd("Terminal", value)
      }
      
      ranAlready := true
   }

   static DeleteWord() => Send("^w")
}
