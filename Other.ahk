#Include <Win>
#Include <Global>
#Include <App>
#Include <Paths>
#Include <String>

CloseButActually() {
   Switch {
      Case WinActive("ahk_exe Spotify.exe"):spotify_Close()
      Case WinActive("ahk_exe steam.exe"):
         win_Close()
         ProcessClose("steam.exe")
      Case WinActive("ahk_exe gimp-2.10.exe"):
         win_Close()
         closeWindow := "Quit GIMP ahk_exe gimp-2.10.exe"
         if !WinWait(closeWindow,, 60)
            return
         win_Activate(closeWindow)
         Send("{Left}{Enter}")
      Case WinActive("DaVinci Resolve ahk_exe Resolve.exe"):
         win_Close()
         closeWindow := "Message ahk_exe Resolve.exe"
         if !WinWait(closeWindow,, 60)
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
         if !WinWait(closeWindow,, 60)
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

SomeLockHint(whatLock) {

   newState := !GetKeyState(whatLock, "T")

   newState_Word := newState ? "On" : "Off"
   whatLock := StrTitle(whatLock)

   Set%whatLock%State(newState)

   ToggleInfo(whatLock " " newState_Word)
}

ToggleModifier(modifierName) {

   static ctrlState  := false
   static shiftState := false
   static altState   := false
   static winState   := false

   _Toggle(key) {
      %key%State := !%key%State
      Send("{" key (%key%State ? "Down" : "Up") "}")
      ToggleObj := ToggleInfo(key " " (%key%State ? "On" : "Off"))
      return ToggleObj
   }

   ToggleObj := _Toggle(modifierName)

}

WeatherClock() {

   static weather_hwnd := false
   static windowsClockWindow := "Date and Time Information ahk_exe ShellExperienceHost.exe"

   if WinExist(weather_hwnd) {
      return
   }

   g_weather := Gui("AlwaysOnTop -Caption")
   g_weather.BackColor := 0x353637
   g_weather.SetFont("c0xFFFFFF s20", "Segoe UI")
   g_weather.AddText(, GetWeather())
   g_weather.Show("NA w448 x" A_ScreenWidth / 20 * 15.35 "y" A_ScreenHeight / 20 * 9.12)
   weather_hwnd := g_weather.Hwnd

   Send("#!d")
   WinWaitActive(windowsClockWindow)

   WinWaitNotActive(windowsClockWindow)
   g_weather.Destroy()
   weather_hwnd := false
}