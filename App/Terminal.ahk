#Include <Utils\Win>

class Terminal {

	static exeTitle := "ahk_exe WindowsTerminal.exe"
	static class    := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"
	static winTitle := this.class " " this.exeTitle
	static excludeTitle := "Cmd( Admin)?|PowerShell( Admin)?"
	static path := "wt.exe"

	static winObj := Win({
		winTitle: this.winTitle,
		exePath: this.path,
		excludeTitle: this.excludeTitle
	})

	static DeleteWord() => Send("^w")
}