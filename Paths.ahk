;No dependencies

Class Paths {

    static LocalAppData := "C:\Users\" A_UserName "\AppData\Local"
    static System32     := "C:\Windows\System32"

    static Prog  := "C:\Programming"
    static Main  := "C:\Programming\main"
    static Lib   := A_MyDocuments "\AutoHotkey\Lib"
    static Music := "C:\Programming\music"
    static Shows := "C:\Programming\shows"
    static YtDev := "C:\Programming\yt-dev"
    static Info  := "C:\Programming\info"
    static Test  := "C:\Programming\test"
    static Reg   := "C:\Programming\registers"

    static Backups   := Paths.Main "\Backups"
    static Docs      := Paths.Main "\Docs"
    static Files     := Paths.Main "\Files"
    static Images    := Paths.Main "\Files\Images"
    static Notes     := Paths.Main "\Notes"
    static NotesTemp := Paths.Main "\Notes temp"
    static Tools     := Paths.Main "\Tools"

    static Pictures     := "C:\Pictures"
    static Content      := Paths.Pictures "\Content"
    static VideoTools   := Paths.Pictures "\Tools"
    static ScreenVideos := Paths.Pictures "\Screenvideos"
    static Tree         := Paths.Pictures "\Tree"
    static Memes        := Paths.Pictures "\Tree\Memes"
    static Emoji        := Paths.Pictures "\Tree\Emojis"

    static Audio := "C:\Audio"

    static StandardAhkLibLocation := A_MyDocuments "\AutoHotkey\Lib"

    static VsCodeExtensions := "C:\Users\" A_UserName "\.vscode\extensions"
    static SavedScreenshots := Paths.LocalAppData "\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip"

    static Ptf := Map(
        "Main", Paths.Main "\.vscode\main.code-workspace",

        "playlist-sorter", Paths.Main "\Files\Innit\playlist-sorter.txt",
        "test-state",      Paths.Main "\Files\Innit\test-state.txt",
        "time-agent",      Paths.Main "\Files\Innit\time-agent.txt",

        "BlankPic", Paths.Main "\Files\img\BlankPic.png",

        "Hub", Paths.Main "\Hub.ahk",

        "Tests", Paths.Main "\Tools\Tests.ahk",
        "Timer", Paths.Main "\Tools\Timer.ahk",

        "AhkTest", Paths.Test "\AhkTest.ahk",

        "vine boom",         Paths.Audio "\Sounds\vine boom.wav",
        "faded than a hoe",  Paths.Audio "\Sounds\faded than a hoe.wav",
        "heheheha",          Paths.Audio "\Sounds\heheheha.wav",
        "shall we",          Paths.Audio "\Sounds\shall we.wav",
        "slip and crash",    Paths.Audio "\Sounds\slip and crash.wav",
        "cartoon running",   Paths.Audio "\Sounds\cartoon running.wav",
        "rizz",              Paths.Audio "\Sounds\rizz.wav",
        "bruh sound effect", Paths.Audio "\Sounds\bruh sound effect.wav",
        "cartoon",           Paths.Audio "\Sounds\cartoon.wav",
        "hohoho",            Paths.Audio "\Sounds\hohoho.wav",
        "bing chilling 1",   Paths.Audio "\Sounds\bing chilling 1.wav",
        "bing chilling 2",   Paths.Audio "\Sounds\bing chilling 2.wav",
        "oh fr on god",      Paths.Audio "\Sounds\oh fr on god.wav",
        "sus",               Paths.Audio "\Sounds\sus.wav",
        "i just farted",     Paths.Audio "\Sounds\i just farted.wav",
        "ting",              Paths.Audio "\Sounds\ting.wav",
        "shutter",           Paths.Audio "\Sounds\shutter.wav",

        "Discovery log", Paths.Music "\Discovery log.txt",
        "Unfinished",    Paths.Music "\Unfinished.txt",
        "Rappers",       Paths.Music "\Rappers.txt",
        "Artists",       Paths.Music "\Favorites.md",

        "Shows",    Paths.Shows "\Shows.jsonc",
        "Consumed", Paths.Shows "\Consumed.md",

        "Diary",     Paths.Info "\Diary.md",
        "Events",    Paths.Info "\Events.jsonc",
        "Birthdays", Paths.Info "\Birthdays.jsonc",

        "FL preset", Paths.Pictures "\Tools\FL preset.flp",

        "femboy",       Paths.Pictures "\Tree\Memes\femboy.png",
        "writing fire", Paths.Pictures "\Tree\Memes\writing fire.jpg",
        "urethra",      Paths.Pictures "\Tree\Memes\urethra.jpg",
        "welp",         Paths.Pictures "\Tree\Memes\welp.jpg",
        "how did we get here", Paths.Pictures "\Tree\Memes\how did we get here.jpeg",
        "do you have the slightest idea how little that narrows it down", Paths.Pictures "\Tree\Memes\do you have the slightest idea how little that narrows it down.png",

    )

    static Apps := Map(

        "Sound mixer",       "SndVol.exe",
        "Slide to shutdown", "SlideToShutDown.exe",

    )
}
