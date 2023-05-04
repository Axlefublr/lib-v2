#Include <Abstractions\GetPicSize>
#Include <Utils\GetFilesSortedByDate>
#Include <Extensions\Gui>
#Include <Paths>

/**
 * Make a picture of your choosing appear on your screen
 */
class HoverScreenshot {

	static ActualScreenDpi := Round(A_ScreenDPI / 25) * 25 / 100

	/**
	 * Full path to the picture you want to hover (show).
	 * @type {String}
	 */
	picturePath := ""

	/**
	 * The gui object
	 * Will be set in the constructor of the class
	 * @type {Gui}
	 */
	gHover := unset

	/**
	 * The guictrl object of the picture
	 * Will be set after Show() is called on the class instance
	 * @type {GuiCtrl}
	 */
	gcPicture := unset

	guiHwnd := unset

	/**
	 * Make a picture of your choosing appear on your screen
	 * @example <caption>Choose a picture to hover and do so</caption>
	 * gHover := HoverScreenshot()
	 * if gHover := gHover.SelectPath()
	 *    gHover.Show()
	 * ; or this syntax:
	 * try HoverScreenshot().SelectPath().Show()
	 * @example <caption>Always show the same picture, the path of which you already know</caption>
	 * gHover := HoverScreenshot()
	 * gHover.picturePath := "C:\Pictures\My favorite picture 257.png"
	 * gHover.Show()
	 */
	__New(picturePath?) {
		this.gHover := Gui("AlwaysOnTop -Caption")
		this.guiHwnd := this.gHover.Hwnd
		this.picturePath := picturePath ?? ""
	}

	/**
	 * Brings up an interactive menu where the user can pick the picture to show
	 * (sets the picturePath property).
	 * Will always start in the folder where windows stores your Win+Shift+S screenshots,
	 * filtering only pngs (since there are only pngs there).
	 * You can still go and pick a picture from any other place, just make sure the format is
	 * supported
	 * @returns {Boolean/HoverScreenshot} `this` if you picked something, false if you didn't
	 */
	SelectPath(startingDir?) {
		picturePath := FileSelect(, startingDir?,, "*.png")
		if picturePath {
			this.picturePath := picturePath
			return this
		}
		return false
	}

	UseRecentScreenshot() {
		picturesArr := GetFilesSortedByDate(Paths.SavedScreenshots "\*.png")
		for , picturePath in picturesArr {
			size := GetPicSize(picturePath)
			if size.Width = 364 * HoverScreenshot.ActualScreenDpi && size.Height = 180 * HoverScreenshot.ActualScreenDpi
				continue
			this.picturePath := picturePath
			return this
		}
	}

	/**
	 * Shows the gui with the picture you set
	 * Before calling this method, make sure you set the picturePath property to the path of the
	 * picture you want to show
	 * @throws {MethodError} If the picturePath property is not a path / not set
	 */
	Show() {
		if !(this.picturePath ~= "^[A-Z]:\\") {
			HoverScreenshot.Exceptions.PicturePathWrong(this.picturePath)
		}
		this.gcPicture := this.gHover.AddPicture(, this.picturePath)
		this.gHover.BackColor := 808080
		WinSetTransColor(808080, this.gHover.Hwnd)

		this._SetOnevents()

		this.gHover.Show("AutoSize")
		return this
	}

	Destroy() {
		HotIfWinExist("ahk_id " this.guiHwnd)
		Hotkey("^Escape", this._foDestroy, "Off")
		this.gHover.Minimize()
		this.gHover.Destroy()
	}


	_foDestroy := (*) => this.Destroy()

	_SetOnevents() {
		HotIfWinExist("ahk_id " this.guiHwnd)
		Hotkey("^Escape", this._foDestroy, "On")

		this.gcPicture.OnEvent("DoubleClick", (*) => this.Destroy())
		this.gcPicture.OnEvent("Click",       (guiCtrlObj, *) => guiCtrlObj.Gui.PressTitleBar())
		this.gHover.OnEvent("Close", (*) => this.Destroy())
	}


	class Exceptions {
		/**
		 * Throw this if the picturePath property is not set / is not a path
		 * @param picturePath pass the current picturePath to show in the error message
		 * @throws {MethodError}
		 */
		static PicturePathWrong(picturePath) {
			throw MethodError("
				(
					You didn't set a picture path to show
					Use the "SelectPath()" method to let the user pick the picture to show in a menu interactively
					Set the "picturePath" property manually if you have your own way of getting the path
				)",
				-2,
				"
				(
					picturePath property
					value:
				)" picturePath "`n" "
				(
					type:
				)" Type(picturePath)
			)
		}
	}
}