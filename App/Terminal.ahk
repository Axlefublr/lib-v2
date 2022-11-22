#Include <Win>

Class Terminal {

   static winTitle := "ahk_exe WindowsTerminal.exe"

   static winTitles := Map(

      "Linux",    "Linux " this.winTitle,
      "Cmd",      "Cmd " this.winTitle,
      "Psh",      "PowerShell " this.winTitle,
      "Git Bash", "Git Bash " this.winTitle,
      "Settings", "Settings " this.winTitle

   )

   static IsActive() {
      
      AllWintitles := []
      for key, value in this.winTitles {
         AllWintitles.Push(value)
      }
      
      return Win({winTitles: AllWintitles}).IsActive()
   }
   
   static DeleteWord() => Send("^w")
}
