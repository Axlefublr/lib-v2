;No dependencies

class Paths {

	static User         := "C:\Users\" A_UserName
	static LocalAppData := Paths.User "\AppData\Local"
	static System32     := "C:\Windows\System32"

	static StandardAhkLibLocation := A_MyDocuments "\AutoHotkey\Lib"

	static Prog  := "C:\Programming"
	static Main  := "C:\Programming\main"
	static Lib   := Paths.StandardAhkLibLocation
	static Music := "C:\Programming\music"
	static Shows := "C:\Programming\shows"
	static Info  := "C:\Programming\info"
	static Test  := "C:\Programming\test"
	static Reg   := "C:\Programming\registers"

	static Files     := Paths.Main "\Files"
	static Tools     := Paths.Main "\Tools"

	static Pictures     := "C:\Pictures"
	static Content      := Paths.Pictures "\Content"
	static OnePiece     := Paths.Pictures "\Content\One piece"
	static VideoTools   := Paths.Pictures "\Tools"
	static ScreenVideos := Paths.Pictures "\Screenvideos"
	static Downloaded   := Paths.Pictures "\Downloaded"
	static Tree         := Paths.Pictures "\Tree"
	static Memes        := Paths.Pictures "\Tree\Memes"
	static Emoji        := Paths.Pictures "\Tree\Emojis"
	static Other        := Paths.Pictures "\Tree\Other"
	static Logos        := Paths.Pictures "\Tree\Logos"
	static Themes       := Paths.Pictures "\Tree\Themes"

	static Audio := "C:\Audio"
	static Sounds := Paths.Audio "\Sounds"

	static VsCodeExtensions := "C:\Users\" A_UserName "\.vscode-insiders\extensions"
	static SavedScreenshots := Paths.LocalAppData "\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip"

	static Ptf := Map(
		"playlist-sorter", Paths.Files "\Innit\playlist-sorter.txt",
		"test-state",      Paths.Files "\Innit\test-state.txt",
		"time-agent",      Paths.Files "\Innit\time-agent.txt",

		"BlankPic", Paths.Files "\img\BlankPic.png",

		"Hub", Paths.Main "\Hub.ahk",

		"AhkTest", Paths.Test "\AhkTest.ahk",

		"ting", Paths.Sounds "\ting.wav",

		"Discovery log", Paths.Music "\Discovery log.txt",
		"Unfinished",    Paths.Music "\Unfinished.txt",
		"Rappers",       Paths.Music "\Rappers.txt",
		"Artists",       Paths.Music "\Favorites.md",

		"Shows",    Paths.Shows "\Shows.jsonc",
		"Consumed", Paths.Shows "\Consumed.md",

		"Diary",     Paths.Info "\diary.md",
		"Events",    Paths.Info "\events.jsonc",
		"Birthdays", Paths.Info "\birthdays.jsonc",
	)

	static Apps := Map(
		"Slide to shutdown", "SlideToShutDown.exe",
	)
}
