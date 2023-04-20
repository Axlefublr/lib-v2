#Include <Utils\Win>
#Include <System\UIA>

Class Browser {

    static exeTitle := "ahk_exe msedge.exe"
    static winTitle := "Edge " Browser.exeTitle
    static path     := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

    ; static exeTitle := "ahk_exe firefox.exe"
    ; static winTitle := "Mozilla Firefox " Browser.exeTitle
    ; static path     := "C:\Program Files\Mozilla Firefox\firefox.exe"

    ; static exeTitle := "ahk_exe chrome.exe"
    ; static winTitle := "Google Chrome " Browser.exeTitle
    ; static path := "C:\Program Files\Google\Chrome\Application\chrome.exe"

    static winObj := Win({
        winTitle: Browser.winTitle,
        exePath: Browser.path,
    })

    static SearchTabs() => Send("^+a")

    /**
     * Run("https://link.com") will run the link, but the browser might not get focused. This function makes sure it does
     * @param {String} link
     */
    static RunLink(link) => (
        Run(link),
        WinWait(Browser.winTitle),
        WinActivate(Browser.winTitle)
    )

    class UIA {

        static Window {
            get => UIA.ElementFromHandle(Browser.winTitle)
        }

        static Document {
            get => UIA.ElementFromChromium(Browser.winTitle).FindElement(UIA.RawViewCondition, 1)
        }
    }

}
