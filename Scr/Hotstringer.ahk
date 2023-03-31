#Include <Tools\CleanInputBox>
#Include <Converters\DateTime>
#Include <Utils\LangDict>
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

    )
    static StaticHotstrings := Map(

        "gh",    Links["gh"],
        "ghm",   Links["ghm"],
        "micha", "Micha-ohne-el",
        "reiwa", "rbstrachan",
        "me",    "Axlefublr",
        "lib",   "lib-v2/",
        "queen", "Ok, hear me out: The queen is obviously a female, right? Every pawn can turn into a queen when they are at the other end of the board. That's pretty common knowledge, but here comes the kicker: Considering chess is an ancient game, and also considering in the olden times changing your gender wasn't common at all the pawns have to be female, alright? Pretty sexy, huh? So we established, that all pawns are female. But what about the other non-king pieces? A bishop, a horsey and an inanimate tower (well, it can move actually). All pretty unsexy. Buuuut, the pawns can turn into them! So they have to be female too. People still can't turn into horses or towers (even if they are trying), so I imagine them being sexy chicks in costumes. Like normal (sexy) halloween costumes for women. What does this all mean? The only male piece on the board is the king surrounded by sexy women. The king and his harem. A delicous image, it almost drives me crazy. And here comes the thing, that brings it over the top. The reason I can't play this game anymore as I am always too horny and distracted: Two kings and their harems fighting. Taking pieces aka capturing the other harem's luscious women and enslaving them to be part of one's own harem until one king has to give up, therefore doubling the size of your harem. Thirty (!) hot and willing women all ready for mating. Ready to do everything the king commands, just like on the battlefield, but this battlefield is in the bed. Oh boy, writing this made me too horny again. I gotta go and play a round of my private, personal version of this unbelievably arousing game. The people of the olden times really knew what's up.",

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
