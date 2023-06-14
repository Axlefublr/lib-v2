#Include <Tools\CleanInputBox>
#Include <App\Autohotkey>
#Include <Tools\KeycodeGetter>
#Include <Misc\EmojiSearch>
#Include <Utils\GetInput>
#Include <App\Browser>
#Include <App\Steam>
#Include <App\DS4>
#Include <Abstractions\Registers>
#Include <Converters\Layouts>

#h:: {
	sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
	try key := Registers.ValidateKey(GetInput("L1", "{Esc}").Input, sValidKeys)
	catch UnsetItemError {
		Registers.CancelAction()
		return
	}

	static _ShowInInfo() {
		if !input := CleanInputBox().WaitForInput()
			return
		Infos(input)
	}

	static actions := Map(

		"m", () => Browser.RunLink(Links["gmail"]),
		"n", () => Browser.RunLink(Links["monkeytype"]),
		"g", () => Browser.RunLink(Links["my github"]),
		"f", () => Browser.RunLink(Links["skill factory"]),
		"x", () => Browser.RunLink(Links["regex"]),
		"w", () => Browser.RunLink(Links["wildberries"]),
		"d", () => DS4.winObj.App(),
		"s", () => Steam.winObj.App(),
		"a", () => Browser.RunLink(Links["ahk v2 docs"]),
		"r", () => Browser.RunLink(Links["reddit"]),
		"T", () => Browser.RunLink(Links["twitch"]),
		"h", () => Browser.RunLink(Links["phind"]),
		"j", () => EmojiSearch(CleanInputBox().WaitForInput()),
		"c", () => Infos(A_Clipboard),
		"k", KeyCodeGetter,
		"i", _ShowInInfo,
		"v", () => Browser.RunLink(Links["vk"]),
		"t", () => Browser.RunLink(Links["mastodon"]),
		"e", () => Browser.RunLink(Links["gogoanime"]),

	)
	if key
		try actions[key].Call()
}