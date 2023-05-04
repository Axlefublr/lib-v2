#Include <Utils\Win>
#Include <Paths>

Class Steam {

	static process  := "steam.exe"
	static exeTitle := "ahk_exe " this.process
	static winTitle := this.exeTitle
	static path     := "C:\Programs\Steam\steam.exe"
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