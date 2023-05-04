#Include <Paths>
#Include <Utils\Win>

Class Explorer {

    static process := "explorer.exe"
    static exeTitle := "ahk_exe " this.process
    static winTitle := "ahk_class CabinetWClass " this.exeTitle

    static winObj := Win({
        winTitle: this.winTitle,
        exePath: this.process,
        runOpt: "Min"
    })

    Class WinObjs {

        static PC := Win({
            winTitle: Explorer.winTitle,
            exePath:  Explorer.process,
            runOpt:   "Min"
        })
        static User := Win({
            winTitle: Explorer.winTitle,
            exePath:  Paths.User,
            runOpt:   "Min"
        })

        static Volume       := Win({exePath: "C:\",              runOpt: "Min"})
        static Pictures     := Win({exePath: Paths.Pictures,     runOpt: "Min"})
        static VideoTools   := Win({exePath: Paths.VideoTools,   runOpt: "Min"})
        static Memes        := Win({exePath: Paths.Memes,        runOpt: "Min"})
        static Emoji        := Win({exePath: Paths.Emoji,        runOpt: "Min"})
        static Audio        := Win({exePath: Paths.Audio,        runOpt: "Min"})
        static ScreenVideos := Win({exePath: Paths.ScreenVideos, runOpt: "Min"})
        static Content      := Win({exePath: Paths.Content,      runOpt: "Min"})
        static Tree         := Win({exePath: Paths.Tree,         runOpt: "Min"})
        static Other        := Win({exePath: Paths.Other,        runOpt: "Min"})
        static OnePiece     := Win({exePath: Paths.OnePiece,     runOpt: "Min"})
        static Logos        := Win({exePath: Paths.Logos,        runOpt: "Min"})

        static VsCodeExtensions := Win({exePath: Paths.VsCodeExtensions})
        static Prog             := Win({exePath: Paths.Prog})
        static SavedScreenshots := Win({exePath: Paths.SavedScreenshots})

    }
}