#Include <Abstractions\Registers>
#Include <Utils\GetInput>
#Include <Abstractions\WindowManager>
#Include <App\Terminal> ; GetTerminal split

#sc1A::WinRestore("A")
#sc1B::WinMaximize("A")

#i:: {
	sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
	try key := Registers.ValidateKey(GetInput("L1", "{Esc}").Input, sValidKeys)
	catch UnsetItemError {
		Registers.CancelAction()
		return
	}

	static GetTerminal() {
		WindowManager().SeventyHor()
		prevPosition := Terminal.winObj.position
		prevTopness := Terminal.winObj.isAlwaysOnTop
		Terminal.winObj.position := "ThirtyHor"
		Terminal.winObj.isAlwaysOnTop := true
		Terminal.winObj.RunAct()
		Terminal.winObj.position := prevPosition
		Terminal.winObj.isAlwaysOnTop := prevTopness
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
		"m", () => Win.CloseOnceInactive(),
		"/", () => WinSetAlwaysOnTop(-1, "A"),
		"r", () => GetTerminal(),

	)

	if key
		try presets[key].Call()
}
