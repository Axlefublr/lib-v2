#Include <Utils\Win>
#Include <Tools\Info>
#Include <Paths>

Class Davinci {
	static exeTitle := "ahk_exe Resolve.exe"
	static winTitle := "DaVinci Resolve " this.exeTitle
	static projectTitle := "Project Manager " this.exeTitle
	static path := "C:\Programs\Davinci Resolve\Resolve.exe"
	static closeWindow := "Message " this.exeTitle

	static winObj := Win({
		winTitle: this.winTitle,
		exePath: this.path
	})

	static projectWinObj := Win({
		winTitle: this.projectTitle,
		exePath: this.path
	})

	static Close() {
		this.winObj.Close()
		if !WinWait(this.closeWindow, , this.winObj.waitTime)
			return
		Win({ winTitle: this.closeWindow }).Activate()
		Send("{Left 2}{Enter}")
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

	static Setup() {
		if !this.winObj.Activate() {
			Info("No Davinci Resolve window!")
			return
		}
		this.winObj.RestoreDown()
		WinMove(-8, 0, 1492, A_ScreenHeight, this.winTitle)
		Explorer.WinObj.Pictures.RunAct_Folders()
		WinMove(1466, 0, 463, A_ScreenHeight)
		this.winObj.Activate()
	}

}