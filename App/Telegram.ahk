#Include <Utils\Win>

class Telegram {

	static processExe := "Telegram.exe"
	static exeTitle := "ahk_exe " this.processExe
	static winTitle := this.exeTitle
	static path := A_AppData "\Telegram Desktop\Telegram.exe"

	static winObj := Win({
		winTitle: this.winTitle,
		exePath: this.path
	})

	static Close() {
		this.winObj.Close()
		ProcessClose(this.processExe)
	}
}
