#Include <Tools\CleanInputBox>
#Include <App\Autohotkey>
#Include <Tools\KeycodeGetter>
#Include <Misc\EmojiSearch>
#Include <Utils\KeyChorder>
#Include <App\Browser>
#Include <App\Steam>
#Include <App\DS4>
#Include <Loaders\Links>
#Include <Abstractions\Registers>
#Include <Converters\Layouts>
#Include <Misc\TimerLoader>

#h:: {
    sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
    try key := Registers.ValidateKey(KeyChorder(), sValidKeys)
    catch UnsetItemError {
        Registers.CancelAction()
        return
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
        "k", KeyCodeGetter,
        "t", TimerLoader,
        "h", () => Browser.RunLink(Links["phind"]),
        "j", () => EmojiSearch(CleanInputBox().WaitForInput()),
        "i", () => Infos(A_Clipboard),

    )
    if key
        try actions[key].Call()
}