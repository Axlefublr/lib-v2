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

	class Presets extends WindowManager {

		zeroX      := -8
		zeroY      := 0
		fullWidth  := A_ScreenWidth + 15
		fullHeight := A_ScreenHeight + 6
		halfX      := this.fullWidth // 2
		halfWidth  := this.fullWidth // 2
		halfY      := this.fullHeight // 2
		halfHeight := this.fullHeight // 2

		__New(winTitle?) {
			super.__New(winTitle?)
		}

		LeftSide()   => WinMove(this.zeroX, this.zeroY, this.halfWidth, this.fullHeight, this.winTitle)
		RightSide()  => WinMove(this.halfWidth, this.zeroY, this.halfWidth, this.fullHeight, this.winTitle)
		TopSide()    => WinMove(this.zeroX, this.zeroY, this.fullWidth, this.halfHeight, this.winTitle)
		BottomSide() => WinMove(this.zeroX, this.halfHeight, this.fullWidth, this.halfHeight, this.winTitle)

	}

}
