#Include <Utils\Win>
#Include <System\UIA>

Class Browser {
    static exeTitle := "ahk_exe firefox.exe"
    static winTitle := "Mozilla Firefox " Browser.exeTitle
    static path := A_ProgramFiles "\Mozilla Firefox\firefox.exe"

    static winObj := Win({
        winTitle: Browser.winTitle,
        exePath: Browser.path,
    })

    /**
     * Run("https://link.com") will run the link, but the browser might not get focused. This function makes sure it does
     * @param link *String*
     */
    static RunLink(link) => (
        Run(link),
        WinWait(Browser.winTitle),
        WinActivate(Browser.winTitle)
    )

    class MonkeyType extends Browser {
        static winTitle := "Monkeytype"
        static path := A_ProgramFiles "\Google\Chrome\Application\chrome_proxy.exe --profile-directory=Default --app-id=picebhhlijnlefeleilfbanaghjlkkna"

        static winObj := Win({
            winTitle: Browser.MonkeyType.winTitle,
            exePath: Browser.MonkeyType.path
        })
    }

    class UIA {

        static Window {
            get => UIA.ElementFromHandle(Browser.winTitle)
        }

        static Document {
            get => Browser.UIA.Window.FindElement({
                Type: "Custom",
                AutomationId: "panel-1-2",
                Scope: 2
            }).FindElement({
                Type: "Pane"
            }).FindElement({
                Type: "Document"
            })
        }
    }

}
