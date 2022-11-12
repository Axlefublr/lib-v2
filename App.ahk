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
#Include <App\Terminal>
#Include <App\Git>
#Include <App\GitHub>
#Include <App\Shows>

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