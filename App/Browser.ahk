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

    static CurrentLink {
        get => Browser.UIA.Document.Value
    }


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

            static MainWindow {
                get => Browser.UIA.Window.FindElement({
                    ClassName: "BrowserRootView",
                    Scope: 2
                }).FindElement({
                    ClassName: "NonClientView",
                    Scope: 2
                }).FindElement({
                    ClassName: "GlassBrowserFrameView",
                    Scope: 2
                }).FindElement({
                    ClassName: "BrowserView",
                    Scope: 2
                }).FindElement({
                    ClassName: "TopContainerView",
                    Scope: 2
                })
            }

                static AddressSearchBar {
                    get => Browser.UIA.MainWindow.FindElement({
                        Type: "ToolBar",
                        Scope: 2
                    }).FindElement({
                        ClassName: "LocationBarView",
                        Scope: 2
                    }).FindElement({
                        Name: "Address and search bar",
                        Scope: 2
                    })
                }

        static Document {
            get => UIA.ElementFromChromium(Browser.winTitle).FindElement(UIA.RawViewCondition, 1)
        }
    }

}
