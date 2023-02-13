#Include <Tools\CleanInputBox>
#Include <Converters\DateTime>
#Include <Utils\Char>
#Include <Utils\CharGenerator>
#Include <Loaders\Links>
#Include <Utils\ClipSend>

#sc34:: {
    static DynamicHotstrings := Map(

        "radnum",    () => Random(1000000, 9999999),
        "currdate",  () => DateTime.Date,
        "weekday",   () => DateTime.WeekDay,
        "time",      () => DateTime.Time,
        "datetime",  () => DateTime.Date " " DateTime.Time,
        "datewtime", () => DateTime.Date " " DateTime.WeekDay " " DateTime.Time,
        "uclanr",    () => GetRandomWord("english") " ",
        "ilandh",    () => GetRandomWord("russian") " ",
        "chrs",      () => CharGenerator(2).GenerateCharacters(15),
        "track",     () => Spotify.GetCurrSong(),

    )
    static StaticHotstrings := Map(

        "gh",    Links["gh"],
        "ghm",   Links["ghm"],
        "micha", "Micha-ohne-el",
        "reiwa", "rbstrachan",
        "me",    "Axlefublr",

    )
    inputty := CleanInputBox()
    inputtyHwnd := inputty.Hwnd
    output := ""
    while !output {
        if !WinExist(inputtyHwnd) {
            break
        }
        text := inputty.InputField.Text
        if DynamicHotstrings.Has(text)
            output := DynamicHotstrings[text].Call()
        else if StaticHotstrings.Has(text)
            output := StaticHotstrings[text]
    }
    if output {
        inputty.Finish()
        ClipSend(output)
    }
}
