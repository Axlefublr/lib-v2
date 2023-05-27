#Include <Utils\Win>
#Include <Paths>
#Include <Utils\Image>

class Discord {

	static exeTitle := "ahk_exe Discord.exe"
	static winTitle := "Discord " this.exeTitle
	static excludeTitle := "Updater"	;Don't consider the window to be discord if it has this in its title
	static path := Paths.LocalAppData "\Discord\app-1.0.9013\Discord.exe"

	static winObj := Win({
		winTitle:  this.winTitle,
		exePath:   this.path,
		excludeTitle: this.excludeTitle
	})

	static ToggleMentions() => ControlClick("x1788 y962")

	static PrevChannel() => Send("!{Up}")

	static NextChannel() => Send("!{Down}")

	static PrevUnreadChannel() => Send("+!{Up}")

	static NextUnreadChannel() => Send("+!{Down}")

	static PrevServer() => Send("^!{Up}")

	static NextServer() => Send("^!{Down}")
}
