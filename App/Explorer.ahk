#Include <Paths>
#Include <Utils\Win>

Class Explorer {

    static process := "explorer.exe"
    static exeTitle := "ahk_exe " this.process
    static winTitleRegex := "^[A-Z]:|Downloads|Documents|This PC|OneDrive|Network|Linux|Desktop|File Explorer ahk_exe explorer\.exe"

    static winObjRegex := Win({winTitle: this.winTitleRegex})

    Class WinObj {

        static PC               := Win({winTitle:Explorer.winTitleRegex, exePath: Explorer.process, runOpt: "Min"})

        static Volume           := Win({exePath: "C:\",              runOpt: "Min"})
        static Pictures         := Win({exePath: Paths.Pictures,     runOpt: "Min"})
        static VideoTools       := Win({exePath: Paths.VideoTools,   runOpt: "Min"})
        static Memes            := Win({exePath: Paths.Memes,        runOpt: "Min"})
        static Emoji            := Win({exePath: Paths.Emoji,        runOpt: "Min"})
        static Audio            := Win({exePath: Paths.Audio,        runOpt: "Min"})
        static ScreenVideos     := Win({exePath: Paths.ScreenVideos, runOpt: "Min"})
        static Content          := Win({exePath: Paths.Content,      runOpt: "Min"})

        static VsCodeExtensions := Win({exePath: Paths.VsCodeExtensions})
        static Prog             := Win({exePath: Paths.Prog})
        static SavedScreenshots := Win({exePath: Paths.SavedScreenshots})

    }
}