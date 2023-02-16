#Include <Utils\Win>

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

    Class MonkeyType extends Browser {
        static winTitle := "Monkeytype"
        static path := A_ProgramFiles "\Google\Chrome\Application\chrome_proxy.exe --profile-directory=Default --app-id=picebhhlijnlefeleilfbanaghjlkkna"

        static winObj := Win({
            winTitle: Browser.MonkeyType.winTitle,
            exePath: Browser.MonkeyType.path
        })
    }

}
