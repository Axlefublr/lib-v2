#Include <Tools\CleanInputBox>
#Include <App\Autohotkey>
#Include <Tools\KeycodeGetter>
#Include <Misc\EmojiSearch>
#Include <Utils\GetInput>
#Include <App\Browser>
#Include <App\Steam>
#Include <App\DS4>
#Include <Environment>
#Include <Abstractions\Registers>
#Include <Converters\Layouts>

#h:: {
	sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
	try key := Registers.ValidateKey(GetInput("L1", "{Esc}").Input, sValidKeys)
	catch UnsetItemError {
		Registers.CancelAction()
		return
	}

	static _ViewNote() {
		if !input := CleanInputBox().WaitForInput()
			return
		note := Environment.Notes.Choose(input)
		if !note
			return
		A_Clipboard := note
		Infos(note)
	}

	static _ShowInInfo() {
		if !input := CleanInputBox().WaitForInput()
			return
		Infos(input)
	}

	static actions := Map(

		"m", () => Browser.RunLink(Environment.Links["gmail"]),
		"n", () => Browser.RunLink(Environment.Links["monkeytype"]),
		"g", () => Browser.RunLink(Environment.Links["my github"]),
		"f", () => Browser.RunLink(Environment.Links["skill factory"]),
		"p", () => Browser.RunLink(Environment.Links["gpt"]),
		"P", () => Browser.RunLink(Environment.Links["gpt playground"]),
		"x", () => Browser.RunLink(Environment.Links["regex"]),
		"w", () => Browser.RunLink(Environment.Links["wildberries"]),
		"d", () => DS4.winObj.App(),
		"s", () => Steam.winObj.App(),
		"a", () => Browser.RunLink(Environment.Links["ahk v2 docs"]),
		"r", () => Browser.RunLink(Environment.Links["reddit"]),
		"T", () => Browser.RunLink(Environment.Links["twitch"]),
		"h", () => Browser.RunLink(Environment.Links["phind"]),
		"j", () => EmojiSearch(CleanInputBox().WaitForInput()),
		"c", () => Infos(A_Clipboard),
		"k", KeyCodeGetter,
		"o", _ViewNote,
		"i", _ShowInInfo,
		"v", () => Browser.RunLink(Environment.Links["vk"]),
		"t", () => Browser.RunLink(Environment.Links["mastodon"]),
		"e", () => Browser.RunLink(Environment.Links["gogoanime"]),

	)
	if key
		try actions[key].Call()
}