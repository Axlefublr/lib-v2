#Include <Utils\Win>
#Include <Paths>

Class VPN {

   static exeTitle := "ahk_exe PrivadoVPN.exe"
   static winTitle := "PrivadoVPN " this.exeTitle
   static path := "C:\Program Files (x86)\PrivadoVPN\PrivadoVPN.exe"

   static winObj := Win({
      winTitle: this.winTitle,
      exePath: this.path
   })
}