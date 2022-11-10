#Include <Press>
#Include <Base>
#Include <Global>
#Include <Win>
#Include <Win-full>
#Include <ClipSend>
#Include <Paths>
#Include <String>
#Include <String-full>
#Include <Info>
#Include <Json>
#Include <Sort>
#Include <Get>
#Include <Text>
#Include <Image>
#Include <Cmd>

Class Spotify {

   static winTitle := "ahk_exe Spotify.exe"
   
   static Like() => Send("+!b")

   static Shuffle() => Send("^s")

   static SkipNext() => Send("^{Right}")

   static SkipPrev() => Send("^{Left}")

   static LikedPlaylist() => Send("+!s")

   static Close() => Send("^+q")

   static RemoveAfterArtist(input) => RegExReplace(input, " +[-=] .*")

   static RemoveDateAndTime(input) => RegExReplace(input, "(\d+\. )?(- +)?(\d\d\.\d\d\.\d\d)?( \d\d:\d\d)?( +- +)?")

   static Context() => (
      ControlClick("x32 y1014", this.winTitle, , "R"),
      Send("{Up 2}")
   )

   static GetCurrSong() {
      currSong := WinGetTitle(this.winTitle)
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
      AppendFile(Paths.Ptf["Discovery log"], GetDateAndTime() " - " artistName "`n")
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
      AppendFile(Paths.Ptf["Rappers"], GetDateAndTime() " - " name "`n")
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
      AppendFile(Paths.Ptf["Artists"], "1. " GetDate() " - " artistName "`n")
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
         ControlClick_Here(this.winTitle, "R")
         var++
         g_added_text.Text := var
         if var >= 15 {
            Destruction()
         }
      }

      Destruction(*) {
         HotIfWinActive(this.winTitle)
         Hotkey("RButton", "Off")
         Hotkey("Escape", "Off")
         g_added.Destroy()
         var := 0
         isStarted := false
      }

      static g_added
      g_added := Gui("AlwaysOnTop -caption")
      g_added.backColor := "171717"
      g_added.SetFont("s50 c0xC5C5C5", "Consolas")
      g_added_text := g_added.Add("Text", "W200 X0 Y60 Center", "0")
      g_added.Show("W200 H200 X0 Y0 NA")

      HotIfWinActive(this.winTitle)
      Hotkey("RButton", onRightClick.Bind(), "On")
      Hotkey("Escape", Destruction.Bind(), "On")
      g_added.OnEvent("Close", Destruction.Bind())
      g_added_text.OnEvent("Click", (*) => var := g_added_text.Text := g_added_text.Text - 1)	;We update the number we *see* with the one just lower than it, and also update the amount of tracks until destruction (var)
      g_added_text.OnEvent("DoubleClick", Destruction.Bind())

      isStarted := true
   }
}

Class Youtube {

   static winTitle := "YouTube ahk_exe chrome.exe"
   
   static Studio := "YouTube Studio ahk_exe chrome.exe"
   
   static NotWatchingVideo := "(?<! - )Watch later|Subscriptions|Youtube ahk_exe chrome\.exe"
   
   static SkipNext() => Send("+n")

   static SkipPrev() => Send("+p")

   static MiniscreenClose() => ControlClick("X1858 Y665")
   
   static ClickProfile() => ControlClick("X1823 Y133")

   static WaitUntilProfileWindow() {
      this.ClickProfile()
      if !WaitUntilPixChange([1324, 116], 0x313131)
         return
   }
   
   static ChannelSwitch() {
      this.WaitUntilProfileWindow()
      ControlClick("x1531 y407")
   }
   
   static StudioSwitch() {
      this.WaitUntilProfileWindow()
      ControlClick("x1500 y376")
   }

   static ToYouTube() {
      ControlClick("x1860 y134")
      if WaitUntilPixChange([1612, 349])
         ControlClick("x1634 y350")
   }
}

Class Browser {
   static winTitle := "Google Chrome ahk_exe chrome.exe"
}

;;VK
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vk_Voice() => ControlClick("X1757 Y1014")

vk_Scroll() => ControlClick("X1750 Y903")

vk_Reply() => WaitClick(Paths.Ptf["vk reply"])
;;TELEGRAM
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
telegram_Voice() => ClickThenGoBack_Event("1452 1052")

telegram_Scroll() => ControlClick("X1434 Y964")

telegram_Channel(channelToFind) => (
   ControlClick("X456 Y74"),
   Send(channelToFind),
   Send("{Enter}")
)

telegram_Diary() {
   diary := ReadFile(Paths.Ptf["Diary"])
   WriteFile(Paths.Ptf["Diary"])
   win_RunAct("Telegram ahk_exe Telegram.exe", Paths.Apps["Telegram"])
   telegram_Channel("Diary")
   ClipSend(diary)
   Send("{Enter}")
}
;;DISCORD
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
discord_Emoji() => Send("^e")

discord_Gif() => Send("^g")

discord_React() => WaitClick(Paths.Ptf["react"])
discord_Edit()  => WaitClick(Paths.Ptf["edit"])
discord_Reply() => WaitClick(Paths.Ptf["reply"])

;;VSCODE
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vscode_IndentRight()   => Send("^!{Right}")
vscode_IndentLeft()    => Send("^!{Left}")
vscode_Comment()       => Send("#{End}")
vscode_Debug()         => Send("+!9")
vscode_CloseAllTabs()  => Send("+!w")
vscode_DeleteLine()    => Send("+{Delete}")
vscode_Reload()        => Send("+!y")
vscode_CloseTab()      => Send("!w")
vscode_CursorBack()    => Send("!{PgUp}")
vscode_CursorForward() => Send("!{PgDn}")

vscode_WorkSpace(wkspName) {
   vscode_CloseAllTabs()
   win_Close("ahk_exe Code.exe")
   Run(Paths.Ptf[wkspName], , "Max")
}

vscode_CleanText(input) {
   clean := StrReplace(input, "`r`n", "`n") ;making it easy for regex to work its magic by removing returns
   clean := clean.RegexReplace("[ \t]{2,}", " ")
   clean := clean.RegexReplace("^[!*].*\n(\n)?")
   clean := clean.RegexReplace("(\n)?\n\* .*", "`n`n")
   clean := clean.RegexReplace("(\n)?\n!\[.*", "`n`n")
   ; clean := clean.RegexReplace("\n{3,}")	;removing spammed newlines
   clean := clean.RegexReplace("(?<!\.)\n{2}(?=[^A-Z])", " ") ;appending continuing lines that start with a lowercase letter. if the previous line ended in a period, it's ignored
   clean := clean.RegexReplace("[ \t]{2,}", " ")

   WriteFile(Paths.Ptf["Clean"], clean)
   Info("Text cleaned")
}

vscode_VideoUp() {
   files := [
      Paths.Ptf["Clean"],
      Paths.Ptf["Description"],
   ]
   for key, value in files {
      WriteFile(value)
   }
   FileDelete(Paths.Materials "\*.*")
}

vscode_GetLinuxPath() {
   vscodeTitle := WinGetTitle("Visual Studio Code ahk_exe Code.exe")
   path := vscodeTitle.RegexReplace(" -.*")
   noLowercaseCPath := path.RegexReplace("^C:")
   forwardPath := noLowercaseCPath.Replace("\", "/")
   
   linuxPath := "/mnt/c" forwardPath
   return linuxPath
}

;;TERMINAL
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
term_DeleteWord() => Send("^w")

;;GIT
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/**
 * Specify a file path and get the github link for it
 * @param path *String* Path to the file / folder you want the link to. In Main/Folder/file.txt, Main is the name of the repo (so the path is relative to your gh profile, basically)
 * @returns {String} the github link
 */
git_Link(path) {
   static github := Links["ghm"] ;Specify you github link (https://github.com/yourNickname/)
   static fileBlob := "/blob/main/" ;The part between the name of the repo and the other file path is different depending on whether it's a file or a folder
   static folderBlob := "/tree/main/"

   path := StrReplace(path, "\", "/") ;The link uses forward slashes, this replace is made so you can use whatever slashes you feel like

   if InStr(path, "C:/Programming/")
      path := StrReplace(path, "C:/Programming/") ;For the if I specify the full path, ignore this, will be removed in the public release of the function

   if !InStr(path, "/") ;You can just specify the name of the repo to get a link for it
      return github path

   if !RegExMatch(path, "\/$") && RegExMatch(path, "\.\w+$") ;If the passed path ends with a /, it will be considered a path to a folder. If the passed path ends with a `.extension`, it will be considered a file
      currentBlob := fileBlob
   else
      currentBlob := folderBlob

   RegExMatch(path, "([^\/]+)\/(.*)", &match) ;Everything before the first / will be considered the name of the repo. Everything after - the relative path in this repo
   repo := match[1]
   relPath := match[2]

   github_link := StrReplace(github repo currentBlob relPath, " ", "%20")
   return github_link
}

git_InstallAhkLibrary(link, fileName?) {
   static libFolder := Paths.Lib "\"
   link := StrReplace(link, "https://github.com/")
   link := StrReplace(link, "blob/",,,, 1)
   file_html := GetHtml("https://raw.githubusercontent.com/" link)
   if !IsSet(fileName) {
      RegExMatch(link, "\/([^.\/]+\.\w+)$", &match)
      newFile := match[1]
   }
   else {
      newFile := fileName
   }
   WriteFile(libFolder newFile, file_html)
   Info(newFile " library installed in: " libFolder)
}

;;GITHUB
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
github_Profile() {
   ControlClick("x1825 y134")
   WaitClick(Paths.Ptf["github"])
}

github_UpdateAhkLibraries() {
   git_InstallAhkLibrary("https://github.com/Descolada/AHK-v2-libraries/blob/main/Lib/String.ahk")
   git_InstallAhkLibrary("https://github.com/TheArkive/eval_ahk2/blob/master/_eval.ahk", "Eval.ahk")
}

Class Shows {
   __New() {
      this.shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   }
   
   ApplyJson() => WriteFile(Paths.Ptf["Shows"], JSON.stringify(this.shows))

   CreateBlankShow(show) => this.shows.Set(show, Map("episode", 0, "link", "", "downloaded", 0, "timestamp", GetDateAndTime()))
   
   ValidateShow(show) {
      try this.shows[show]
      catch Any {
         return false ;There for sure won't be a link nor an episode if the object doesn't exist yet, because if I either set the link or the episode, the show object will exist along with the properties, even if one of them doesn't have a non-zero value
      }
      return true
   }
   
   ValidateShowLink(show) {
      if !this.ValidateShow(show) {
         return false
      }
      if !this.shows[show]["link"] {
         Info("No link!🔗")
         return false ;If the object exists, so does the link property, which will be blank if I only set the episode (somehow). The episode always starts out being 0 though, no need to check for it
      }
      return true
   }
   
   GetLink(show, progressType := "episode") {
      if !this.ValidateShowLink(show) {
         return ""
      }
      return this.shows[show]["link"] this.shows[show][progressType] + 1
   }
   
   GetList() {
      for key, value in this.shows {
         Infos(key)
      }
   }

   Run(show, progressType?) {
      try Run(this.GetLink(show, progressType?))
      catch Any {
         Info("Fucked up link :(")
         return
      }
      win_Activate(Browser.winTitle)
   }
      
   DeleteShow(show, isDropped := false) {
      try {
         this.shows.Delete(show)
         this.ApplyJson()
      }
      this.UpdateConsumed(show, isDropped)
   }
   
   UpdateConsumed(show, isDropped) => (
      date := "`n1. " GetDate() " - ",
      isDropped_string := isDropped ? " - dropped" : "",
      AppendFile(Paths.Ptf["Consumed"], date show.ToTitle() isDropped_string)
   )

   ValidateSetInput(input, regex) {
      input := CompressSpaces(input)
      
      RegexMatch(input, regex, &match)
      if !match {
         Info("Wrong!")
         return false
      }
      return match
   }

   SetLink(show_and_link) {
      if !show_and_link := this.ValidateSetInput(show_and_link, "(.+) (https:\/\/[^ ]+)") {
         return false
      }
      
      show := show_and_link[1]
      link := show_and_link[2]

      if !this.ValidateShow(show) {
         this.CreateBlankShow(show)
      }
      this.shows[show]["link"] := link

      this.ApplyJson()
      Info(show ": link set")
   }

   SetEpisode(show_and_episode) {
      if !show_and_episode := this.ValidateSetInput(show_and_episode, "(.+) (\d+)") {
         return false
      }
      
      show    := show_and_episode[1]
      episode := show_and_episode[2]

      if !this.ValidateShow(show) {
         this.CreateBlankShow(show)
      }
      this.shows[show]["episode"] := episode
      this.shows[show]["timestamp"] := GetDateAndTime()

      if episode > this.shows[show]["downloaded"] {
         this.shows[show]["downloaded"] := episode
      }

      this.ApplyJson()
      Info(show ": " episode)
   }
   
   SetDownloaded(show_and_downloaded) {
      if !match := this.ValidateSetInput(show_and_downloaded, "(.+) (\d+)") {
         return false
      }

      show       := match[1]
      downloaded := match[2]

      if !this.ValidateShow(show) {
         this.CreateBlankShow(show)
      }
      this.shows[show]["downloaded"] := downloaded

      this.ApplyJson()
      Info(show ": " downloaded)
   }
}

;;VIDEO
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
video_EditScreenshot() {
   selectedFile := FileSelect("S", Paths.Materials, "Select a file to edit in gimp")
   if !selectedFile
      return

   RunWith(Paths.Apps["Gimp"], selectedFile)
}

video_DuplicateScreenshot() {
   file_path := FileSelect("s", Paths.Materials, "Choose a screenshot to duplicate")

   SplitPath(file_path, &file_fullname)
   file_name := RegexReplace(file_fullname, "\d+")

   screenshot_numbers := []
   Loop Files Paths.Materials "\*.png" {
      RegexMatch(A_LoopFileName, "\d+", &currentFile_number)
      screenshot_numbers.Push(currentFile_number[0])
   }
   screenshot_numbers := InsertionSort(screenshot_numbers)

   nextNumber := screenshot_numbers[-1] + 1

   newFile_path := Paths.Materials "\" nextNumber file_name

   FileCopy(file_path, newFile_path, 1)
   win_RunAct_Folders(Paths.Materials)
}

video_PasteClean() {
   cleanText := ReadFile(Paths.Ptf["Clean"])
   cleanText_compressed := "`n`n" StrReplace(cleanText, "`n`n", "`n")
   while cleanText_compressed.Length > 4300 {
      cleanText_compressed := cleanText_compressed.Delete(-100, 100)
   }
   ClipSend(cleanText_compressed)
}

Class Explorer {
   static winTitleRegex := "^[A-Z]: ahk_exe explorer\.exe"
}

;;DAVINCI
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
davinci_Insert() {
   if !win_Activate("DaVinci Resolve ahk_exe Resolve.exe") {
      Info("Window could not be activated")
      return
   }
   ControlClick("X79 Y151", "DaVinci Resolve ahk_exe Resolve.exe", , "R")
   Send("{Down 2}{Enter}")
   if !WinWaitActive("New Timeline Properties",, 3)
      return
   Send("{Enter}")
}

davinci_Setup() {
   if !win_Activate("DaVinci Resolve ahk_exe Resolve.exe") {
      Info("No Davinci Resolve window!")
      return 
   }
   win_RestoreDown("DaVinci Resolve ahk_exe Resolve.exe")
   WinMove(-8, 0, 1492, A_ScreenHeight, "DaVinci Resolve ahk_exe Resolve.exe")
   win_RunAct_Folders(Paths.Pictures)
   WinMove(1466, 0, 463, A_ScreenHeight)
   win_Activate("DaVinci Resolve ahk_exe Resolve.exe")
}

Class Screenshot {
   static winTitle := "Screen Snipping ahk_exe ScreenClippingHost.exe"
   
   static Start() => Send("#+s")

   static FullScreenOut() {
      this.Start()
      WinWaitActive(this.winTitle)
      this.Fullscreen()
   }

   static Rectangle()  => ClickThenGoBack("839 6")
   static Window()     => ClickThenGoBack("959 6")
   static Fullscreen() => ClickThenGoBack("1018 31")
}