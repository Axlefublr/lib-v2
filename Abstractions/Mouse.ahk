;No dependencies

/**
 * Clicks with "Click", then moves the mouse to its initial position
 * @param coordinates *String* "123 123" format
 */
ClickThenGoBack(coordinates) {
    MouseGetPos(&initX, &initY)
    Click(coordinates)
    MouseMove(initX, initY)
}

/**
 * Clicks by SendEventing the click, then moves the mouse to its initial position
 * @param coordinates *String* "123 123" format
 */
ClickThenGoBack_Event(coordinates) {
    MouseGetPos(&initX, &initY)
    SendEvent("{Click " coordinates "}")
    MouseMove(initX, initY)
}

/**
 * Controlclicks in the current mouse position, on the active window
 * @param winTitle *String* Specify a winTitle if you don't want to use the active window
 * @param whichButton *String* L for left mouse button, R for right mouse button
 */
ControlClick_Here(winTitle := "A", whichButton := "L") => (
    MouseGetPos(&locX, &locY),
    ControlClick("X" locX " Y" locY, winTitle, , whichButton)
)
