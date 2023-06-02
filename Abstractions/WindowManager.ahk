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

	RestoreDown() {
		Win.RestoreDown(this.winTitle)
		while WinGetMinMax(this.winTitle) > 0 {
		}
	}

	static Maximize(winTitle := "A") => Win.Maximize(winTitle)

	class Presets extends WindowManager {

		zeroX      := -8
		zeroY      := 0
		fullWidth  := A_ScreenWidth + 14
		fullHeight := A_ScreenHeight + 6
		halfX      := this.fullWidth // 2 - 18
		halfWidth  := this.fullWidth // 2 + 12
		halfY      := this.fullHeight // 2 - 3
		halfHeight := this.fullHeight // 2 + 3

		seventyX := 1350
		seventyWidth := this.seventyX + 22
		thirtyWidth := this.fullWidth - this.seventyX - 7

		LeftSide()   => WinMove(this.zeroX, this.zeroY, this.halfWidth, this.fullHeight, this.winTitle)
		RightSide()  => WinMove(this.halfX, this.zeroY, this.halfWidth, this.fullHeight, this.winTitle)
		TopSide()    => WinMove(this.zeroX, this.zeroY, this.fullWidth, this.halfHeight, this.winTitle)
		BottomSide() => WinMove(this.zeroX, this.halfY, this.fullWidth, this.halfHeight, this.winTitle)

		Thiry() => WinMove(this.seventyX, this.zeroY, this.thirtyWidth, this.fullHeight, this.winTitle)
		Seventy() => WinMove(this.zeroX, this.zeroY, this.seventyWidth, this.fullHeight, this.winTitle)

	}

}
