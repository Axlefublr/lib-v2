Class Browser {
   static exeTitle := "ahk_exe chrome.exe"
   static winTitle := "Google Chrome " this.exeTitle
   static path     := A_ProgramFiles "\Google\Chrome\Application\chrome.exe"

   static winObj := Win({
      winTitle: this.winTitle,
      exePath: this.path,
   })
   
   Class MonkeyType extends Browser {
      static winTitle := "Monkeytype " super.exeTitle
      static path := A_ProgramFiles "\Google\Chrome\Application\chrome_proxy.exe --profile-directory=Default --app-id=picebhhlijnlefeleilfbanaghjlkkna"
      
      static winObj := Win({
         winTitle: this.winTitle,
         exePath: this.path
      })
   }
   
   Class Clock extends Browser {
      static winTitle := "Reiwa's Clock - Axle's Clock " super.exeTitle
      static path := A_ProgramFiles "\Google\Chrome\Application\chrome_proxy.exe --profile-directory=Default --app-id=jibnhljmnbkjahicgmpgapbkgfcihedl"
      
      static winObj := Win({
         winTitle: this.winTitle,
         exePath: this.path
      })
   }
}
