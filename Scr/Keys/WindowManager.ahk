#Include <Abstractions\Registers>
#Include <Utils\GetInput>
#Include <Abstractions\WindowManager>

#i:: {
	sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
	try key := Registers.ValidateKey(GetInput("L1", "{Esc}").Input, sValidKeys)
	catch UnsetItemError {
		Registers.CancelAction()
		return
	}

	static presets := Map(

		"h", () => WindowManager().LeftSide(),
		"l", () => WindowManager().RightSide(),
		"j", () => WindowManager().BottomSide(),
		"k", () => WindowManager().TopSide(),
		"p", () => WindowManager().ThirtyVert(),
		"o", () => WindowManager().SeventyVert(),
		"i", () => WindowManager().SeventyHor(),
		"u", () => WindowManager().ThirtyHor(),
		";", () => WindowManager().UpThirtyVert(),
		"'", () => WindowManager().DownThirtyVert(),
		"[", () => WinRestore("A"),
		"]", () => WinMaximize("A"),
		".", () => Win.CloseOnceInactive(),
		"/", () => WinSetAlwaysOnTop(-1, "A"),

	)

	if key
		try presets[key].Call()
}
