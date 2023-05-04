; No dependencies

class WindowManager {

	__New(winTitle := "A") {
		this.winTitle := winTitle
		CoordMode("Mouse", "Screen")
		this.RestoreDown()
		WinGetPos(&x, &y, &width, &height, this.winTitle)
		this.X := x
		this.Y := y
		this.Width := width
		this.Height := height
	}

	MoveLeft(howMuch)  => (WinMove(  this.X - howMuch,,,, this.winTitle), this)
	MoveRight(howMuch) => (WinMove(  this.X + howMuch,,,, this.winTitle), this)
	MoveUp(howMuch)    => (WinMove(, this.Y - howMuch,,,  this.winTitle), this)
	MoveDown(howMuch)  => (WinMove(, this.Y + howMuch,,,  this.winTitle), this)

	DecreaseWidth(howMuch)  => (WinMove(,,  this.Width - howMuch,, this.winTitle), this)
	IncreaseWidth(howMuch)  => (WinMove(,,  this.Width + howMuch,, this.winTitle), this)
	DecreaseHeight(howMuch) => (WinMove(,,, this.Height - howMuch, this.winTitle), this)
	IncreaseHeight(howMuch) => (WinMove(,,, this.Height + howMuch, this.winTitle), this)

	SetHalfWidth()  => (WinMove(,,  A_ScreenWidth  // 2,, this.winTitle), this)
	SetHalfHeight() => (WinMove(,,, A_ScreenHeight // 2,  this.winTitle), this)
	SetFullWidth()  => (WinMove(,,  A_ScreenWidth,,       this.winTitle), this)
	SetFullHeight() => (WinMove(,,, A_ScreenHeight,       this.winTitle), this)

	AbsoluteMove(x, y) => (WinMove(x, y,,, this.winTitle), this)

	RestoreDown() {
		WinRestore(this.winTitle)
		while WinGetMinMax(this.winTitle) > 0 {
		}
	}

}