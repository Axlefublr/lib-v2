#Include <Tools\Info>
#Include <Converters\DateTime>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Misc\Global>

Class Spotify {

   static exeTitle := "ahk_exe Spotify.exe"
   static winTitle := this.exeTitle
   static path := A_AppData "\Spotify\Spotify.exe"

   static winObj := Win({
      winTitle: this.exeTitle,
      exePath: this.path
   })

   static Like() => Send("+!b")

   static Shuffle() => Send("^s")

   static SkipNext() => Send("^{Right}")

   static SkipPrev() => Send("^{Left}")

   static LikedPlaylist() => Send("+!s")

   static Close() => Send("^+q")

   static RemoveAfterArtist(input) => RegExReplace(input, " +[-=] .*")

   static RemoveDateAndTime(input) => RegExReplace(input, "(\d+\. )?(- +)?(\d\d\.\d\d\.\d\d)?( \d\d:\d\d)?( +- +)?")

   static Context() => (
      ControlClick("x32 y1014", this.exeTitle, , "R"),
      Send("{Up 2}")
   )

   static GetCurrSong() {
      currSong := WinGetTitle(this.exeTitle)
      if currSong ~= "Spotify (Free)|(Premium)" {
         Info("No song is currently playing")
         return false
      }
      return currSong
   }

   static NewDiscovery() {
      currSong := this.GetCurrSong()
      if !currSong {
         return
      }
      artistName := this.RemoveAfterArtist(currSong)
      this.NewDiscovery_Manual(artistName)
   }

   static NewDiscovery_Manual(artistName) {
      AppendFile(Paths.Ptf["Discovery log"], DateTime.Date " " DateTime.Time " - " artistName "`n")
      Info(artistName " just discovered! 🌎")
   }

   static IsRapperTouched(name) {
      isTouched := ReadFile(Paths.Ptf["Unfinished"])
      isTouched .= ReadFile(Paths.Ptf["Rappers"])
      isTouched .= ReadFile(Paths.Ptf["Artists"])
      isTouched := this.RemoveDateAndTime(isTouched)
      isTouched := this.RemoveAfterArtist(isTouched)
      if Instr(isTouched, name) {
         Info("You've already started listening to this rapper")
         return true
      }
      return false
   }

   static NewRapper(name) {
      if this.IsRapperTouched(name)
         return
      AppendFile(Paths.Ptf["Rappers"], DateTime.Date " " DateTime.Time " - " name "`n")
      Info(name " yet to be discovered! 📃")
   }

   static FavRapper_Auto() {
      currSong := this.GetCurrSong()
      if !currSong {
         return
      }
      currArtist := this.RemoveAfterArtist(currSong)
      this.FavRapper_Manual(currArtist)
   }

   static FavRapper_Manual(artistName) {
      artists := this.RemoveDateAndTime(ReadFile(Paths.Ptf["Artists"]))
      if InStr(artists, artistName) {
         Info(artistName " is already added 😨")
         return
      }
      AppendFile(Paths.Ptf["Artists"], "1. " DateTime.Date " - " artistName "`n")
      Info(artistName " is now your favorite! 🥰")
   }

   static Discovery() {
      static isStarted := false
      static var := 0

      if isStarted {
         Destruction()
         return
      }

      onRightClick(*) {
         ControlClick_Here(this.exeTitle, "R")
         var++
         g_added_text.Text := var
         if var >= 15 {
            Destruction()
         }
      }

      Destruction(*) {
         HotIfWinActive(this.exeTitle)
         Hotkey("RButton", "Off")
         Hotkey("Escape", "Off")
         g_added.Destroy()
         var := 0
         isStarted := false
      }

      static g_added
      g_added := Gui("AlwaysOnTop -Caption")
      g_added.backColor := "171717"
      g_added.SetFont("s50 c0xC5C5C5", "Consolas")
      g_added_text := g_added.Add("Text", "W200 X0 Y60 Center", "0")
      g_added.Show("W200 H200 X0 Y0 NA")

      HotIfWinActive(this.exeTitle)
      Hotkey("RButton", onRightClick, "On")
      Hotkey("Escape", Destruction, "On")
      g_added.OnEvent("Close", Destruction.Bind())
      g_added_text.OnEvent("Click", (*) => var := g_added_text.Text := g_added_text.Text - 1)	;We update the number we *see* with the one just lower than it, and also update the amount of tracks until destruction (var)
      g_added_text.OnEvent("DoubleClick", Destruction.Bind())

      isStarted := true
   }
}
