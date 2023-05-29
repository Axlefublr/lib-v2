#Include <Extensions\Gui>

class CleanInputBox extends Gui {

	Width     := Round(A_ScreenWidth  / 1920 * 1200)
	TopMargin := Round(A_ScreenHeight / 1080 * 800)

	/**
	 * Get a gui to type into.
	 * Close it by pressing Escape. (This exits the entire thread)
	 * Accept your input by pressing Enter.
	 * Call WaitForInput() after creating the class instance.
	 */
	__New() {
		super.__New("AlwaysOnTop -Caption")
		this.DarkMode().MakeFontNicer(30)
		this.MarginX := 0

		this.InputField := this.AddEdit(
			"x0 Center -E0x200 Background"
			this.BackColor " w" this.Width
		)

		this.Input := ""
		this.isWaiting := true
		this.RegisterHotkeys()
	}

	Show() => (super.Show("y" this.TopMargin " w" this.Width), this)

	/**
	 * Occupy the thread until you type in your input and press
	 * Enter, returns this input
	 * @returns {String}
	 */
	WaitForInput() {
		this.Show()
		while this.isWaiting {
		}
		return this.Input
	}

	SetInput() {
		this.Input := this.InputField.Text
		this.isWaiting := false
		this.Finish()
	}

	SetCancel() {
		this.isWaiting := false
		this.Finish()
	}

	RegisterHotkeys() {
		HotIfWinactive("ahk_id " this.Hwnd)
		Hotkey("Enter", (*) => this.SetInput(), "On")
		this.OnEvent("Escape", (*) => this.SetCancel())
	}

	Finish() {
		HotIfWinactive("ahk_id " this.Hwnd)
		Hotkey("Enter", "Off")
		this.Minimize()
		this.Destroy()
	}
}
