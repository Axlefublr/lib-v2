#Include <Paths>
#Include <Utils\Win>

class OBS {

	static exeTitle := "ahk_exe obs64.exe"
	static winTitle := "OBS " this.exeTitle
	static path     := A_ProgramFiles "\obs-studio\bin\64bit\obs64.exe"
	static startIn  := A_ProgramFiles "\obs-studio\bin\64bit"

	static winObj := Win({
		winTitle: this.winTitle,
		exePath: this.path,
		startIn: this.startIn
	})

}