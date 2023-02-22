#Include <Utils\Win>
#Include <Paths>

Class VPN {

    static process := "NordVPN.exe"
    static exeTitle := "ahk_exe " this.process
    static winTitle := "NordVPN " this.exeTitle
    static path := "C:\Program Files\NordVPN\NordVPN.exe"

    static winObj := Win({
        winTitle: this.winTitle,
        exePath: this.path
    })
}