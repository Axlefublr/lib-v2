#Include <Paths>
#Include <Utils\Win>

class Explorer {

	static process := "explorer.exe"
	static exeTitle := "ahk_exe " this.process
	static winTitle := "ahk_class CabinetWClass " this.exeTitle
	static position := "ThirtyVert"

	static winObj := Win({
		winTitle: this.winTitle,
		exePath:  this.process,
		runOpt:   "Min",
		position: this.position
	})

	class WinObjs {

		static PC := Win({
			winTitle: Explorer.winTitle,
			exePath:  Explorer.process,
			runOpt:   "Min",
			position: Explorer.position
		})
		static User := Win({
			winTitle: Explorer.winTitle,
			exePath:  Paths.User,
			runOpt:   "Min",
			position: Explorer.position
		})

		static Volume       := Win({exePath: "C:\",              position: Explorer.position})
		static Pictures     := Win({exePath: Paths.Pictures,     position: Explorer.position})
		static VideoTools   := Win({exePath: Paths.VideoTools,   position: Explorer.position})
		static Memes        := Win({exePath: Paths.Memes,        position: Explorer.position})
		static Emoji        := Win({exePath: Paths.Emoji,        position: "UpThirtyVert"})
		static Audio        := Win({exePath: Paths.Audio,        position: Explorer.position})
		static ScreenVideos := Win({exePath: Paths.ScreenVideos, position: Explorer.position})
		static Content      := Win({exePath: Paths.Content,      position: Explorer.position})
		static Tree         := Win({exePath: Paths.Tree,         position: Explorer.position})
		static Other        := Win({exePath: Paths.Other,        position: Explorer.position})
		static OnePiece     := Win({exePath: Paths.OnePiece,     position: Explorer.position})
		static Logos        := Win({exePath: Paths.Logos,        position: Explorer.position})
		static Themes       := Win({exePath: Paths.Themes,       position: Explorer.position})
		static Prog         := Win({exePath: Paths.Prog,         position: Explorer.position})

	}
}