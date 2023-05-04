#Include <Extensions\Gui>
#Include <Tools\Info>

class WindowInfo {

	__New(winTitle := "A") {
		this.winTitle   := WinGetTitle(winTitle)
		this.exePath    := WinGetProcessPath(winTitle)
		this.processExe := WinGetProcessName(winTitle)
		this.class      := WinGetClass(winTitle)
		this.ID         := WinGetID(winTitle)
		this.PID        := WinGetPID(winTitle)
		this._CreateGui()
		this.hwnd := this.gObj.Hwnd
		this._AddWintitleCtrl()
		this._AddExePathCtrl()
		this._AddProcessExeCtrl()
		this._AddClassCtrl()
		this._AddIDCtrl()
		this._AddPIDCtrl()
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
		Hotkey("1", "Off")
		Hotkey("2", "Off")
		Hotkey("3", "Off")
		Hotkey("4", "Off")
		Hotkey("5", "Off")
		Hotkey("6", "Off")
		Hotkey("Escape", "Off")
		this.gObj.Minimize()
		this.gObj.Destroy()
	}


	_CreateGui() => this.gObj := Gui(, "WindowGetter").DarkMode().MakeFontNicer()

	_Show() => this.gObj.Show("AutoSize y0")

	_ToClip := (text, *) => (A_Clipboard := text, Info(text " copied!"))

	_AddWintitleCtrl() {
		foToClip := this._ToClip.Bind(this.winTitle)
		this.gObj.Add("Text", "Center", this.winTitle)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey("1", foToClip, "On")
	}

	_AddExePathCtrl() {
		foToClip := this._ToClip.Bind(this.exePath)
		this.gObj.Add("Text", "Center", this.exePath)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey("2", foToClip, "On")
	}

	_AddProcessExeCtrl() {
		foToClip := this._ToClip.Bind(this.processExe)
		this.gObj.Add("Text", "Center", this.processExe)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey("3", foToClip, "On")
	}

	_AddClassCtrl() {
		foToClip := this._ToClip.Bind(this.class)
		this.gObj.Add("Text", "Center", this.class)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey("4", foToClip, "On")
	}

	_AddIDCtrl() {
		foToClip := this._ToClip.Bind(this.ID)
		this.gObj.Add("Text", "Center", "id: " this.ID)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey("5", foToClip, "On")
	}

	_AddPIDCtrl() {
		foToClip := this._ToClip.Bind(this.PID)
		this.gObj.Add("Text", "Center", "pid: " this.PID)
			.OnEvent("Click", foToClip)
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey("6", foToClip, "On")
	}

	_SetHotkey() {
		HotIfWinActive("ahk_id " this.hwnd)
		Hotkey("Escape", this.foDestroy, "On")
		this.gObj.OnEvent("Close", this.foDestroy)
	}

}