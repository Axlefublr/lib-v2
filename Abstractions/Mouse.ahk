;No dependencies

class Mouse {

	static SmallMove  := 20
	static MediumMove := 70
	static BigMove    := 200

	static HorizontalSeparator := 20
	static VerticalSeparator   := 7

	static TopY    := A_ScreenHeight // Mouse.VerticalSeparator
	static MiddleY := A_ScreenHeight // 2
	static LowY    := Round(A_ScreenHeight / 1080 * 740)
	static BottomY := A_ScreenHeight // Mouse.VerticalSeparator * 6

	static FarLeftX        := A_ScreenWidth / Mouse.HorizontalSeparator
	static HighLeftX       := A_ScreenWidth / Mouse.HorizontalSeparator * 3
	static MiddleLeftX     := A_ScreenWidth / Mouse.HorizontalSeparator * 5
	static LowLeftX        := A_ScreenWidth / Mouse.HorizontalSeparator * 7
	static LessThanMiddleX := A_ScreenWidth / Mouse.HorizontalSeparator * 9
	static MiddleX         := A_ScreenWidth // 2
	static MoreThanMiddleX := A_ScreenWidth / Mouse.HorizontalSeparator * 11
	static LowRightX       := A_ScreenWidth / Mouse.HorizontalSeparator * 13
	static MiddleRightX    := A_ScreenWidth / Mouse.HorizontalSeparator * 15
	static HighRightX      := A_ScreenWidth / Mouse.HorizontalSeparator * 17
	static FarRightX       := A_ScreenWidth / Mouse.HorizontalSeparator * 19

	/**
	* Hold down a mouse button if it's not held down currently.
	* If it's already held down, release it.
	* @param {Char} which Which mouse button to hold down or release.
	* Only supports "L", "R", "M".
	*/
	static HoldIfUp(which) {
		if GetKeyState(which "Button")
			Click(which " Up")
		else
			Click(which " Down")
	}

	static MoveLeft(howMuch)  => MouseMove(-howMuch, 0,, "R")
	static MoveUp(howMuch)    => MouseMove(0, -howMuch,, "R")
	static MoveDown(howMuch)  => MouseMove(0, howMuch,, "R")
	static MoveRight(howMuch) => MouseMove(howMuch, 0,, "R")

	/**
	* Clicks with "Click", then moves the mouse to its initial position
	* @param {String} coordinates "123 123" format
	*/
	static ClickThenGoBack(coordinates) {
		MouseGetPos(&initX, &initY)
		Click(coordinates)
		MouseMove(initX, initY)
	}

	/**
	* Clicks by SendEventing the click, then moves the mouse to its initial position
	* @param {String} coordinates "123 123" format
	*/
	static ClickThenGoBack_Event(coordinates) {
		MouseGetPos(&initX, &initY)
		SendEvent("{Click " coordinates "}")
		MouseMove(initX, initY)
	}

	/**
	* Controlclicks in the current mouse position, on the active window
	* @param {String} winTitle Specify a winTitle if you don't want to use the active window
	* @param {String} whichButton L for left mouse button, R for right mouse button
	*/
	static ControlClick_Here(winTitle := "A", whichButton := "L") {
		MouseGetPos(&locX, &locY)
		ControlClick("X" locX " Y" locY, winTitle, , whichButton)
	}
}
