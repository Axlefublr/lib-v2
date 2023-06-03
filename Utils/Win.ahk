#Include <Extensions\Initializable>

class Win extends Initializable {

	winTitle        := "A"
	winText         := ""
	excludeTitle    := ""
	excludeText     := ""
	winTitles       := []
	exePath         := ""
	startIn         := ""
	runOpt          := ""
	waitTime        := 120
	toClose         := ""
	startupWintitle := ""
	position        := ""
	makeAlwaysOnTop := false

	/**
	* @param {Object} paramsObject Key value pairs for properties of the class you want to set. Essentially, this is an initializer
	* @extends {Initializable}
	* @throws {TypeError} If you didn't pass an object
	* @example <caption>Create a Win object for the Spotify window and activate it, even if the window doesn't exist yet</caption>
	* Win({
	* exePath: A_AppData "\Spotify\Spotify.exe",
	* winTitle: "ahk_exe Spotify.exe"
	* }).RunAct()
	*/
	__New(paramsObject?) {
		if !IsSet(paramsObject) {
			return
		}
		if Type(paramsObject) != "Object" {
			throw TypeError("Specify an object.`nYou specified: " Type(paramsObject), -1, "paramsObject")
		}
		this.Initialize(paramsObject)
	}

	class Testing {
		static NoExePath() {
			throw TargetError("Specify a file path", -1)
		}

		static WrongType_toClose() {
			throw TypeError(
				"Win.toClose has to either be an array or a string",
				-1,
				this.toClose " : " Type(this.toClose)
			)
		}
	}

	SetExplorerWintitle() => this.winTitle := this.exePath " ahk_exe explorer.exe"

	Close() {
		try PostMessage("0x0010",,,, this.winTitle)
		catch Any {
			return false
		}
		return true
	}

	CloseAll() {
		while this.Close() {
		}
	}

	static Close(winTitle := "A") {
		Win({winTitle: winTitle}).Close()
	}

	Activate() {
		try {
			WinActivate(this.winTitle,, this.excludeTitle)
			WinWaitActive(this.winTitle,, this.excludeTitle)
			return true
		} catch Any {
			return false
		}
	}

	/**
	* What if there a multiple windows that match the same wintitle?
	* This method is an option to activate the second one if the first one is active, and the other way around
	* Supports as many same windows as you want. The time complexity is O(n)
	* If this concerns you, consider having less windows
	* @returns {Boolean} False if there were less than 2 windows that matched (there could be zero); True if the operation completed successfully
	*/
	ActivateAnother() {
		windows := WinGetList(this.winTitle,, this.excludeTitle)
		if (windows.Length < 2) {
			return false
		}
		temp := this.winTitle
		id   := WinGetID("A")
		i := -1
		inverseLength := -windows.Length
		while i > inverseLength {
			if windows[i] != id {
				this.winTitle := windows[i]
				break
			}
			i--
		}
		this.Activate()
		this.winTitle := temp
		return true
	}

	MinMax() {
		Thread("Priority", 8)
		if !WinExist(this.winTitle,, this.excludeTitle)
			return false

		if WinActive(this.winTitle,, this.excludeTitle) {
			if !this.ActivateAnother()
				WinMinimize(this.winTitle, this.winText, this.excludeTitle, this.excludeText)
		}
		else
			this.Activate()
		return true
	}

	Run() {
		if WinExist(this.winTitle,, this.excludeTitle)
			return false
		if !this.exePath {
			Win.Testing.NoExePath()
		}
		Run(this.exePath, this.startIn, this.runOpt ? this.runOpt : "Max")
		WinWait(this.startupWintitle ? this.startupWintitle : this.winTitle,, this.waitTime, this.excludeTitle)
		if this.toClose {
			this.CloseOnceExists()
		}
		return true
	}

	CloseOnceExists() {
		stopWaitingAt := A_TickCount + this.waitTime * 1000
		if Type(this.toClose) = "Array"
			SetTimer(foTryCloseArray, 20)
		else if Type(this.toClose) = "String"
			SetTimer(foTryClose, 20)
		else if !this.toClose
			Win.Testing.WrongType_toClose()
		else
			Win.Testing.WrongType_toClose()

		foTryCloseArray() {
			for key, value in this.toClose {
				if WinExist(value) {
					Win.Close(value)
					SetTimer(, 0)
				}
			}
			if A_TickCount >= stopWaitingAt {
				SetTimer(, 0)
			}
		}
		foTryClose() {
			if WinExist(this.toClose) {
				Win.Close(this.toClose)
				SetTimer(, 0)
			}
			else if A_TickCount >= stopWaitingAt {
				SetTimer(, 0)
			}
		}
	}

	static CloseOnceInactive(winTitle := WinGetID("A")) => Win({winTitle: winTitle}).CloseOnceInactive()

	CloseOnceInactive() {
		_Checker() {
			if !WinActive(this.winTitle,, this.excludeTitle) {
				this.Close()
				SetTimer(, 0)
			}
		}
		SetTimer(_Checker, 1)
	}

	RunAct() {
		Thread("Priority", 8)
		this.Run()
		if this.startupWintitle {
			temp := this.winTitle
			this.winTitle := this.startupWintitle
		}
		this.Activate()
		if this.startupWintitle {
			this.winTitle := temp
		}
		if this.position {
			WindowManager(this.winTitle, this.excludeTitle).%this.position%()
		}
		if this.makeAlwaysOnTop {
			WinSetAlwaysOnTop(1, this.winTitle, this.winText, this.excludeTitle, this.excludeText)
		}
		return this
	}

	RunAct_Folders() {
		this.SetExplorerWintitle()
		if !this.runOpt {
			this.runOpt := "Min"
		}
		this.RunAct()
		return this
	}

	App() {
		Thread("Priority", 9)
		if this.MinMax()
			return this
		this.RunAct()
		return this
	}

	App_Folders() {
		this.SetExplorerWintitle()
		if !this.runOpt {
			this.runOpt := "Min"
		}
		this.App()
		return this
	}

	ActiveRegex() {
		SetTitleMatchMode("RegEx")
		return WinActive(this.winTitle, this.winText, this.excludeTitle, this.excludeText)
	}

	static ActiveRegex(winTitle := "A", winText?, excludeTitle?, excludeText?) {
		SetTitleMatchMode("RegEx")
		return WinActive(winTitle, winText?, excludeTitle?, excludeText?)
	}

	/**
	* Specify an array of winTitles, will return 1 if one of them is active
	* Specify a map if you want to have a "exception" for one, some, or all of your winTitles
	* @param winTitles *Array/Map*
	* @returns {Integer}
	*/
	AreActive() {
		i := 0
		for key, value in this.winTitles {
			if Type(this.winTitles) = "Map" {
				if WinActive(key,, value)
					i++
			} else if Type(this.winTitles) = "Array" {
				if WinActive(value)
					i++
			}
		}
		return i
	}
}
