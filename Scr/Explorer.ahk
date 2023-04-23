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

        "q", () => Explorer.WinObjs.Volume.App_Folders(),
        "v", () => Explorer.WinObjs.Pictures.App_Folders().CloseOnceInactive(),
        "r", () => Explorer.WinObjs.Tree.App_Folders().CloseOnceInactive(),
        "t", () => Explorer.WinObjs.VideoTools.App_Folders().CloseOnceInactive(),
        "s", () => Explorer.WinObjs.Memes.App_Folders().CloseOnceInactive(),
        "e", () => Explorer.WinObjs.Emoji.App_Folders().CloseOnceInactive(),
        "a", () => Explorer.WinObjs.Audio.App_Folders().CloseOnceInactive(),
        "w", () => Explorer.WinObjs.ScreenVideos.App_Folders().CloseOnceInactive(),
        "d", () => Explorer.WinObjs.PC.App(),
        "c", () => Explorer.WinObjs.Content.App_Folders(),
        "o", () => Explorer.WinObjs.Other.App_Folders().CloseOnceInactive(),
        "O", () => Explorer.WinObjs.OnePiece.App_Folders(),
        "u", () => Explorer.WinObjs.User.App(),

    )
    if key
        try keyActions[key].Call()
}

#HotIf
#MaxThreadsBuffer false