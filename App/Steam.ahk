#Include <Utils\Win>
#Include <Paths>

Class Steam {
	
	static processExe := "steam.exe"
	static exeTitle := "ahk_exe " this.processExe
	static winTitle := this.exeTitle
	static path     := "C:\Programs\Steam\steam.exe"
	static toClose  := ["Steam - News", "Special offers"]

	static winObj := Win({
		winTitle: this.exeTitle,
		exePath:  this.path,
		toClose:  this.toClose
	})
	
	static Close() {
		this.winObj.Close()
		ProcessClose(this.processExe)
	}
}