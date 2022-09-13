;No dependencies

Class Paths {

   static Prog := "C:\Programming"
   static Main := "C:\Programming\main"
   static Lib  := A_MyDocuments "\AutoHotkey\Lib"

   static Backups   := this.Main "\Backups"
   static Docs      := this.Main "\Docs"
   static Music     := this.Main "\Docs\Music"
   static Files     := this.Main "\Files"
   static Images    := this.Main "\Files\Images"
   static Sounds    := this.Main "\Files\Sounds"
   static Notes     := this.Main "\Notes"
   static NotesTemp := this.Main "\Notes temp"
   static Test      := this.Main "\Test"
   static Tools     := this.Main "\Tools"

   static Pictures  := "C:\Files\Pictures"
   static Editing   := this.Pictures "\Editing"
   static Materials := this.Pictures "\Editing\Materials"
   static Content   := this.Pictures "\Content"

   static StandardAhkLibLocation := A_MyDocuments "\AutoHotkey\Lib"

   static VsCodeExtensions := "C:\Users\" A_UserName "\.vscode\extensions"
   static AhkPlusPlusExtension := this.VsCodeExtensions "\thqby.vscode-autohotkey2-lsp-1.6.0"

   static Ptf := Map(
      "Main", this.Main "\Backups\main.code-workspace",

      "Discovery log", this.Main "\Docs\Music\Discovery log.txt",
      "Unfinished",    this.Main "\Docs\Music\Unfinished.txt",
      "Rappers",       this.Main "\Docs\Music\Rappers.txt",
      "Artists",       this.Main "\Docs\Music\Artists.md",

      "react",              this.Main "\Files\Images\react.png",
      "switch account ytt", this.Main "\Files\Images\switch account ytt.png",
      "youtube logo",       this.Main "\Files\Images\youtube logo.png",
      "github",             this.Main "\Files\Images\github.png",

      "Timer.txt", this.Main "\Files\Innit\Timer.txt",
      "Shows",     this.Main "\Files\Innit\Shows.jsonc",

      "Keys", this.Main "\Main\Scr Keys.ahk",

      "Raw",         this.Main "\Notes temp\Raw.md",
      "Clean",       this.Main "\Notes temp\Clean.md",
      "Description", this.Main "\Notes temp\Description.txt",
      "Diary",       this.Main "\Notes temp\Diary.md",
      "Output",      this.Main "\Notes temp\Output.txt",

      "AhkTest",  this.Main "\Test\AhkTest.ahk",

      "Timer.ahk",       this.Main "\Tools\Timer.ahk",

      "FL preset",        this.Pictures "\Editing\Tools\FL preset.flp",
      "Thumbnail preset", this.Pictures "\Editing\Tools\Thumbnail preset.xcf",
      "Thumbnail preset down", this.Pictures "\Editing\Tools\Thumbnail preset down.xcf",

      "Ahk++\package",       this.AhkPlusPlusExtension "\package.json",
      "Ahk++\configuration", this.AhkPlusPlusExtension "\ahk2.configuration.json",
      "Ahk++\tmlanguage",    this.AhkPlusPlusExtension "\syntaxes\ahk2.tmLanguage.json",
   )

   static LocalAppData := "C:\Users\" A_UserName "\AppData\Local"
   static System32 := "C:\Windows\System32"
   static OBSFolder := A_ProgramFiles "\obs-studio\bin\64bit"

   static Apps := Map(
      "Ahk v1 docs",       A_ProgramFiles "\AutoHotkey\AutoHotkey.chm",
      "Ahk v2 docs",       A_ProgramFiles "\AutoHotkey\v2.0-beta.7\AutoHotkey.chm",
      "Ahk compiler",      A_ProgramFiles "\AutoHotkey\Compiler\Ahk2Exe.exe",

      "Shell Menu View",   A_ProgramFiles "\Shell Menu View\shmnview.exe",
      "Terminal",          A_ProgramFiles "\WindowsApps\Microsoft.WindowsTerminal_1.14.2281.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe",
      "DS4 Windows",       A_ProgramFiles "\DS4Windows\DS4Windows.exe",
      "OBS",               A_ProgramFiles "\obs-studio\bin\64bit\obs64.exe",

      "Google Chrome",     A_ProgramFiles "\Google\Chrome\Application\chrome.exe",
      "Monkeytype",        A_ProgramFiles "\Google\Chrome\Application\chrome_proxy.exe --profile-directory=Default --app-id=picebhhlijnlefeleilfbanaghjlkkna",

      "VPN", "C:\Program Files (x86)\Proton Technologies\ProtonVPN\ProtonVPN.exe",

      "Spotify",           A_AppData "\Spotify\Spotify.exe",
      "Telegram",          A_AppData "\Telegram Desktop\Telegram.exe",

      "Gimp",              "C:\Programs\GIMP 2\bin\gimp-2.10.exe",
      "Davinci Resolve",   "C:\Programs\Davinci Resolve\Resolve.exe",
      "FL",                "C:\Programs\FL Studio 20\FL64.exe",
      "Steam",             "C:\Programs\Steam\steam.exe",

      "VS Code",           this.LocalAppData "\Programs\Microsoft VS Code\Code.exe",
      "WPS",               this.LocalAppData "\Kingsoft\WPS Office\ksolaunch.exe",
      "Discord",           this.LocalAppData "\Discord\app-1.0.9006\Discord.exe",
      "Slack",             this.LocalAppData "\slack\app-4.28.171\slack.exe",

      "Sound mixer",       this.System32 "\SndVol.exe",

   )
}
