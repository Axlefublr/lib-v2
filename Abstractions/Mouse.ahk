;No dependencies

class Mouse {

    static SmallMove := 10
    static MediumMove := 50
    static BigMove := 200

    /**
     * Hold down a mouse button if it's not held down currently.
     * If it's already held down, release it.
     * @param {Char} which Which mouse button to hold down or release. Only supports "L", "R", "M"
     */
    static HoldIfUp(which) {
        if GetKeyState(which "Button")
            Click(which "Up")
        else
            Click(which "Down")
    }

    static MoveLeft(howMuch) => MouseMove(-howMuch, 0,, "R")
    static MoveUp(howMuch) => MouseMove(0, -howMuch,, "R")
    static MoveDown(howMuch) => MouseMove(0, howMuch,, "R")
    static MoveRight(howMuch) => MouseMove(howMuch, 0,, "R")

    /**
     * Clicks with "Click", then moves the mouse to its initial position
     * @param coordinates *String* "123 123" format
     */
    static ClickThenGoBack(coordinates) {
        MouseGetPos(&initX, &initY)
        Click(coordinates)
        MouseMove(initX, initY)
    }

    /**
     * Clicks by SendEventing the click, then moves the mouse to its initial position
     * @param coordinates *String* "123 123" format
     */
    static ClickThenGoBack_Event(coordinates) {
        MouseGetPos(&initX, &initY)
        SendEvent("{Click " coordinates "}")
        MouseMove(initX, initY)
    }

    /**
     * Controlclicks in the current mouse position, on the active window
     * @param winTitle *String* Specify a winTitle if you don't want to use the active window
     * @param whichButton *String* L for left mouse button, R for right mouse button
     */
    static ControlClick_Here(winTitle := "A", whichButton := "L") => (
        MouseGetPos(&locX, &locY),
        ControlClick("X" locX " Y" locY, winTitle, , whichButton)
    )
}
