;No dependencies

class Mouse {

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
