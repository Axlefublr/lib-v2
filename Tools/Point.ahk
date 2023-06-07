#Include <Extensions\Gui>

class Point {

	__New(x?, y?, size?, color?) {

		isXSet := IsSet(x)
		isYSet := IsSet(y)

		if !isXSet || !isYSet {
			CoordMode("Mouse", "Screen")
			MouseGetPos(&xPos, &yPos)
		}
		if !isXSet
			x := xPos
		if !isYSet
			y := yPos

		this.x := x
		this.y := y
		if IsSet(color)
			this.Color := color
		if IsSet(size)
			this.Size := size
	}


	Size {
		get => Point.unit * this.multiplier
		set => this.multiplier := value
	}


	Color := Point.Color
	multiplier := 15
	guiExist := false


	static Color := 0xDE4D37 ; so this is red basically
	static unit := A_ScreenDPI / 96
	static spots := []


	static foDestroyAll := (*) => Point.DestroyAll()
	static DestroyAll() {
		for index, pointy in Point.spots {
			try pointy.Destroy()
		}
		Point.spots := []
	}


	Create() {
		if this.guiExist
			this.Destroy()
		this.guiObj := Gui("AlwaysOnTop -Caption +ToolWindow")
		this.guiObj.BackColor := this.Color
		this.guiExist := true
		this._Show()
		this.guiHwnd := this.guiObj.Hwnd
		this._SetupHotkeys()
		Point.spots.Push(this)
	}

	Destroy() {
		if !this.guiExist
			return
		this.guiObj.Destroy()
		this.guiExist := false
		this._DisableHotkeys()
	}


	_Show() {
		this.guiObj.Show(Format(
			"NA w{1} h{1} x{2} y{3}",
			Round(this.Size),
			this._CalculateGuiCoord(this.x),
			this._CalculateGuiCoord(this.y)
		))
		this.guiObj.NeverFocusWindow()
		this.guiObj.MakeClickthrough()
	}

	_CalculateGuiCoord(coord) => Round(coord - this.Size / 2)

	_SetupHotkeys() {
		HotIfWinExist("ahk_id " this.guiHwnd)
		Hotkey("Escape", Point.foDestroyAll, "On")
	}

	_DisableHotkeys() {
		HotIfWinExist("ahk_id " this.guiHwnd)
		Hotkey("Escape", "Off")
	}

}