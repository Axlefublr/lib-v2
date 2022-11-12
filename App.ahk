#Include <Press>
#Include <Base>
#Include <Global>
#Include <Win>
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

#Include <App\Browser>
#Include <App\Spotify>
#Include <App\VK>
#Include <App\Youtube>
#Include <App\Telegram>
#Include <App\Discord>
#Include <App\VsCode>

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