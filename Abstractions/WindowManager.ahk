; No dependencies

class WindowManager {

	__New(winTitle := "A") {
		WinRestore(winTitle)
		this.winTitle := winTitle
	}

	class Presets extends WindowManager {

		zeroX      := -8
		zeroY      := 0
		fullWidth  := A_ScreenWidth + 14
		fullHeight := A_ScreenHeight + 6
		halfX      := this.fullWidth // 2 - 18
		halfWidth  := this.fullWidth // 2 + 12
		halfY      := this.fullHeight // 2 - 3
		halfHeight := this.fullHeight // 2 + 3

		seventyX     := 1350
		seventyWidth := this.seventyX + 22
		thirtyWidth  := this.fullWidth - this.seventyWidth - 7

		seventyY := 600
		seventyHeight := this.seventyY
		thirtyHeight := this.fullHeight - this.seventyHeight

		LeftSide() => WinMove(
			this.zeroX,
			this.zeroY,
			this.halfWidth,
			this.fullHeight,
			this.winTitle
		)
		RightSide() => WinMove(
			this.halfX,
			this.zeroY,
			this.halfWidth,
			this.fullHeight,
			this.winTitle
		)
		TopSide() => WinMove(
			this.zeroX,
			this.zeroY,
			this.fullWidth,
			this.halfHeight,
			this.winTitle
		)
		BottomSide() => WinMove(
			this.zeroX,
			this.halfY,
			this.fullWidth,
			this.halfHeight,
			this.winTitle
		)

		Thirty() => WinMove(
			this.seventyX,
			this.zeroY,
			this.thirtyWidth,
			this.fullHeight,
			this.winTitle
		)
		Seventy() => WinMove(
			this.zeroX,
			this.zeroY,
			this.seventyWidth,
			this.fullHeight,
			this.winTitle
		)

	}

}
