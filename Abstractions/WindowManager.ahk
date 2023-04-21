; No dependencies

class WindowManager {

    __New(winTitle := "A") {
        this.winTitle := winTitle
        CoordMode("Mouse", "Screen")
        WinGetPos(&x, &y, &width, &height, this.winTitle)
        this.X := x
        this.Y := y
        this.Width := width
        this.Height := height
    }

    MoveLeft(howMuch)  => WinMove(this.X - howMuch,,,, this.winTitle)
    MoveRight(howMuch) => WinMove(this.X + howMuch,,,, this.winTitle)
    MoveUp(howMuch)    => WinMove(, this.Y - howMuch,,,, this.winTitle)
    MoveDown(howMuch)  => WinMove(, this.Y + howMuch,,,, this.winTitle)

    DecreaseWidth(howMuch)  => WinMove(,, this.Width - howMuch,, this.winTitle)
    IncreaseWidth(howMuch)  => WinMove(,, this.Width + howMuch,, this.winTitle)
    DecreaseHeight(howMuch) => WinMove(,,, this.Height - howMuch, this.winTitle)
    IncreaseHeight(howMuch) => WinMove(,,, this.Height + howMuch, this.winTitle)

}