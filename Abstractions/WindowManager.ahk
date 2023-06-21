#Include <Utils\Wait>

class WindowManager {

	static Close(winTitle := "A", excludeTitle?) {
		try PostMessage("0x112", "0xF060",,, winTitle,, excludeTitle?)
		WinWaitClose(winTitle,, 1, excludeTitle?)
	}

	static CloseOnceInactive(winTitle := "A", excludeTitle?) {
		id := WinGetID(winTitle)
		Wait(
			() => !WinActive(id,, excludeTitle?),
			() => WindowManager.Close(id,, excludeTitle?),
			, 100
		)
	}

	__New(winTitle := "A", excludeTitle := "") {
		if WinGetMinMax(winTitle,, excludeTitle) = 1
			WinRestore(winTitle,, excludeTitle)
		this.winTitle := winTitle
		this.excludeTitle := excludeTitle
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
		this.winTitle,,
		this.excludeTitle
	)
	RightSide() => WinMove(
		this.halfX,
		this.zeroY,
		this.halfWidth,
		this.fullHeight,
		this.winTitle,,
		this.excludeTitle
	)
	TopSide() => WinMove(
		this.zeroX,
		this.zeroY,
		this.fullWidth,
		this.halfHeight,
		this.winTitle,,
		this.excludeTitle
	)
	BottomSide() => WinMove(
		this.zeroX,
		this.halfY,
		this.fullWidth,
		this.halfHeight,
		this.winTitle,,
		this.excludeTitle
	)

	ThirtyVert() => WinMove(
		this.seventyX,
		this.zeroY,
		this.thirtyWidth,
		this.fullHeight,
		this.winTitle,,
		this.excludeTitle
	)
	UpThirtyVert() => WinMove(
		this.seventyX,
		this.zeroY,
		this.thirtyWidth,
		this.halfHeight,
		this.winTitle,,
		this.excludeTitle
	)
	DownThirtyVert() => WinMove(
		this.seventyX,
		this.halfY,
		this.thirtyWidth,
		this.halfHeight,
		this.winTitle,,
		this.excludeTitle
	)
	SeventyVert() => WinMove(
		this.zeroX,
		this.zeroY,
		this.seventyWidth,
		this.fullHeight,
		this.winTitle,,
		this.excludeTitle
	)
	UpSeventyVert() => WinMove(
		this.zeroX,
		this.zeroY,
		this.seventyWidth,
		this.halfHeight,
		this.winTitle,
		this.excludeTitle
	)
	DownSeventyVert() => WinMove(
		this.zeroX,
		this.halfY,
		this.seventyWidth,
		this.halfHeight,
		this.winTitle,
		this.excludeTitle
	)
	SeventyVertSeventyHor() => WinMove(
		this.zeroX,
		this.zeroY,
		this.seventyWidth,
		this.seventyHeight,
		this.winTitle,
		this.excludeTitle
	)
	SeventyVertThirtyHor() => WinMove(
		this.zeroX,
		this.seventyY,
		this.seventyWidth,
		this.thirtyHeight,
		this.winTitle,
		this.excludeTitle
	)

	SeventyHor() => WinMove(
		this.zeroX,
		this.zeroY,
		this.fullWidth,
		this.seventyHeight,
		this.winTitle,,
		this.excludeTitle
	)
	ThirtyHor() => WinMove(
		this.zeroX,
		this.seventyY,
		this.fullWidth,
		this.thirtyHeight,
		this.winTitle,,
		this.excludeTitle
	)

}
