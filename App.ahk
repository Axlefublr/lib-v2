#Include C:\Programming\lib-v2\
#Include Press.ahk
#Include Base.ahk
#Include Global.ahk
#Include Win.ahk
#Include Win-full.ahk
#Include ClipSend.ahk
#Include Paths.ahk
#Include String.ahk
#Include String-full.ahk
#Include Info.ahk
#Include Json.ahk
#Include Sort.ahk

;CHROME~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

chrome_CopyLink() => (
   Send("^l"),
   KeyWait(A_ThisHotkey_Formatted(), "U"),
   Copy()
)

chrome_CloseAllTabs := Send.Bind("+!w")

;SPOTIFY~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

spotify_Like := Send.Bind("+!b")

spotify_Shuffle := Send.Bind("^s")

spotify_SkipNext := Send.Bind("^{Right}")

spotify_SkipPrev := Send.Bind("^{Left}")

spotify_LikedPlaylist := Send.Bind("+!s")

spotify_Close := Send.Bind("^+q")

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

spotify_GetCurrSong() {
   currSong := WinGetTitle("ahk_exe Spotify.exe")
   if currSong = "Spotify Free"
      return false
   return currSong
}

spotify_NewDiscovery() {
   currSong := spotify_GetCurrSong()
   if !currSong {
      Traytip("No track is playing")
      return
   }
   artistName := RegexReplace(currSong, " - .*", "")
   AppendFile(Paths.Ptf["Discovery log"], GetDateAndTime() " - " artistName "`n")
   TrayTip(artistName " just discovered! 🌎")
}

spotify_NewRapper(name) {
   isTouched := ReadFile(Paths.Ptf["Unfinished"])
   isTouched .= ReadFile(Paths.Ptf["Rappers"])
   isTouched := RegexReplace(isTouched, " - .*", "")
   if Instr(isTouched, name) {
      TrayTip("You've already started listening to this rapper")
      return
   }
   AppendFile(Paths.Ptf["Rappers"], name "`n")
   TrayTip(name " yet to be discovered! 📃")
}

spotify_SendTrackToKristi() {
   currSong := spotify_GetCurrSong()
   if !currSong {
      TrayTip("No track is playing")
      return
   }
   win_RunAct("Telegram", Paths.Apps["Telegram"])
   telegram_Channel("кристина")
   WaitUntilImage(Paths.Ptf["Kristi"])
   ClipSend(currSong)
   Send("{Enter}")
}

spotify_Context() => (
   ControlClick("X22 Y1015", "ahk_exe Spotify.exe", , "R"),
   Send("{Up 2}")
)

spotify_FavRapper_Auto() {
   currSong := spotify_GetCurrSong()
   if !currSong {
      Traytip("No track is playing")
      return
   }
   currArtist := RegexReplace(currSong, " -.*")
   spotify_FavRapper_Manual(currArtist)
}

spotify_FavRapper_Manual(artistName) {
   artists := ReadFile(Paths.Ptf["Artists"])
   artists := RegexReplace(artists, "1\. ")
   if InStr(artists, artistName) {
      TrayTip(artistName " is already added 😨")
      return
   }
   AppendFile(Paths.Ptf["Artists"], "1. " artistName "`n")
   TrayTip(artistName " is now your favorite! 🥰")
}

;YOUTUBE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

youtube_SkipNext := Send.Bind("+n")

youtube_SkipPrev := Send.Bind("+p")

youtube_Seek(direction) {
   Switch direction {
      Case "right": Send("l")
      Case "left": Send("j")
   }
}

youtube_Fullscreen() => (LanguageEng(), Send("f"))

youtube_Miniscreen() => (LanguageEng(), Send("i"))

youtube_MiniscreenClose := ControlClick.Bind("X1858 Y665")

youtube_ChannelSwitch() => (
   ControlClick("X1823 Y133"),
   WaitUntilImage(Paths.Ptf["switch account ytt"]),
   ControlClick("X1524 Y400")
)

youtube_ToYouTube() => (
   ControlClick("X1865 Y130"),
   WaitClick(Paths.Ptf["youtube logo"])
)

youtube_isWatchingVid() => WinActive(" - YouTube ahk_exe chrome.exe")
   && !WinActive("Watch later ahk_exe chrome.exe")
   && !WinActive("Subscriptions ahk_exe chrome.exe")

youtube_isNotWatchingVid() => WinActive("Watch later ahk_exe chrome.exe")
   || WinActive("Subscriptions ahk_exe chrome.exe")
   || (WinActive("YouTube ahk_exe chrome.exe")
      && !WinActive(" - YouTube"))

;VK~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vk_Notifications := ControlClick.Bind("X788 Y126")

vk_Voice := ControlClick.Bind("X1757 Y1014")

vk_Scroll := ControlClick.Bind("X1750 Y903")

;TELEGRAM~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

telegram_Voice := ClickThenGoBack_Event.Bind("1452 1052")

telegram_Scroll := ControlClick.Bind("X1434 Y964")

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

discord_Emoji := Send.Bind("^e")

discord_Gif := Send.Bind("^g")

discord_Reply() => CtrlClick()

discord_React() {
   ImageSearch(&reactX, &reactY, 1730, 88, 1820, 995, Paths.Ptf["react"])
   try ControlClick("X" reactX " Y" reactY, "ahk_exe Discord.exe")
}

discord_DeleteMessage := Send.Bind("{Delete Down}{Click}{Delete Up}")

;VSCODE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vscode_IndentRight := Send.Bind("^!{Right}")

vscode_IndentLeft := Send.Bind("^!{Left}")

vscode_Comment := Send.Bind("#{End}")

vscode_RunCurrentFile := Send.Bind("+!o")

vscode_KillTerminal := Send.Bind("^!o")

vscode_Debug := Send.Bind("+!9")

vscode_CloseAllTabs := Send.Bind("+!w")

vscode_DeleteLine := Send.Bind("+{Delete}")

vscode_Reload := Send.Bind("+!y")

vscode_CloseTab := Send.Bind("!w")

vscode_CursorBack := Send.Bind("!{PgUp}")

vscode_CursorForward := Send.Bind("!{PgDn}")

vscode_GetCurrentFileFullPath(keepClip := true) {
   if keepClip
      prevClip := ClipboardAll()
   A_Clipboard := ""
   Send("^+k")
   ClipWait(3, 1)
   fileFullPath := A_Clipboard
   if keepClip
      A_Clipboard := prevClip
   return fileFullPath
}

vscode_ToEndOfCurrFile() {
   selection := str_GetSelection()
   file_Path := vscode_GetCurrentFileFullPath()
   file_Text := ReadFile(file_Path)
   file_Text := StrReplace(file_Text, selection, "")
   file_Text .= selection
   WriteFile(file_Path, file_Text)
}

vscode_ToEndOfOthrFile(otherFilePath) {
   selection := str_GetSelection()
   file_Path := vscode_GetCurrentFileFullPath()
   file_Text := ReadFile(file_Path)
   file_Text := StrReplace(file_Text, selection, "")
   WriteFile(file_Path, file_Text)
   AppendFile(otherFilePath, selection)
}

vscode_WorkSpace(wkspName) {
   vscode_CloseAllTabs()
   win_Close("ahk_exe Code.exe")
   Run(Paths.Ptf[wkspName], , "Max")
}

vscode_CleanText() {
   clean := ReadFile(Paths.Ptf["Raw"])
   clean := StrReplace(clean, "`r`n", "`n")	;making it easy for regex to work its magic by removing returns
   clean := RegexReplace(clean, "m)^\* .*\n(\n)?")	;removing bullets and their additional newlines

   RegexMatch(clean, "s)---\n(.*)", &description_regexed)	;Getting the description that's manually written

   clean := RegexReplace(clean, "s)---\n.*")	;deleting the description part of the script
   clean := RegexReplace(clean, "\n{3,}")	;removing spammed newlines
   clean := RegexReplace(clean, "m) *$")	;removing leading spaces
   clean := RegexReplace(clean, "(?<!\.)\n{2}(?=[^A-Z])", " ")	;appending continuing lines that start with a lowercase letter. if the previous line ended in a period, it"s ignored

   clean_compact := StrReplace(clean, "`n`n", "`n")

   if !description_regexed
      description_manual := ""
   else
      description_manual := description_regexed[1]

   description := description_manual "`n`n" '
   (
      My second channel: https://www.youtube.com/channel/UCEBqPAhcQlx36jnSEPMEaAw

      Learn about autohotkey v2 in the documentation: https://lexikos.github.io/v2/docs/AutoHotkey.htm
      IDE used in the video: https://code.visualstudio.com/

      My github:
      https://github.com/Axlefublr/

      Catch me on the ahk discord server as Axlefublr:
      https://discord.com/invite/Aat7KHmG7v

      The video script:
   )' "`n`n" clean_compact

   while description.Length >= 5000 {
      description := description.Delete(-1, 10)
   }

   WriteFile(Paths.Ptf["Clean"], clean)
   WriteFile(Paths.Ptf["Description"], description)
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

;TERMINAL~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

term_DeleteWord := Send.Bind("^w")

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

/**
 * Specify a file path and get the github link for it
 * @param path {str} Path to the file / folder you want the link to. In Main/Folder/file.txt, Main is the name of the repo (so the path is relative to your gh profile, basically)
 * @returns {str} the github link
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

Show_GetLink(show) {
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
   return shows[show]["link"] shows[show]["episode"] + 1
}

Show_GetShows() {
   shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   for key, value in shows {
      Infos(key)
   }
}

Show_Run(show) {
   try Run(Show_GetLink(show))
   catch any {
      Info("Fucked up link :(")
      return
   }
   win_Activate("Google Chrome ahk_exe chrome.exe")
}

Show_DeleteShow(show) {
   shows := JSON.parse(ReadFile(Paths.Ptf["Shows"]))
   shows.Delete(show)
   WriteFile(Paths.Ptf["Shows"], JSON.stringify(shows))
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
      shows.Set(show, {episode: 0, link: link})
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
      shows.Set(show, {episode: episode, link: ""})
   }
   else shows[show]["episode"] := episode

   WriteFile(Paths.Ptf["Shows"], JSON.stringify(shows))
   Info(show ": " episode)
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

;DAVINCI~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

davinci_Insert() {
   ControlClick("X79 Y151", "ahk_exe Resolve.exe", , "R")
   Send("{Down 2}{Enter}")
   WinWaitActive("New Timeline Properties")
   Send("{Enter}")
}

screenshot_Rectangle := ClickThenGoBack.Bind("839 6")

screenshot_Window := ClickThenGoBack.Bind("959 6")

screenshot_Fullscreen := ClickThenGoBack.Bind("1019 6")

explorer_Rename := Send.Bind("{F2}")