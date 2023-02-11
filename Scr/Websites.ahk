#Include <Utils\KeyChorder>
#Include <App\Browser>
#Include <App\Steam>
#Include <App\DS4>
#Include <Loaders\Links>

#n:: {
    key := KeyChorder()
    static actions := Map(

        "m", () => Browser.RunLink(Links["gmail"]),
        "n", () => Browser.MonkeyType.winObj.App(),
        "g", () => Browser.RunLink(Links["ghm"]),
        "f", () => Browser.RunLink(Links["skill factory"]),
        "p", () => Browser.RunLink(Links["gpt"]),
        "r", () => Browser.RunLink(Links["regex"]),
        "w", () => Browser.RunLink(Links["wildberries"]),
        "d", () => DS4.winObj.App(),
        "s", () => Steam.winObj.App(),
        "z", () => OBS.winObj.App(),
        "x", () => Autohotkey.Docs.v2.winObj.App(),
        "e", () => Browser.RunLink(Links["reddit"]),

    )
    if key
        try actions[key].Call()
}