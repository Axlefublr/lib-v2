; No dependencies

class WindowManager {

	__New(winTitle := "A") {
		WindowManager.RestoreDown(winTitle)
		this.winTitle := winTitle
	}

	static RestoreDown(winTitle?) {
		while this.IsMaximized(winTitle?) {
			try PostMessage("0x112", "0xF120",,, winTitle ?? "A")
		}
	}

	static Maximize(winTitle?) {
		try PostMessage("0x112", "0xF030",,, winTitle ?? "A")
	}

	static IsMaximized(winTitle?) => WinGetMinMax(winTitle ?? "A") > 0


	class Presets extends WindowManager {

		static zeroX      := -8
		static zeroY      := 0
		static fullWidth  := A_ScreenWidth + 14
		static fullHeight := A_ScreenHeight + 6
		static halfX      := this.fullWidth // 2 - 18
		static halfWidth  := this.fullWidth // 2 + 12
		static halfY      := this.fullHeight // 2 - 3
		static halfHeight := this.fullHeight // 2 + 3

		static seventyX     := 1350
		static seventyWidth := this.seventyX + 22
		static thirtyWidth  := this.fullWidth - this.seventyX - 7

		LeftSide() => WinMove(
			WindowManager.Presets.zeroX,
			WindowManager.Presets.zeroY,
			WindowManager.Presets.halfWidth,
			WindowManager.Presets.fullHeight,
			WindowManager.Presets.winTitle
		)
		RightSide() => WinMove(
			WindowManager.Presets.halfX,
			WindowManager.Presets.zeroY,
			WindowManager.Presets.halfWidth,
			WindowManager.Presets.fullHeight,
			WindowManager.Presets.winTitle
		)
		TopSide() => WinMove(
			WindowManager.Presets.zeroX,
			WindowManager.Presets.zeroY,
			WindowManager.Presets.fullWidth,
			WindowManager.Presets.halfHeight,
			WindowManager.Presets.winTitle
		)
		BottomSide() => WinMove(
			WindowManager.Presets.zeroX,
			WindowManager.Presets.halfY,
			WindowManager.Presets.fullWidth,
			WindowManager.Presets.halfHeight,
			WindowManager.Presets.winTitle
		)

		Thiry() => WinMove(
			WindowManager.Presets.seventyX,
			WindowManager.Presets.zeroY,
			WindowManager.Presets.thirtyWidth,
			WindowManager.Presets.fullHeight,
			WindowManager.Presets.winTitle
		)
		Seventy() => WinMove(
			WindowManager.Presets.zeroX,
			WindowManager.Presets.zeroY,
			WindowManager.Presets.seventyWidth,
			WindowManager.Presets.fullHeight,
			WindowManager.Presets.winTitle
		)

	}

}
