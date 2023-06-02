#Include <Utils\Win>

class Gimp {

	static process      := "gimp-2.10.exe"
	static exeTitle     := "ahk_exe " this.process
	static winTitle     := this.exeTitle
	static path         := A_ProgramFiles "\GIMP 2\bin\gimp-2.10.exe"
	static excludeTitle := "GIMP Startup"
	static toClose      := ""
	static closeWindow  := "Quit GIMP " this.exeTitle
	static position     := "SeventyVert"

	static winObj := Win({
		winTitle:     this.winTitle,
		exePath:      this.path,
		toClose:      this.toClose,
		excludeTitle: this.excludeTitle,
		position:     this.position
	})

	static Close() {
		this.winObj.Close()
		ProcessClose(this.process)
	}
}