#Include <Win>
#Include <Global>
#Include <App>
#Include <Paths>
#Include <String>

CloseButActually() {
   Switch {
      Case WinActive("ahk_exe Spotify.exe"):Spotify.Close()
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

   _Toggle(modifierName)
}

EatingLogger() {
   AppendFile(Paths.Ptf["EatingLog"], GetDateAndTime() "`n")
}