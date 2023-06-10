#Include <Utils\Win>
#Include <Tools\Info>
#Include <Paths>
#Include <Utils\Wait>

class Davinci {

	static exeTitle     := "ahk_exe Resolve.exe"
	static winTitle     := "DaVinci Resolve " this.exeTitle
	static projectTitle := "Project Manager " this.exeTitle
	static loadingTitle := "Resolve"
	static exePath      := A_ProgramFiles "\Blackmagic Design\DaVinci Resolve\Resolve.exe"
	static closeWindow  := "Message " this.exeTitle

	static winObj := Win({
		winTitle:        this.winTitle,
		exePath:         this.exePath,
		startupWintitle: this.loadingTitle,
	})

	static Close() {
		this.winObj.Close()
		static _action() {
			Win({ winTitle: Davinci.closeWindow }).Activate()
			Send("{Left 2}{Enter}")
		}
		Wait(WinExist.Bind(this.closeWindow), _action , this.winObj.extTimeout)
	}

	static Insert() {
		if !this.winObj.Activate() {
			Info("Window could not be activated")
			return
		}
		ControlClick("X79 Y151", this.winTitle, , "R")
		Send("{Down 2}{Enter}")
		if !WinWaitActive("New Timeline Properties", , 3)
			return
		Send("{Enter}")
	}

}