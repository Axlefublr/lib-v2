#Include <Abstractions\Mouse>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Utils\Win>
#Include <Utils\ClipSend>

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

	static NextChannel() => Send("!{Down}")
	static PrevChannel() => Send("!{Up}")

	static NextFolder() => Send("^+{Down}")
	static PrevFolder() => Send("^+{Up}")

	static Voice() => Mouse.ClickThenGoBack_Event("1452 1052")

	static Scroll() => ControlClick("X1434 Y964")
}
