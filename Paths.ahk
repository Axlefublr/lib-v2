;No dependencies

Class Paths {

    static User         := "C:\Users\" A_UserName
    static LocalAppData := Paths.User "\AppData\Local"
    static System32     := "C:\Windows\System32"

    static Prog  := "C:\Programming"
    static Main  := "C:\Programming\main"
    static Lib   := A_MyDocuments "\AutoHotkey\Lib"
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
    static Tree         := Paths.Pictures "\Tree"
    static Memes        := Paths.Pictures "\Tree\Memes"
    static Emoji        := Paths.Pictures "\Tree\Emojis"
    static Other        := Paths.Pictures "\Tree\Other"
    static Logos        := Paths.Pictures "\Tree\Logos"

    static Audio := "C:\Audio"
    static Sounds := Paths.Audio "\Sounds"

    static StandardAhkLibLocation := A_MyDocuments "\AutoHotkey\Lib"

    static VsCodeExtensions := "C:\Users\" A_UserName "\.vscode-insiders\extensions"
    static SavedScreenshots := Paths.LocalAppData "\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip"

    static Ptf := Map(
        "playlist-sorter", Paths.Files "\Innit\playlist-sorter.txt",
        "test-state",      Paths.Files "\Innit\test-state.txt",
        "time-agent",      Paths.Files "\Innit\time-agent.txt",

        "BlankPic", Paths.Files "\img\BlankPic.png",

        "Hub", Paths.Main "\Hub.ahk",

        "Tests", Paths.Tools "\Tests.ahk",
        "Timer", Paths.Tools "\Timer.ahk",

        "AhkTest", Paths.Test "\AhkTest.ahk",

        "vine boom",         Paths.Sounds "\vine boom.wav",
        "faded than a hoe",  Paths.Sounds "\faded than a hoe.wav",
        "heheheha",          Paths.Sounds "\heheheha.wav",
        "shall we",          Paths.Sounds "\shall we.wav",
        "slip and crash",    Paths.Sounds "\slip and crash.wav",
        "cartoon running",   Paths.Sounds "\cartoon running.wav",
        "rizz",              Paths.Sounds "\rizz.wav",
        "bruh sound effect", Paths.Sounds "\bruh sound effect.wav",
        "cartoon",           Paths.Sounds "\cartoon.wav",
        "hohoho",            Paths.Sounds "\hohoho.wav",
        "bing chilling 1",   Paths.Sounds "\bing chilling 1.wav",
        "bing chilling 2",   Paths.Sounds "\bing chilling 2.wav",
        "oh fr on god",      Paths.Sounds "\oh fr on god.wav",
        "sus",               Paths.Sounds "\sus.wav",
        "i just farted",     Paths.Sounds "\i just farted.wav",
        "ting",              Paths.Sounds "\ting.wav",
        "shutter",           Paths.Sounds "\shutter.wav",
        "was that his cock", Paths.Sounds "\was that his cock.wav",
        "cyberpunk",         Paths.Sounds "\cyberpunk.wav",
        "better call saul",  Paths.Sounds "\better call saul short.wav",

        "Discovery log", Paths.Music "\Discovery log.txt",
        "Unfinished",    Paths.Music "\Unfinished.txt",
        "Rappers",       Paths.Music "\Rappers.txt",
        "Artists",       Paths.Music "\Favorites.md",

        "Shows",    Paths.Shows "\Shows.jsonc",
        "Consumed", Paths.Shows "\Consumed.md",

        "Diary",     Paths.Info "\Diary.md",
        "Events",    Paths.Info "\Events.jsonc",
        "Birthdays", Paths.Info "\Birthdays.jsonc",

        "femboy",       Paths.Memes "\femboy.png",
        "writing fire", Paths.Memes "\writing fire.jpg",
        "urethra",      Paths.Memes "\urethra.jpg",
        "welp",         Paths.Memes "\welp.jpg",
        "how did we get here", Paths.Memes "\how did we get here.jpeg",
        "do you have the slightest idea how little that narrows it down", Paths.Memes "\do you have the slightest idea how little that narrows it down.png",

    )

    static Apps := Map(

        "Sound mixer",       "SndVol.exe",
        "Slide to shutdown", "SlideToShutDown.exe",

    )
}
