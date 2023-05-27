#Include <Utils\Win>
#Include <System\UIA>

class Browser {

	static exeTitle := "ahk_exe msedge.exe"
	static winTitle := "Edge " this.exeTitle
	static path     := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
	static excludeTitle := "live_chat?is_popout"

	; static exeTitle := "ahk_exe firefox.exe"
	; static winTitle := "Mozilla Firefox " this.exeTitle
	; static path     := "C:\Program Files\Mozilla Firefox\firefox.exe"

	; static exeTitle := "ahk_exe chrome.exe"
	; static winTitle := "Google Chrome " this.exeTitle
	; static path := "C:\Program Files\Google\Chrome\Application\chrome.exe"

	static winObj := Win({
		winTitle: this.winTitle,
		exePath: this.path,
		excludeTitle: this.excludeTitle
	})

	class Chat extends Browser {

		static winTitle := Browser.excludeTitle " " super.exeTitle

		static winObj := Win({
			winTitle: this.winTitle
		})
	}

	/*
	*
	* Run("https://link.com") will run the link, but the browser might not get focused. This function makes sure it does
	* @param {String} link
	*/
	static RunLink(link) {
		Run(link)
		WinWait(this.winTitle)
		WinActivate(this.winTitle)
	}

	static FullScreen() => Send("{F11}")
	static SearchTabs() => Send("^+a")

}
