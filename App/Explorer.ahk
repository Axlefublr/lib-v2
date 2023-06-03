#Include <Paths>
#Include <Utils\Win>

class Explorer {

	static process       := "explorer.exe"
	static exeTitle      := "ahk_exe " this.process
	static winTitle      := "ahk_class CabinetWClass " this.exeTitle
	static position      := "ThirtyVert"
	static isAlwaysOnTop := true
	static runOpt        := "Min"

	static winObj := Win({
		winTitle:      this.winTitle,
		exePath:       this.process,
		runOpt:        this.runOpt,
		position:      this.position,
		isAlwaysOnTop: this.isAlwaysOnTop
	})

	class WinObjs {

		static PC := Win({
			winTitle:      Explorer.winTitle,
			exePath:       Explorer.process,
			runOpt:        Explorer.runOpt,
			position:      Explorer.position,
			isAlwaysOnTop: Explorer.isAlwaysOnTop
		})
		static User := Win({
			winTitle:      Explorer.winTitle,
			exePath:       Paths.User,
			runOpt:        Explorer.runOpt,
			position:      Explorer.position,
			isAlwaysOnTop: Explorer.isAlwaysOnTop
		})

		static Volume       := Win({exePath: "C:\"})
		static Pictures     := Win({exePath: Paths.Pictures})
		static VideoTools   := Win({exePath: Paths.VideoTools})
		static Memes        := Win({exePath: Paths.Memes})
		static Audio        := Win({exePath: Paths.Audio})
		static ScreenVideos := Win({exePath: Paths.ScreenVideos})
		static Content      := Win({exePath: Paths.Content})
		static Tree         := Win({exePath: Paths.Tree})
		static Other        := Win({exePath: Paths.Other})
		static OnePiece     := Win({exePath: Paths.OnePiece})
		static Logos        := Win({exePath: Paths.Logos})
		static Themes       := Win({exePath: Paths.Themes})
		static Prog         := Win({exePath: Paths.Prog})
		static Emoji        := Win({exePath: Paths.Emoji})

	}
}