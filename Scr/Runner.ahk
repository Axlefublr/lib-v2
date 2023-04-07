#Include <Extensions\String>
#Include <Loaders\Links>
#Include <Utils\ClipSend>
#Include <Extensions\String>
#Include <Utils\Win>
#Include <Paths>
#Include <Utils\Unicode>
#Include <Abstractions\Script>
#Include <Converters\DateTime>
#Include <Tools\CleanInputBox>
#Include <App\Slack>
#Include <Misc\Meditate>
#Include <Misc\CountLibraries>
#Include <App\FL>
#Include <App\Gimp>
#Include <Misc\MainApps>
#Include <App\Shows>
#Include <Misc\Calculator>

#j:: {
    if !input := CleanInputBox().WaitForInput() {
        return false
    }

    static runner_commands := Map(

        "libs?",  () => Infos(CountLibraries()),
        "drop",   () => Shows.DeleteShow(true),
        "finish", () => Shows.DeleteShow(false),
        "show",   () => Shows.Run("episode"),
        "down",   () => Shows.Run("downloaded"),

        ;Apps
        "apps",    MainApps,
        "v1 docs", () => Autohotkey.Docs.v1.RunAct(),
        "davinci", () => Davinci.projectWinObj.RunAct(),
        "slack",   () => Slack.winObj.RunAct(),
        "fl",      () => FL.winObj.RunAct(),
        "gimp",    () => Gimp.winObj.RunAct(),

        ;Folders
        "ext",   () => Explorer.WinObj.VsCodeExtensions.RunAct_Folders(),
        "saved", () => Explorer.WinObj.SavedScreenshots.RunAct_Folders(),
        "main",  () => VsCode.WorkSpace("Main"),

    )

    if runner_commands.Has(input) {
        runner_commands[input].Call()
        return
    }

    static _GitLinkOpenCopy(input) {
        link := Git.Link(input)
        Browser.RunLink(link)
        A_Clipboard := link
    }

    static _LinkCopy(input) {
        link := Links.Choose(input)
        if !link
            return
        A_Clipboard := link
        Info('"' link '" copied')
    }

    static _LinkPaste(input) {
        link := Links.Choose(input)
        if !link
            return
        ClipSend(link,, false)
    }

    static _LinkOpen(input) {
        link := Links.Choose(input)
        if !link
            return
        Browser.RunLink(link)
    }

    static runner_regex := Map(

        "glo",     (input) => _GitLinkOpenCopy(input),
        "gc",      (input) => A_Clipboard := Git.Link(input),
        "gl",      (input) => ClipSend(Git.Link(input),, false),
        "go",      (input) => Browser.RunLink(Git.Link(input)),
        "cpl",     (input) => _LinkCopy(input),
        "p",       (input) => _LinkPaste(input),
        "o",       (input) => _LinkOpen(input),
        "cp",      (input) => (A_Clipboard := input, Info('"' input '" copied')),
        "rap",     (input) => Spotify.NewRapper(input),
        "fav",     (input) => Spotify.FavRapper(input),
        "disc",    (input) => Spotify.NewDiscovery(input),
        "link",    (input) => Shows.SetLink(input),
        "ep",      (input) => Shows.SetEpisode(input),
        "finish",  (input) => Shows._OperateConsumed(input, false),
        "dd",      (input) => Shows.SetDownloaded(input),
        "drop",    (input) => Shows._OperateConsumed(input, true),
        "relink",  (input) => Shows.UpdateLink(input),
        "install", (input) => Git.InstallAhkLibrary(input),
        "ev",      (input) => Infos(Calculator(input)),
        "evp",     (input) => ClipSend(Calculator(input)),
        "i",       (input) => Infos(input),

    )
    regex := "^("
    for key, _ in runner_regex {
        regex .= key "|"
    }
    regex .= ") (.+)"
    result := input.RegexMatch(regex)
    if runner_regex.Has(result[1])
        try runner_regex[result[1]].Call(result[2])
}
