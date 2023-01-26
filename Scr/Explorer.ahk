#Include <Utils\KeyChorder>
#Include <App\Explorer>
#Include <Utils\Win>

#MaxThreadsBuffer true

<!d:: {
	key := KeyChorder()
	static keyActions := Map(

		"q", () => Explorer.WinObj.Volume.App_Folders(),
		"v", () => Explorer.WinObj.Pictures.App_Folders(),
		"t", () => Explorer.WinObj.VideoTools.App_Folders(),
		"s", () => Explorer.WinObj.Memes.App_Folders(),
		"e", () => Explorer.WinObj.Emoji.App_Folders(),
		"a", () => Explorer.WinObj.Audio.App_Folders(),
		"w", () => Explorer.WinObj.ScreenVideos.App_Folders(),
		"d", () => (SetTitleMatchMode("RegEx"), Explorer.WinObj.PC.App()),
		"c", () => Explorer.WinObj.Content.App_Folders(),

	)

	try keyActions[key].Call()
}

#MaxThreadsBuffer false