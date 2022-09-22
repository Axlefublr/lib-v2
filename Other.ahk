#Include <Win>
#Include <Global>
#Include <App>
#Include <Paths>
#Include <String>

Googler(searchRequest) {
   searchRequest := searchRequest.Replace("+", "%2B")
   searchRequest := searchRequest.Replace("#", "%23")
   searchRequest := searchRequest.Replace(" ", "+")
   RunLink("https://www.google.com/search?q=" searchRequest)
}

CloseButActually() {
   Switch {
      Case WinActive("ahk_exe Spotify.exe"):spotify_Close()
      Case WinActive("ahk_exe steam.exe"):
         win_Close()
         ProcessClose("steam.exe")
      Case WinActive("ahk_exe gimp-2.10.exe"):
         win_Close()
         closeWindow := "Quit GIMP ahk_exe gimp-2.10.exe"
         if !WinWait(closeWindow, , 60)
            return
         win_Activate(closeWindow)
         Send("{Left}{Enter}")
      Case WinActive("DaVinci Resolve ahk_exe Resolve.exe"):
         win_Close()
         closeWindow := "Message ahk_exe Resolve.exe"
         if !WinWait(closeWindow, , 60)
            return
         win_Activate(closeWindow)
         Send("{Left 2}{Enter}")
      Case WinActive("Telegram ahk_exe Telegram.exe"):
         telegram_pid := WinGetPID("Telegram ahk_exe Telegram.exe")
         win_Close()
         ProcessClose(telegram_pid)
      Case WinActive("ahk_exe FL64.exe"):
         win_Close()
         closeWindow := "Confirm ahk_exe FL64.exe"
         if !WinWait(closeWindow, , 60)
            return
         win_Activate(closeWindow)
         Send("{Right}{Enter}")
      Default:win_Close()
   }
}

MainApps() {
   win_RunAct("Visual Studio Code ahk_exe Code.exe", Paths.Apps["VS Code"])
   win_RunAct("Google Chrome ahk_exe chrome.exe",    Paths.Apps["Google Chrome"])
   win_RunAct("ahk_group Terminal",                  Paths.Apps["Terminal"])
   win_RunAct("ahk_exe Spotify.exe",                 Paths.Apps["Spotify"])
   win_RunAct("Discord ahk_exe Discord.exe",         Paths.Apps["Discord"],,,, "Updater")
}