
class ClockApp {

    static exeTitle := "ahk_exe ApplicationFrameHost.exe"
    static winTitle := "Clock " ClockApp.exeTitle
    static path := "shell:Appsfolder\Microsoft.WindowsAlarms_8wekyb3d8bbwe!App"

    static winObj := Win({
        winTitle: ClockApp.winTitle,
        exePath:  ClockApp.path
    })

}