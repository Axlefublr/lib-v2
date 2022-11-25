#Include <Win>
#Include <Paths>

Class VPN {

   static exeTitle := "ahk_exe ProtonVPN.exe"
   static winTitle := "Proton VPN " this.exeTitle
   static path := "C:\Program Files (x86)\Proton Technologies\ProtonVPN\ProtonVPN.exe"

   static winObj := Win({
      winTitle: this.winTitle,
      exePath: this.path
   })
}