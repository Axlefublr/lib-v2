#Include <Tools\Info>

RelativeCoordGetter() {
	static var := 0
	static initX
	static initY
	if !var {
		MouseGetPos(&locX, &locY)
		ToolTip("Initial position")
		initX := locX
		initY := locY
		var := !var
		return
	}
	ToolTip()
	MouseGetPos(&loc1X, &loc1Y)

	relPosX := loc1X - initX
	relPosY := loc1Y - initY

	initX := 0
	initY := 0
	var := !var

	g_relative := Gui(, "Relative coord getter")
	g_relative.BackColor := "171717"
	g_relative.SetFont("s30 cC5C5C5", "Consolas")

	g_relative_textX := g_relative.Add("Text", , "Relative X: " relPosX)
	g_relative_textY := g_relative.Add("Text", , "Relative Y: " relPosY)

	topRightCorner := A_ScreenWidth / 20 * 14.3

	g_relative_hwnd := g_relative.hwnd

	Destruction := (*) => (
		HotIfWinActive("ahk_id " g_relative_hwnd),
		Hotkey("Escape", "Off"),
		Hotkey("1", "Off"),
		Hotkey("2", "Off"),
		g_relative.Destroy()
	)

	toClip(text, *) {
		static var := 0
		var++
		A_Clipboard := text
		Info("copied " text)
		if var >= 2
			Destruction()
	}

	HotIfWinActive("ahk_id " g_relative_hwnd)
	Hotkey("1", toClip.Bind(relPosX), "On")
	Hotkey("2", toClip.Bind(relPosY), "On")
	Hotkey("Escape", Destruction, "On")

	g_relative_textX.OnEvent("Click", toClip.Bind(relPosX))
	g_relative_textY.OnEvent("Click", toClip.Bind(relPosY))

	g_relative.OnEvent("Close", Destruction)

	g_relative.Show("AutoSize y0 x" topRightCorner)

}
