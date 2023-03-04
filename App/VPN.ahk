#Include <Utils\Win>
#Include <Paths>

Class VPN {

    static process := "UnblockVpn.exe"
    static exeTitle := "ahk_exe " this.process
    static winTitle := "Unblock VPN " this.exeTitle
    static path := "C:\Program Files (x86)\UnblockVPN\UnblockVpn.exe"

    static winObj := Win({
        winTitle: this.winTitle,
        exePath: this.path
    })
}