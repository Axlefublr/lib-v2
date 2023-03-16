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

    static Backups   := this.Main "\Backups"
    static Docs      := this.Main "\Docs"
    static Files     := this.Main "\Files"
    static Images    := this.Main "\Files\Images"
    static Notes     := this.Main "\Notes"
    static NotesTemp := this.Main "\Notes temp"
    static Tools     := this.Main "\Tools"

    static Pictures     := "C:\Pictures"
    static Content      := this.Pictures "\Content"
    static VideoTools   := this.Pictures "\Tools"
    static ScreenVideos := this.Pictures "\Screenvideos"
    static Memes        := this.Pictures "\Tree\Memes"
    static Emoji        := this.Pictures "\Tree\Emojis"

    static Audio := "C:\Audio"

    static StandardAhkLibLocation := A_MyDocuments "\AutoHotkey\Lib"

    static VsCodeExtensions := "C:\Users\" A_UserName "\.vscode\extensions"
    static SavedScreenshots := this.LocalAppData "\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip"

    static Ptf := Map(
        "Main", this.Main "\.vscode\main.code-workspace",

        "playlist-sorter", this.Main "\Files\Innit\playlist-sorter.txt",
        "test-state",      this.Main "\Files\Innit\test-state.txt",

        "BlankPic", this.Main "\Files\img\BlankPic.png",

        "Hub", this.Main "\Hub.ahk",

        "AhkTest", this.Test "\AhkTest.ahk",

        "vine boom",         this.Audio "\Sounds\vine boom.wav",
        "faded than a hoe",  this.Audio "\Sounds\faded than a hoe.wav",
        "heheheha",          this.Audio "\Sounds\heheheha.wav",
        "shall we",          this.Audio "\Sounds\shall we.wav",
        "slip and crash",    this.Audio "\Sounds\slip and crash.wav",
        "cartoon running",   this.Audio "\Sounds\cartoon running.wav",
        "rizz",              this.Audio "\Sounds\rizz.wav",
        "bruh sound effect", this.Audio "\Sounds\bruh sound effect.wav",
        "cartoon",           this.Audio "\Sounds\cartoon.wav",
        "hohoho",            this.Audio "\Sounds\hohoho.wav",
        "bing chilling 1",   this.Audio "\Sounds\bing chilling 1.wav",
        "bing chilling 2",   this.Audio "\Sounds\bing chilling 2.wav",
        "oh fr on god",      this.Audio "\Sounds\oh fr on god.wav",
        "sus",               this.Audio "\Sounds\sus.wav",
        "i just farted",     this.Audio "\Sounds\i just farted.wav",
        "ting",              this.Audio "\Sounds\ting.wav",
        "shutter",           this.Audio "\Sounds\shutter.wav",

        "Discovery log", this.Music "\Discovery log.txt",
        "Unfinished",    this.Music "\Unfinished.txt",
        "Rappers",       this.Music "\Rappers.txt",
        "Artists",       this.Music "\Favorites.md",

        "Shows",    this.Shows "\Shows.jsonc",
        "Consumed", this.Shows "\Consumed.md",

        "Diary",     this.Info "\Diary.md",
        "Events",    this.Info "\Events.jsonc",
        "Birthdays", this.Info "\Birthdays.jsonc",

        "FL preset", this.Pictures "\Tools\FL preset.flp",

        "femboy",       this.Pictures "\Tree\Memes\femboy.png",
        "writing fire", this.Pictures "\Tree\Memes\writing fire.jpg",
        "urethra",      this.Pictures "\Tree\Memes\urethra.jpg",
        "welp",         this.Pictures "\Tree\Memes\welp.jpg",
        "how did we get here", this.Pictures "\Tree\Memes\how did we get here.jpeg",
        "do you have the slightest idea how little that narrows it down", this.Pictures "\Tree\Memes\do you have the slightest idea how little that narrows it down.png",

    )

    static Apps := Map(

        "Sound mixer",       "SndVol.exe",
        "Slide to shutdown", "SlideToShutDown.exe",

    )
}
