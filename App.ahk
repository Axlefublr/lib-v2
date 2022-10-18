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
;CHROME~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
chrome_CloseAllTabs() => Send("+!w")
;SPOTIFY~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
spotify_Like() => Send("+!b")

spotify_Shuffle() => Send("^s")

spotify_SkipNext() => Send("^{Right}")

spotify_SkipPrev() => Send("^{Left}")

spotify_LikedPlaylist() => Send("+!s")

spotify_Close() => Send("^+q")

spotify_RemoveAfterArtist(input) => RegExReplace(input, " +[-=] .*")

spotify_RemoveDateAndTime(input) => RegExReplace(input, "(\d+\. )?(- +)?(\d\d\.\d\d\.\d\d)?( \d\d:\d\d)?( +- +)?")

spotify_Context() => (
   ControlClick("x32 y1014", "ahk_exe Spotify.exe", , "R"),
   Send("{Up 2}")
)

spotify_GetCurrSong() {
   currSong := WinGetTitle("ahk_exe Spotify.exe")
   if currSong ~= "Spotify (Free)|(Premium)" {
      Info("No song is currently playing")
      return false
   }
   return currSong
}

spotify_NewDiscovery() {
   currSong := spotify_GetCurrSong()
   if !currSong {
      return
   }
   artistName := spotify_RemoveAfterArtist(currSong)
   spotify_NewDiscovery_Manual(artistName)
}

spotify_NewDiscovery_Manual(artistName) {
   AppendFile(Paths.Ptf["Discovery log"], GetDateAndTime() " - " artistName "`n")
   Info(artistName " just discovered! 🌎")
}

spotify_IsRapperTouched(name) {
   isTouched := ReadFile(Paths.Ptf["Unfinished"])
   isTouched .= ReadFile(Paths.Ptf["Rappers"])
   isTouched .= ReadFile(Paths.Ptf["Artists"])
   isTouched := spotify_RemoveDateAndTime(isTouched)
   isTouched := spotify_RemoveAfterArtist(isTouched)
   if Instr(isTouched, name) {
      Info("You've already started listening to this rapper")
      return true
   }
   return false
}

spotify_NewRapper(name) {
   if spotify_IsRapperTouched(name)
      return
   AppendFile(Paths.Ptf["Rappers"], GetDateAndTime() " - " name "`n")
   Info(name " yet to be discovered! 📃")
}

spotify_FavRapper_Auto() {
   currSong := spotify_GetCurrSong()
   if !currSong {
      return
   }
   currArtist := spotify_RemoveAfterArtist(currSong)
   spotify_FavRapper_Manual(currArtist)
}

spotify_FavRapper_Manual(artistName) {
   artists := spotify_RemoveDateAndTime(ReadFile(Paths.Ptf["Artists"]))
   if InStr(artists, artistName) {
      Info(artistName " is already added 😨")
      return
   }
   AppendFile(Paths.Ptf["Artists"], "1. " GetDate() " - " artistName "`n")
   Info(artistName " is now your favorite! 🥰")
}

spotify_Discovery() {
   static isStarted := false
   static var := 0

   if isStarted {
      Destruction()
      return
   }

   onRightClick(*) {
      ControlClick_Here("ahk_exe Spotify.exe", "R")
      var++
      g_added_text.Text := var
      if var >= 15 {
         Destruction()
      }
   }

   Destruction(*) {
      HotIfWinActive("ahk_exe Spotify.exe")
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

   HotIfWinActive("ahk_exe Spotify.exe")
   Hotkey("RButton", onRightClick.Bind(), "On")
   Hotkey("Escape", Destruction.Bind(), "On")
   g_added.OnEvent("Close", Destruction.Bind())
   g_added_text.OnEvent("Click", (*) => var := g_added_text.Text := g_added_text.Text - 1)	;We update the number we *see* with the one just lower than it, and also update the amount of tracks until destruction (var)
   g_added_text.OnEvent("DoubleClick", Destruction.Bind())

   isStarted := true
}
;YOUTUBE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
youtube_SkipNext() => Send("+n")

youtube_SkipPrev() => Send("+p")

youtube_MiniscreenClose() => ControlClick("X1858 Y665")

youtube_ChannelSwitch() => (
   ControlClick("X1823 Y133"),
   WaitUntilImage(Paths.Ptf["switch account ytt"]),
   ControlClick("x1531 y407")
)

youtube_ToYouTube() => (
   ControlClick("X1865 Y130"),
   WaitClick(Paths.Ptf["youtube logo"])
)
;VK~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vk_Voice() => ControlClick("X1757 Y1014")

vk_Scroll() => ControlClick("X1750 Y903")
;TELEGRAM~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
;DISCORD~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
discord_Emoji() => Send("^e")

discord_Gif() => Send("^g")

discord_React() => WaitClick(Paths.Ptf["react"])
discord_Edit()  => WaitClick(Paths.Ptf["edit"])
discord_Reply() => WaitClick(Paths.Ptf["reply"])
;VSCODE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

vscode_CleanText() {
   clean := ReadFile(Paths.Ptf["Raw"])
   clean := StrReplace(clean, "`r`n", "`n")	;making it easy for regex to work its magic by removing returns
   clean := clean.RegexReplace("[ \t]{2,}", " ")
   clean := RegexReplace(clean, "m)^\* .*\n(\n)?")	;removing bullets and their additional newlines
   clean := RegexReplace(clean, "\n{3,}")	;removing spammed newlines
   clean := RegexReplace(clean, "(?<!\.)\n{2}(?=[^A-Z])", " ")	;appending continuing lines that start with a lowercase letter. if the previous line ended in a period, it's ignored

   WriteFile(Paths.Ptf["Clean"], clean)
   Info("Text cleaned")
}

vscode_VideoUp() {
   files := [
      Paths.Ptf["Raw"],
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
   
   linuxPath := "/mnt/c/"
}
;TERMINAL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
term_DeleteWord() => Send("^w")
;GIT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

git_InstallAhkLibrary(link) {
   static libFolder := Paths.Lib "\"
   link := StrReplace(link, "https://github.com/")
   link := StrReplace(link, "blob/",,,, 1)
   file_html := GetHtml("https://raw.githubusercontent.com/" link)
   RegExMatch(link, "\/([^.\/]+\.\w+)$", &match)
   newFile := match[1]
   WriteFile(libFolder newFile, file_html)
   Info(newFile " library installed in: " libFolder)
}
;GITHUB~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
github_Profile() {
   ControlClick("x1825 y134")
   WaitClick(Paths.Ptf["github"])
}
;SHOW~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Show_GetLink(show, progressType := "episode") {
   shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   try shows[show]
   catch Any {
      Info("No " show "!🎬")
      return "" ;There for sure won't be a link nor an episode if the object doesn't exist yet, because if I either set the link or the episode, the show object will exist along with the properties, even if one of them doesn't have a non-zero value
   }
   if !shows[show]["link"] {
      Info("No link!🔗")
      return "" ;If the object exists, so does the link property, which will be blank if I only set the episode (somehow). The episode always starts out being 0 though, no need to check for it
   }
   return shows[show]["link"] shows[show][progressType] + 1
}

Show_GetShows() {
   shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   for key, value in shows {
      Infos(key)
   }
}

Show_Run(show, progressType?) {
   try Run(Show_GetLink(show, progressType?))
   catch any {
      Info("Fucked up link :(")
      return
   }
   win_Activate("Google Chrome ahk_exe chrome.exe")
}

Show_DeleteShow(show, isDropped := false) {
   shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   try {
      shows.Delete(show)
      WriteFile(Paths.Ptf["Shows"], JSON.stringify(shows))
   }
   AppendFile(Paths.Ptf["Consumed"], "`n1. " GetDate() " - " show.ToTitle() (isDropped ? " - dropped" : ""))
}

Show_SetLink(show_and_link) {
   show_and_link := RegexReplace(show_and_link, " {2,}", " ")
   RegexMatch(show_and_link, "(.+) (https:\/\/[^ ]+)", &show_and_link_match)
   if !show_and_link_match {
      Info("No show / link")
      return
   }

   show := show_and_link_match[1]
   link := show_and_link_match[2]

   shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))

   try shows[show]
   catch Any {
      shows.Set(show, {episode: 0, link: link, downloaded: 0})
   }
   else shows[show]["link"] := link

   WriteFile(Paths.Ptf["Shows"], JSON.stringify(shows))
   Info(show ": link set")
}

Show_SetEpisode(show_and_episode) {
   show_and_episode := RegexReplace(show_and_episode, " {2,}", " ")
   RegexMatch(show_and_episode, "(.+) (\d+)", &show_and_episode_match)

   show := show_and_episode_match[1]
   episode := show_and_episode_match[2]

   shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   try shows[show]
   catch Any {
      shows.Set(show, {episode: episode, link: "", downloaded: episode})
   }
   else shows[show]["episode"] := episode

   if episode > shows[show]["downloaded"] {
      shows[show]["downloaded"] := episode
   }

   WriteFile(Paths.Ptf["Shows"], JSON.stringify(shows))
   Info(show ": " episode)
}

Show_SetDownloaded(show_and_downloaded) {
   show_and_downloaded := RegExReplace(show_and_downloaded, " {2,}", " ")
   RegExMatch(show_and_downloaded, "(.+) (\d+)", &show_and_downloaded_match)

   show := show_and_downloaded_match[1]
   downloaded := show_and_downloaded_match[2]

   shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   try shows[show]
   catch Any {
      shows.Set(show, {episode: 0, link: "", downloaded: downloaded})
   }
   else shows[show]["downloaded"] := downloaded

   WriteFile(Paths.Ptf["Shows"], JSON.stringify(shows))
   Info(show ": " downloaded)
}
;VIDEO~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
;DAVINCI~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

screenshot_Rectangle() => ClickThenGoBack("839 6")

screenshot_Window() => ClickThenGoBack("959 6")

screenshot_Fullscreen() => ClickThenGoBack("1019 6")
