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
		"u", () => WindowManager().SeventyHor(),
		"i", () => WindowManager().ThirtyHor(),
		"t", () => WindowManager().UpThirtyVert(),
		"g", () => WindowManager().DownThirtyVert(),
		"f", () => WindowManager().UpSeventyVert(),
		"v", () => WindowManager().DownSeventyVert(),
		"e", () => WindowManager().SeventyVertSeventyHor(),
		"d", () => WindowManager().SeventyVertThirtyHor(),
		"m", () => WindowManager.CloseOnceInactive(),
		"/", () => WinSetAlwaysOnTop(-1, "A"),

	)

	if key
		try presets[key].Call()
}
