#Include <Environment>
#Include <App\Spotify>
#Include <App\Davinci>
#Include <Extensions\String>
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
#Include <App\Shows>
#Include <Misc\Calculator>
#Include <App\Explorer>

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

		"fl",   () => FL.winObj.RunAct(),
		"gimp", () => Gimp.winObj.RunAct(),
		"davinci", () => Davinci.winObj.RunAct(),

		"ext",   () => Explorer.WinObjs.VsCodeExtensions.RunAct_Folders(),
		"saved", () => Explorer.WinObjs.SavedScreenshots.RunAct_Folders(),

	)

	static runner_regex := Map(

		"go",      (input) => _GitLinkOpenCopy(input),
		"gl",      (input) => ClipSend(Git.Link(input),, false),
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

	)

	if runner_commands.Has(input) {
		runner_commands[input].Call()
		return
	}

	regex := "^("
	for key, _ in runner_regex {
		regex .= key "|"
	}
	regex .= ") (.+)"
	result := input.RegexMatch(regex)
	if runner_regex.Has(result[1])
		runner_regex[result[1]].Call(result[2])

	static _GitLinkOpenCopy(input) {
		link := Git.Link(input)
		Browser.RunLink(link)
		A_Clipboard := link
	}

	static _LinkPaste(input) {
		link := Environment.Links.Choose(input)
		if !link
			return
		ClipSend(link,, false)
	}

	static _LinkOpen(input) {
		link := Environment.Links.Choose(input)
		if !link
			return
		Browser.RunLink(link)
	}

}
