
class ClockApp {

    static exeTitle := "ahk_exe ApplicationFrameHost.exe"
    static winTitle := "Clock " ClockApp.exeTitle
    static path := "shell:Appsfolder\Microsoft.WindowsAlarms_8wekyb3d8bbwe!App"

    static winObj := Win({
        winTitle: ClockApp.winTitle,
        exePath:  ClockApp.path
    })

    class UIA {

        static MainElement {
            get => UIA.ElementFromHandle(ClockApp.winTitle).FindElement({
                Type: "Window",
                ClassName: "Windows.UI.Core.CoreWindow",
                Name: "Clock",
                Scope: 2,
                Order: 2
            })
        }
    }

}