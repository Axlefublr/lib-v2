#Include <Paths>

/**
 * Call this function twice to create a block of a picked color.
 * The block is just a gui of one single color, without a title bar.
 * You can double click on it to remove it.
 * @param {Boolean/Hex} pickedColor First of all sorry, this parameter is wack.
 * Pass a color in hex, to set it as a new color.
 * Pass `false` to get the color under your mouse cursor as the new color.
 * Don't pass this parameter to start picking the edges of your block (this is what
 * you usually want to run).
 */
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
