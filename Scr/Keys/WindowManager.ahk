#Include <Abstractions\Registers>
#Include <Utils\GetInput>
#Include <Abstractions\WindowManager>

#sc1A::WinRestore("A")
#sc1B::WinMaximize("A")

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
		"u", () => WindowManager().SeventyHor(),
		"i", () => WindowManager().ThirtyHor(),
		";", () => WindowManager().UpThirtyVert(),
		"'", () => WindowManager().DownThirtyVert(),
		".", () => Win.CloseOnceInactive(),
		"/", () => WinSetAlwaysOnTop(-1, "A"),

	)

	if key
		try presets[key].Call()
}
