Class Browser {
   static exeTitle := "ahk_exe chrome.exe"
   static winTitle := "Google Chrome " this.exeTitle
   static path     := A_ProgramFiles "\Google\Chrome\Application\chrome.exe"

   static winObj := Win({
      winTitle: this.winTitle,
      exePath: this.path,
   })
}
