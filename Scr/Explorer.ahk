#Include <Utils\KeyChorder>
#Include <App\Explorer>
#Include <Utils\Win>
#Include <Abstractions\Registers>
#Include <Environment>

#MaxThreadsBuffer true
#HotIf !Environment.VimMode

<!d:: {
    try key := Registers.__ValidateKey(KeyChorder())
    catch UnsetItemError {
        Registers.__CancelAction()
        return
    }
    static keyActions := Map(

        "q", () => Explorer.WinObj.Volume.App_Folders(),
        "v", () => Explorer.WinObj.Pictures.App_Folders(),
        "t", () => Explorer.WinObj.VideoTools.App_Folders(),
        "s", () => Explorer.WinObj.Memes.App_Folders(),
        "e", () => Explorer.WinObj.Emoji.App_Folders(),
        "a", () => Explorer.WinObj.Audio.App_Folders(),
        "w", () => Explorer.WinObj.ScreenVideos.App_Folders(),
        "d", () => (SetTitleMatchMode("RegEx"), Explorer.WinObj.PC.App()),
        "c", () => Explorer.WinObj.Content.App_Folders(),

    )
    if key
        try keyActions[key].Call()
}

#HotIf
#MaxThreadsBuffer false