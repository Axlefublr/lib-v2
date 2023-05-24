#Include <Utils\Win>

class DS4 {

	static exeTitle := "ahk_exe DS4Windows.exe"
	static winTitle := "DS4Windows " this.exeTitle
	static path := A_ProgramFiles "\DS4Windows\DS4Windows.exe"

	static winObj := Win({
		winTitle: this.winTitle,
		exePath: this.path
	})
}