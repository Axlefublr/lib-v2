#Include <Utils\Win>

class Player {
	static exeTitle := "ahk_exe mpc-hc64.exe"
	static winTitle := this.exeTitle

	static winObj := Win({winTitle: this.winTitle})
}