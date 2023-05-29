; No dependencies

GetClick() {
	CoordMode("Mouse", "Screen")
	KeyWait("LButton", "U")
	KeyWait("LButton", "D")
	MouseGetPos(&x, &y, &window)

	return {
		x: x,
		y: y,
		window: window
	}
}