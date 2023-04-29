#Include <Tools\CleanInputBox>
#Include <App\Autohotkey>
#Include <Tools\KeycodeGetter>
#Include <Misc\EmojiSearch>
#Include <Utils\GetInput>
#Include <App\Browser>
#Include <App\Steam>
#Include <App\DS4>
#Include <Loaders\Links>
#Include <Abstractions\Registers>
#Include <Converters\Layouts>
#Include <Misc\TimerLoader>

#h:: {
    sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
    try key := Registers.ValidateKey(GetInput("L1", "{Esc}").Input, sValidKeys)
    catch UnsetItemError {
        Registers.CancelAction()
        return
    }

    static _ViewNote() {
        if !input := CleanInputBox().WaitForInput()
            return
        note := Notes.Choose(input)
        if !note
            return
        A_Clipboard := note
        Infos(note)
    }

    static actions := Map(

        "m", () => Browser.RunLink(Links["gmail"]),
        "n", () => Browser.RunLink(Links["monkeytype"]),
        "g", () => Browser.RunLink(Links["ghm"]),
        "f", () => Browser.RunLink(Links["skill factory"]),
        "p", () => Browser.RunLink(Links["gpt"]),
        "P", () => Browser.RunLink(Links["gpt playground"]),
        "x", () => Browser.RunLink(Links["regex"]),
        "w", () => Browser.RunLink(Links["wildberries"]),
        "d", () => DS4.winObj.App(),
        "s", () => Steam.winObj.App(),
        "a", () => Autohotkey.Docs.v2.winObj.App(),
        "r", () => Browser.RunLink(Links["reddit"]),
        "T", () => Browser.RunLink(Links["twitch"]),
        "h", () => Browser.RunLink(Links["phind"]),
        "j", () => EmojiSearch(CleanInputBox().WaitForInput()),
        "c", () => Infos(A_Clipboard),
        "k", KeyCodeGetter,
        "t", TimerLoader,
        "o", _ViewNote,

    )
    if key
        try actions[key].Call()
}