#Include <Utils\GetInput>
#Include <App\Explorer>
#Include <Utils\Win>
#Include <Abstractions\Registers>
#Include <Environment>

#MaxThreadsBuffer true
#HotIf !Environment.VimMode

<!d:: {
	sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
	try key := Registers.ValidateKey(GetInput("L1", "{Esc}").Input, sValidKeys)
	catch UnsetItemError {
		Registers.CancelAction()
		return
	}

	static SetupExplorer(dir, folders := "_Folders") {
		Explorer.WinObjs.%dir%.App%folders%()
	}

	static keyActions := Map(

		"q", () => SetupExplorer("Volume"),
		"v", () => SetupExplorer("Pictures"),
		"r", () => SetupExplorer("Tree"),
		"t", () => SetupExplorer("VideoTools"),
		"s", () => SetupExplorer("Memes"),
		"e", () => SetupExplorer("Emoji"),
		"a", () => SetupExplorer("Audio"),
		"w", () => SetupExplorer("ScreenVideos"),
		"d", () => SetupExplorer("PC", ""),
		"c", () => SetupExplorer("Content"),
		"o", () => SetupExplorer("Other"),
		"O", () => SetupExplorer("OnePiece"),
		"u", () => SetupExplorer("User", ""),
		"l", () => SetupExplorer("Logos"),
		"h", () => SetupExplorer("Themes"),
		"p", () => SetupExplorer("Prog"),
		"1", () => WinRestore("A"),
		"2", () => WinMaximize("A"),
		"3", () => Explorer.winObj.CloseAll(),

	)
	if key
		try keyActions[key].Call()
}

#HotIf
#MaxThreadsBuffer false