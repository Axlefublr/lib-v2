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
	static keyActions := Map(

		"q", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Volume.App_Folders()),
		"v", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Pictures.App_Folders()),
		"r", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Tree.App_Folders()),
		"t", () => (WindowManager().SeventyVert(), Explorer.WinObjs.VideoTools.App_Folders()),
		"s", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Memes.App_Folders()),
		"e", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Emoji.App_Folders()),
		"a", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Audio.App_Folders()),
		"w", () => (WindowManager().SeventyVert(), Explorer.WinObjs.ScreenVideos.App_Folders()),
		"d", () => (WindowManager().SeventyVert(), Explorer.WinObjs.PC.App()),
		"c", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Content.App_Folders()),
		"o", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Other.App_Folders()),
		"O", () => (WindowManager().SeventyVert(), Explorer.WinObjs.OnePiece.App_Folders()),
		"u", () => (WindowManager().SeventyVert(), Explorer.WinObjs.User.App()),
		"l", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Logos.App_Folders()),
		"h", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Themes.App_Folders()),
		"p", () => (WindowManager().SeventyVert(), Explorer.WinObjs.Prog.App_Folders()),
		"1", () => Explorer.winObj.CloseAll(),

	)
	if key
		try keyActions[key].Call()
}

#HotIf
#MaxThreadsBuffer false