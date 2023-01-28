#Include <Utils\Win>
#Include <Paths>

Class Slack {

    static exeTitle := "ahk_exe slack.exe"
    static winTitle := "Slack " this.exeTitle
    static path := Paths.LocalAppData "\slack\app-4.28.171\slack.exe"
    
    static winObj := Win({
        winTitle: this.winTitle,
        exePath: this.path
    })
}