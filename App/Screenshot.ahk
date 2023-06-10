#Include <Abstractions\Mouse> ; Needed for ClickThenGoBack to click screenshot mode buttons

class Screenshot {

	static exeTitle  := "ahk_exe ScreenClippingHost.exe"
	static winTitle  := "Screen Snipping " this.exeTitle
	static saveTitle := "Snip & Sketch ahk_exe ApplicationFrameHost.exe"
	static exePath   := "explorer ms-screenclip:"
	
	static winObj := Win({
		winTitle: this.winTitle,
		exePath: this.exePath
	})

	static Start()         => Send("#+s")
	static CaptureWindow() => Send("!{Printscreen}")
	static CaptureScreen() => Send("+{Printscreen}")

	static Rectangle()  => this.UIA.Rectangle.ToggleState := true
	static FreeForm()   => this.UIA.FreeForm.ToggleState  := true
	static Window()     => this.UIA.Window.ToggleState    := true
	static Fullscreen() => this.UIA.FullScreen.Click()

	class UIA {

		static MainElement {
			get => UIA.ElementFromHandle(Screenshot.winTitle).FindElement({
				LocalizedType: "Keyboard Snipping Area",
				Scope: 2
			})
		}

		static Rectangle {
			get => this.MainElement.FindElement({
				Name: "Rectangular Snip"
			})
		}

		static FreeForm {
			get => this.MainElement.FindElement({
				Name: "Freeform Snip"
			})
		}

		static Window {
			get => this.MainElement.FindElement({
				Name: "Window Snip"
			})
		}

		static FullScreen {
			get => this.MainElement.FindElement({
				Name: "Fullscreen Snip"
			})
		}

	}
}