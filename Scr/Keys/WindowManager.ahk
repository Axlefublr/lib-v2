#Include <Abstractions\Registers>
#Include <Utils\GetInput>
#Include <Abstractions\WindowManager>

#!Space:: {
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
		"g", () => WindowManager().SeventyHor(),
		"t", () => WindowManager().ThirtyHor(),
		"[", () => WinRestore("A"),
		"]", () => WinMaximize("A"),
		".", () => Win.CloseOnceInactive(),
		"/", () => WinSetAlwaysOnTop(-1, "A"),

	)

	if key
		try presets[key].Call()
}
