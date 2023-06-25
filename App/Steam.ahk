#Include <Utils\Win>
#Include <Paths>

class Steam {

	static process  := "steam.exe"
	static exeTitle := "ahk_exe steamwebhelper.exe"
	static winTitle := this.exeTitle
	static path     := "C:\Program Files (x86)\Steam\steam.exe"
	static toClose  := ["Steam - News", "Special Offers"]

	static winObj := Win({
		winTitle: this.exeTitle,
		exePath:  this.path,
		toClose:  this.toClose
	})

	static Close() {
		this.winObj.Close()
		ProcessClose(this.process)
	}
}