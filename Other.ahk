#Include <Win>
#Include <Global>
#Include <App>
#Include <Paths>
#Include <String>

CloseButActually() {
   Switch {
      Case WinActive(Spotify.winTitle):Spotify.Close()
      Case WinActive("ahk_exe steam.exe"):
         Win.Close()
         ProcessClose("steam.exe")
      Case WinActive(Gimp.exeTitle):
         Win.Close()
         closeWindow := "Quit GIMP ahk_exe gimp-2.10.exe"
         if !WinWait(closeWindow,, 60)
            return
         Win({winTitle: closeWindow}).Activate()
         Send("{Left}{Enter}")
      Case WinActive("DaVinci Resolve ahk_exe Resolve.exe"):
         Win.Close()
         closeWindow := "Message ahk_exe Resolve.exe"
         if !WinWait(closeWindow,, 60)
            return
         Win({winTitle: closeWindow}).Activate()
         Send("{Left 2}{Enter}")
      Case WinActive("Telegram ahk_exe Telegram.exe"):
         telegram_pid := WinGetPID("Telegram ahk_exe Telegram.exe")
         Win.Close()
         ProcessClose(telegram_pid)
      Case WinActive("ahk_exe FL64.exe"):
         Win.Close()
         closeWindow := "Confirm ahk_exe FL64.exe"
         if !WinWait(closeWindow,, 60)
            return
         Win({winTitle: closeWindow}).Activate()
         Send("{Right}{Enter}")
      Default:Win.Close()
   }
}

MainApps() {
   VsCode.winObj.RunAct()
   Browser.winObj.RunAct()
   Terminal.winObj.RunAct()
   Spotify.winObj.RunAct()
   Discord.winObj.RunAct()
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

Calculator(expression) {
   result := eval(expression)
   if Round(result) = result {
      result := Round(result)
   }
   return result
}