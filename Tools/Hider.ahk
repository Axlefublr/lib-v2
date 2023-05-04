; No dependencies

Hider(pickedColor?) {
	CoordMode("Mouse", "Screen")
	CoordMode("Pixel", "Screen")
	static color
	if IsSet(pickedColor) {
		if !pickedColor {
			MouseGetPos(&colorX, &colorY)
			color := PixelGetColor(colorX, colorY)
		} else
			color := pickedColor
		return
	}

	static firstCall := true
	static firstX, firstY
	if firstCall {
		MouseGetPos(&x, &y)
		firstX := x
		firstY := y
		firstCall := false
		return
	}

	static widthCorrecter  := 0.80
	static heightCorrecter := 0.805
	MouseGetPos(&secondX, &secondY)

	width    := Round(Abs(secondX - firstX) * widthCorrecter)
	height   := Round(Abs(secondY - firstY) * heightCorrecter)
	topLeftX := secondX > firstX ? firstX : secondX
	topLeftY := secondY > firstY ? firstY : secondY

	gHider := Gui("AlwaysOnTop -Caption -Border +ToolWindow")
	gHider.BackColor := color ?? 0x171717

	gcPicture := gHider.AddPicture("w" width " h" height, Paths.Ptf["BlankPic"])
	gcPicture.OnEvent("Click", (guiCtrlObj, *) => guiCtrlObj.Gui.PressTitleBar())
	gcPicture.OnEvent("DoubleClick", (guiCtrlObj, *) => guiCtrlObj.Gui.Destroy())
	WinSetTransparent(1, gcPicture.Hwnd)

	gHider.Show("x" topLeftX " y" topLeftY " w" width " h" height " NA")
	firstCall := true
}
