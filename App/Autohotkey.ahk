#Include <Utils\Win>

class Autohotkey {

	static path := A_ProgramFiles "\AutoHotkey"
	static currVersion := this.path "\v2"
	static processExe := A_AhkPath
	static exeTitle := "ahk_exe " this.processExe

	class Docs extends Autohotkey {

		static exeTitle := "ahk_exe hh.exe"
		static winTitle := "AutoHotkey v2 Help " super.exeTitle
		static path := super.currVersion "\AutoHotkey.chm"

		static winObj := Win({
			winTitle: this.winTitle,
			exePath: this.path
		})

	}
}