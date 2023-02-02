#Include <Utils\ClipSend>
#Include <Loaders\Links>
#Include <Extensions\String>
#Include <Utils\Win>
#Include <Paths>
#Include <Utils\Char>
#Include <Abstractions\Script>
#Include <Converters\DateTime>
#Include <Tools\CleanInputBox>
#Include <App\Slack>

+!l:: {
    if !input := CleanInputBox().WaitForInput() {
        return false
    }

    static runner_commands := Map(

        "update",  () => GitHub.UpdateAhkLibraries(),
        "str len", () => Infos(A_Clipboard.Length),
        "shows",   () => Shows().GetList(),
        "track",   () => ClipSend(Spotify.GetCurrSong(),, false),
        "kb",      () => KeyCodeGetter(),
        "libs?",   () => Infos(CountLibraries()),

        ;Apps
        "sm",      Run.Bind(Paths.Apps["Sound mixer"]),
        "apps",    MainApps,
        "v1 docs", () => Autohotkey.Docs.v1.RunAct(),
        "davinci", () => Davinci.projectWinObj.RunAct(),
        "slack",   () => Slack.winObj.RunAct(),
        "steam",   () => Steam.winObj.RunAct(),
        "vpn",     () => VPN.winObj.RunAct(),
        "fl",      () => FL.winObj.RunAct(),
        "ds4",     () => DS4.winObj.RunAct(),
        "gimp",    () => Gimp.winObj.RunAct(),
        "mt",      () => Browser.MonkeyType.winObj.RunAct(),

        ;Folders
        "ext",   () => Explorer.WinObj.VsCodeExtensions.RunAct_Folders(),
        "prog",  () => Explorer.WinObj.Prog.RunAct_Folders(),
        "saved", () => Explorer.WinObj.SavedScreenshots.RunAct_Folders(),
        "gim",   () => Explorer.WinObj.VideoTools.RunAct_Folders(),
        "main",  () => VsCode.WorkSpace("Main"),

        ;Video production
        "clean",    () => VsCode.CleanText(ReadFile(A_Clipboard)),
        "edit",     () => Video.EditScreenshot(),
        "video up", () => VsCode.VideoUp(),
        "dupl",     () => Video.DuplicateScreenshot(),
        "setup",    () => Davinci.Setup(),
        "cut",      () => LosslessCut.winObj.RunAct(),

    )

    try runner_commands[input].Call()
    catch Any {
        RegexMatch(input, "^(p|o|op|r|t|fav|ev|i|show|link|ep|delow|counter|gl|go|install|chrs|dd|down|drop|disc|sy|ts|evp|cp|tm|glo) (.+)", &result)
        static runner_regex := Map(

            "op", (input) => (
                A_Clipboard := Links[input],
                Browser.RunLink(Links[input])
            ),
            "cp", (input) => (
                A_Clipboard := input,
                Info('"' input '" copied')
            ),
            "tm", (input) => (
                timerObj := Timer(input),
                timerObj.shouldRing := false,
                timerObj.Start()
            ),
            "glo",     (input) => (
                link := Git.Link(input),
                Browser.RunLink(link),
                A_Clipboard := link
            ),
            "p",       (input) => ClipSend(Links[input], , false),
            "o",       (input) => Browser.RunLink(Links[input]),
            "r",       (input) => Spotify.NewRapper(input),
            "t",       (input) => Timer(input).Start(),
            "fav",     (input) => Spotify.FavRapper_Manual(input),
            "ev",      (input) => Infos(Calculator(input)),
            "evp",     (input) => ClipSend(Calculator(input)),
            "i",       (input) => Infos(input),
            "show",    (input) => Shows().Run(input),
            "down",    (input) => Shows().Run(input, "downloaded"),
            "link",    (input) => Shows().SetLink(input),
            "ep",      (input) => Shows().SetEpisode(input),
            "dd",      (input) => Shows().SetDownloaded(input),
            "delow",   (input) => Shows().DeleteShow(input),
            "drop",    (input) => Shows().DeleteShow(input, true),
            "counter", (input) => Info(Counter.num := input),
            "gl",      (input) => ClipSend(Git.Link(input), "", false),
            "go",      (input) => Browser.RunLink(Git.Link(input)),
            "install", (input) => Git.InstallAhkLibrary(input),
            "chrs",    (input) => ClipSend(CharGenerator(2).GenerateCharacters(input)),
            "disc",    (input) => Spotify.NewDiscovery_Manual(input),
            "sy",      (input) => Symbol(input),

        )
        try runner_regex[result[1]].Call(result[2])
    }
}
