#Include <Utils\KeyChorder>
#Include <App\Browser>
#Include <App\Steam>
#Include <App\DS4>
#Include <Loaders\Links>
#Include <Abstractions\Registers>

#h:: {
    try key := Registers.__ValidateKey(KeyChorder())
    catch UnsetItemError {
        Registers.__CancelAction()
        return
    }
    static actions := Map(

        "m", () => Browser.RunLink(Links["gmail"]),
        "n", () => Browser.MonkeyType.winObj.App(),
        "g", () => Browser.RunLink(Links["ghm"]),
        "f", () => Browser.RunLink(Links["skill factory"]),
        "p", () => Browser.RunLink(Links["gpt"]),
        "x", () => Browser.RunLink(Links["regex"]),
        "w", () => Browser.RunLink(Links["wildberries"]),
        "d", () => DS4.winObj.App(),
        "s", () => Steam.winObj.App(),
        "a", () => Autohotkey.Docs.v2.winObj.App(),
        "r", () => Browser.RunLink(Links["reddit"]),

    )
    if key
        try actions[key].Call()
}