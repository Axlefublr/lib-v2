#Include <Utils\Win>
#Include <Abstractions\Text>
#Include <Tools\Info>
#Include <Extensions\String>
#Include <Paths>

class VsCode {

	static exeTitle := "ahk_exe Code - Insiders.exe"
	static winTitle := "Visual Studio Code " this.exeTitle
	static path := "C:\Users\" A_UserName "\AppData\Local\Programs\Microsoft VS Code Insiders\Code - Insiders.exe"
	static exception := "VsCodeIntegratedTerminal"

	static winObj := Win({
		winTitle: this.winTitle,
		exePath:  this.path,
	})

	static CloseAllTabs()  => Send("+!w")
	static Reload()        => Send("+!y+!y")
	static CloseTab()      => Send("!w")

}
