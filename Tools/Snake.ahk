#Include <Tools\Info>

;Now that I use classes, I realize how ridiculous of an idea this was to write it all in one function
Snake(SquareSide, delay, timeout) {

	static isSlithering := false

	if isSlithering {
		Info("Press escape to disable snake first")
		return
	}

	maxSide := Min(A_ScreenWidth, A_ScreenHeight)
	if SquareSide > maxSide
		SquareSide := maxSide
	else if SquareSide <= 1
		SquareSide := 2

	timeout := timeout * 1000

	static colors := [
		"D12229", ;Red
		"F68A1E", ;Orange
		"FDE01A", ;Yellow
		"007940", ;Green
		"24408E", ;Blue
		"732982"  ;Purple
	]

	static Columns := A_ScreenWidth // SquareSide
	static Rows    := A_ScreenHeight // SquareSide

	;The gui's client + the place around it it still needs
	static MarginX := A_ScreenWidth // Columns
	static MarginY := A_ScreenHeight // Rows

	;How much client you'll get from a margin
	static ClientRelativity := 0.81

	static direction := "down"

	;The actual visible margins of the gui
	static ClientMarginX := MarginX * ClientRelativity
	static ClientMarginY := MarginY * ClientRelativity

	static index
	static colorIndex

	stopped := false

	ChangeDirection() => direction := (direction = "down" ? "up" : "down")

	Stop(*) => (
		startSnake.Destroy(),
		stopped := true,
		index := 0,
		colorIndex := 0
	)

	startSnake := Gui(, "Snake")
	startSnake.BackColor := "171717"

	startSnake.SetFont("s25 cC5C5C5", "Consolas")

	startSnake.Add("Text", "Center", "You can press Escape to exit the snake")

	startSnake.SetFont("s15")

	startSnake.Add("Button", "Default Center", "Start")
		.OnEvent("Click", (*) => startSnake.Destroy())
	startSnake.Add("Button", "x+m", "Cancel")
		.OnEvent("Click", Stop)

	startSnake.OnEvent("Close", Stop)

	startSnake.Show("AutoSize")
	WinWaitClose(startSnake.hwnd)

	if stopped
		return

	index := 0
	colorIndex := 0

	isSlithering := true

	SetTimer(GoSsss, delay)
	stopSlithering(*) => (
		HotIf(),
		SetTimer(GoSsss, 0),
		isSlithering := false,
		Hotkey("Escape", "Off")
	)
	HotIf()
	Hotkey("Escape", stopSlithering, "On")

	GoSsss() {

		snake := Gui("AlwaysOnTop -caption +E0x20 +ToolWindow")
		WinSetTransparent(255, snake.Hwnd)

		;An array of ID's of guis
		static aliveSnakes := []
		aliveSnakes.Push(snake.Hwnd)

		;An amount of guis to appear without all of them disappearing
		index++

		colorIndex++
		if colorIndex >= 7
			colorIndex := 1

		snake.Backcolor := colors[colorIndex]

		static xCoord := 0
		if index > Rows {
			index := index // Rows
			xCoord += MarginX
			if xCoord >= A_ScreenWidth - MarginX
				xCoord := 0
			ChangeDirection()
		}

		if direction = "down"
			yCoord := index * MarginY - MarginY
		else if direction = "up"
			yCoord := (Rows - index + 1) * MarginY - MarginY

		snake.Show("W " ClientMarginX " H" ClientMarginY " NA x" xCoord " y" yCoord)

		KillLastSnake := (*) => (
			SetTimer(KillLastSnake, 0),
			lastGui := aliveSnakes.RemoveAt(1),
			Win({winTitle: lastGui}).Close()
		)
		snake.OnEvent("Close", (*) => snake.Destroy())
		SetTimer(KillLastSnake, -timeout)
	}

}
