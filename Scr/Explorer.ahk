#Include <Utils\KeyChorder>
#Include <App\Explorer>
#Include <Utils\Win>
#Include <Abstractions\Registers>
#Include <Environment>

#MaxThreadsBuffer true
#HotIf !Environment.VimMode

<!d:: {
    sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
    try key := Registers.ValidateKey(KeyChorder(), sValidKeys)
    catch UnsetItemError {
        Registers.CancelAction()
        return
    }
    static keyActions := Map(

        "q", () => Explorer.WinObj.Volume.App_Folders(),
        "v", () => Explorer.WinObj.Pictures.App_Folders().CloseOnceInactive(),
        "r", () => Explorer.WinObj.Tree.App_Folders().CloseOnceInactive(),
        "t", () => Explorer.WinObj.VideoTools.App_Folders().CloseOnceInactive(),
        "s", () => Explorer.WinObj.Memes.App_Folders().CloseOnceInactive(),
        "e", () => Explorer.WinObj.Emoji.App_Folders().CloseOnceInactive(),
        "a", () => Explorer.WinObj.Audio.App_Folders().CloseOnceInactive(),
        "w", () => Explorer.WinObj.ScreenVideos.App_Folders().CloseOnceInactive(),
        "d", () => (SetTitleMatchMode("RegEx"), Explorer.WinObj.PC.App()),
        "c", () => Explorer.WinObj.Content.App_Folders(),

    )
    if key
        try keyActions[key].Call()
}

#HotIf
#MaxThreadsBuffer false