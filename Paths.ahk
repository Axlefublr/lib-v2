﻿;No dependencies

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

   static Backups   := this.Main "\Backups"
   static Docs      := this.Main "\Docs"
   static Files     := this.Main "\Files"
   static Images    := this.Main "\Files\Images"
   static Sounds    := this.Main "\Files\Sounds"
   static Notes     := this.Main "\Notes"
   static NotesTemp := this.Main "\Notes temp"
   static Test      := this.Main "\Test"
   static Tools     := this.Main "\Tools"

   static Pictures  := "C:\Pictures"
   static Materials := this.Pictures "\Materials"
   static Content   := this.Pictures "\Content"

   static StandardAhkLibLocation := A_MyDocuments "\AutoHotkey\Lib"

   static VsCodeExtensions := "C:\Users\" A_UserName "\.vscode\extensions"
   static SavedScreenshots := this.LocalAppData "\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip"

   static Ptf := Map(
      "Main", this.Main "\.vscode\main.code-workspace",

      "react",              this.Main "\Files\Images\react.png",
      "switch account ytt", this.Main "\Files\Images\switch account ytt.png",
      "youtube logo",       this.Main "\Files\Images\youtube logo.png",
      "github",             this.Main "\Files\Images\github.png",
      "edit",               this.Main "\Files\Images\edit.png",
      "reply",              this.Main "\Files\Images\reply.png",
      "vk reply",           this.Main "\Files\Images\vk reply.png",
      "BlankPic",           this.Main "\Files\Images\BlankPic.png",
      
      "vine boom", this.Main "\Files\Sounds\vine boom.wav",

      "Timer.txt", this.Main "\Files\Innit\Timer.txt",

      "Keys", this.Main "\Main\Scr Keys.ahk",

      "Output",  this.Main "\Test\Output.txt",
      "AhkTest", this.Main "\Test\AhkTest.ahk",

      "Timer.ahk", this.Main "\Tools\Timer.ahk",

      "Discovery log", this.Music "\Discovery log.txt",
      "Unfinished",    this.Music "\Unfinished.txt",
      "Rappers",       this.Music "\Rappers.txt",
      "Artists",       this.Music "\Favorites.md",

      "Shows",    this.Shows "\Shows.jsonc",
      "Consumed", this.Shows "\Consumed.md",

      "EatingLog", this.Info "\EatingLog.txt",
      "Diary",     this.Info "\Diary.md",

      "Clean",       this.YtDev "\Clean.md",
      "Description", this.YtDev "\Description.txt",

      "FL preset", this.Pictures "\Tools\FL preset.flp",
      
   )

   static Apps := Map(
      "Shell Menu View", A_ProgramFiles "\Shell Menu View\shmnview.exe",
      "DS4 Windows",     A_ProgramFiles "\DS4Windows\DS4Windows.exe",

      "VPN", "C:\Program Files (x86)\Proton Technologies\ProtonVPN\ProtonVPN.exe",

      "FL",              "C:\Programs\FL Studio 20\FL64.exe",
      "Steam",           "C:\Programs\Steam\steam.exe",

      "Sound mixer", this.System32 "\SndVol.exe",

   )
}
