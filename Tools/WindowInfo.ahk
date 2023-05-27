#Include <Extensions\Gui>
#Include <Tools\Info>

class WindowInfo {

	__New(winTitle := "A") {
		this.winTitle   := WinGetTitle(winTitle)
		this.winText    := WinGetText(winTitle)
		this.exePath    := WinGetProcessPath(winTitle)
		this.processExe := WinGetProcessName(winTitle)
		this.class      := WinGetClass(winTitle)
		this.ID         := WinGetID(winTitle)
		this.PID        := WinGetPID(winTitle)
		this._CreateGui()
		this.hwnd := this.gObj.Hwnd
		position := 0
		this._AddWintitleCtrl(++position)
		this._AddWinTextCtrl(++position)
		this._AddExePathCtrl(++position)
		this._AddProcessExeCtrl(++position)
		this._AddClassCtrl(++position)
		this._AddIDCtrl(++position)
		this._AddPIDCtrl(++position)
		this.positions := position
		this._SetHotkey()
		this._Show()
	}


	winTitle   := ""
	exePath    := ""
	processExe := ""
	class      := ""
	ID         := ""
	PID        := ""


	foDestroy := (*) => this.Destroy()
	Destroy() {
		HotIfWinActive("ahk_id " this.hwnd)
		i := 0
		while i < this.positions {
			i++
			Hotkey(String(i), "Off")
		}
		Hotkey("Escape", "Off")
		this.gObj.Minimize()
		this.gObj.Destroy()
	}


	_CreateGui() => this.gObj := Gui(, "WindowGetter").DarkMode().MakeFontNicer()

	_Show() => this.gObj.Show("AutoSize y0")

	_ToClip := (text, *) => (A_Clipboard := text, Info(text " copied!"))

	_AddWintitleCtrl(position) {
		foToClip := this._ToClip.Bind(this.winTitle)
		this.gObj.Add("Text", "Center", this.winTitle)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey(position, foToClip, "On")
	}

	_AddWinTextCtrl(position) {
		foToClip := this._ToClip.Bind(this.winText)
		this.gObj.AddText("Center", this.winText)
			.OnEvent("Click", foToClip)
		HotIfWinactive("ahk_id " this.hwnd)
		Hotkey(position, foToClip, "On")
	}

	_AddExePathCtrl(position) {
		foToClip := this._ToClip.Bind(this.exePath)
		this.gObj.Add("Text", "Center", this.exePath)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey(position, foToClip, "On")
	}

	_AddProcessExeCtrl(position) {
		foToClip := this._ToClip.Bind(this.processExe)
		this.gObj.Add("Text", "Center", this.processExe)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey(position, foToClip, "On")
	}

	_AddClassCtrl(position) {
		foToClip := this._ToClip.Bind(this.class)
		this.gObj.Add("Text", "Center", this.class)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey(position, foToClip, "On")
	}

	_AddIDCtrl(position) {
		foToClip := this._ToClip.Bind(this.ID)
		this.gObj.Add("Text", "Center", "id: " this.ID)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey(position, foToClip, "On")
	}

	_AddPIDCtrl(position) {
		foToClip := this._ToClip.Bind(this.PID)
		this.gObj.Add("Text", "Center", "pid: " this.PID)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey(position, foToClip, "On")
	}

	_SetHotkey() {
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey("Escape", this.foDestroy, "On")
		this.gObj.OnEvent("Close", this.foDestroy)
	}

}