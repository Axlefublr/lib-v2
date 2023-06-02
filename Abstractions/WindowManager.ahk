; No dependencies

class WindowManager {

	__New(winTitle := "A") {
		if WinGetMinMax(winTitle) = 1
			WinRestore(winTitle)
		this.winTitle := winTitle
	}

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
	thirtyWidth  := this.fullWidth - this.seventyWidth + 14

	seventyY := 790
	seventyHeight := this.seventyY + 7
	thirtyHeight := this.fullHeight - this.seventyHeight + 7

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

	ThirtyVert() => WinMove(
		this.seventyX,
		this.zeroY,
		this.thirtyWidth,
		this.fullHeight,
		this.winTitle
	)
	SeventyVert() => WinMove(
		this.zeroX,
		this.zeroY,
		this.seventyWidth,
		this.fullHeight,
		this.winTitle
	)

	ThirtyHor() => WinMove(
		this.zeroX,
		this.zeroY,
		this.fullWidth,
		this.seventyHeight,
		this.winTitle
	)
	SeventyHor() => WinMove(
		this.zeroX,
		this.seventyY,
		this.fullWidth,
		this.thirtyHeight,
		this.winTitle
	)

}
