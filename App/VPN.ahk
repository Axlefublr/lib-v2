#Include <Utils\Win>
#Include <Paths>

Class VPN {

    static process := "PlanetVPN.exe"
    static exeTitle := "ahk_exe " this.process
    static winTitle := "Planet VPN " this.exeTitle
    static path := "C:\Program Files (x86)\PlanetVPN\PlanetVPN.exe"

    static winObj := Win({
        winTitle: this.winTitle,
        exePath: this.path
    })
}