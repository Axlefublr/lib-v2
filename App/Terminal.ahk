#Include <Win>

Class Terminal {

   static exeTitle := "ahk_exe WindowsTerminal.exe"

   static winTitles := Map(

      "Linux",    "Linux " this.winTitle,
      "Cmd",      "Cmd " this.winTitle,
      "Psh",      "PowerShell " this.winTitle,
      "Git Bash", "Git Bash " this.winTitle,
      "Settings", "Settings " this.winTitle

   )
   
   SetupGroup() {
      
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
