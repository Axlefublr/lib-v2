#Include <Utils\Win>
#Include <System\UIA>

Class Browser {
    static exeTitle := "ahk_exe msedge.exe"
    static winTitle := "Edge " Browser.exeTitle
    static path := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

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

        static BrowserClient {
            get => Browser.UIA.Window.FindElement({
                ClassName:     "BrowserRootView"
            }).FindElement({
                ClassName: "NonClientView"
            }).FindElement({
                ClassName: "GlassBrowserFrameView"
            }).FindElement({
                ClassName: "BrowserView"
            })
        }

        static Document {
            get => Browser.UIA.BrowserClient.FindElement({
                ClassName: "SidebarContentsSplitView",
                Scope: 2
            }).FindElement({
                ClassName: "SidebarContentsSplitView"
            }).FindElement({
                ClassName: "SidebarContentsSplitView"
            }).FindElement({
                ClassName: "SidebarContentsSplitView"
            }).FindElement({
                ClassName: "View"
            }).FindElement({
                Type: "Document"
            })
        }
    }

}
