;No dependencies

win_Close(winTitle := "A") {
   try PostMessage("0x0010",,,, winTitle)
}

win_RestoreDown(winTitle := "A") {
   try PostMessage("0x112", "0xF120", , , winTitle)
}

win_Maximize(winTitle := "A") {
   try PostMessage("0x112", "0xF030", , , winTitle)
}

win_Minimize(winTitle := "A") {
   try PostMessage("0x112", "0xF020", , , winTitle)
}

win_Activate(winTitle, exception := "") {
   try {
      WinActivate(WinGetList(winTitle,, exception)[1],, exception)
      WinWaitActive(winTitle,,, exception)
      return true
   } 
   catch Any {
      return false
   }
}

win_MinMax(winTitle) {
   if !WinExist(winTitle)
      return false

   if WinActive(winTitle)
      win_Minimize(winTitle)
   else
      win_Activate(winTitle)
   return true
}

win_Run(winTitle, exePath, runOpt?, winTitleAdditional?, startIn?, exception?) {
   if WinExist(winTitle)
      return false
   Run(exePath, startIn ?? "", runOpt ?? "Max")
   WinWait(winTitle, , 120, exception ?? "")
   if winTitleAdditional ?? false {
      WinWait(winTitleAdditional, , 120)
      win_Close(winTitleAdditional)
   }
   return true
}

win_RunAct(winTitle, exePath, runOpt?, winTitleAdditional?, startIn?, exception?) {
   win_Run(winTitle, exePath, runOpt?, winTitleAdditional?, startIn?, exception?)
   win_Activate(winTitle, exception?)
}

win_RunAct_Folders(folderPath, runOpt?) {
   winTitle := folderPath " ahk_exe explorer.exe"
   win_RunAct(winTitle, folderPath, runOpt ?? "Min")
}

win_App(winTitle, exePath, runOpt?, winTitleAdditional?, startIn?, exception?) {
   if win_MinMax(winTitle)
      return
   win_RunAct(winTitle, exePath, runOpt?, winTitleAdditional?, startIn?, exception?)
}

win_App_Folders(folderPath, runOpt?) {
   winTitle := folderPath " ahk_exe explorer.exe"
   win_App(winTitle, folderPath, runOpt?)
}

win_CloseOnceInactive(winTitle, closedAfter := 5) {
   WinWaitNotActive(winTitle)
   SetTimer(() => win_Close(winTitle), -closedAfter * 1000)
}

win_AutoCloseFolder(folderPath) {
   winTitle := folderPath " ahk_exe explorer.exe"
   win_RunAct(winTitle, folderPath, "Min")
   win_CloseOnceInactive(winTitle)
}

win_RestoreLeftRight(direction, winTitle := "A") {

   _WinMove() {
      Switch direction {
         Case "right": direction := 960
         Case "left": direction := 0
      }
      WinMove(direction, 0, 960, 1079, winTitle)
   }

   _WinMoveWhenMin() {
      if WinGetMinMax(winTitle)
         return
      _WinMove(), SetTimer(, 0)
   }

   if !WinGetMinMax(winTitle) {
      _WinMove()
      return
   }

   win_RestoreDown(winTitle) ;Unmaximize it
   SetTimer(_WinMoveWhenMin, 20)

}

win_ActiveRegex(winTitle?, winText?, excludeTitle?, excludeText?) {
   SetTitleMatchMode("RegEx")
   return WinActive(winTitle?, winText?, excludeTitle?, excludeText?)
}

win_IsActive(winTitlesArr?) {
   i := 0
   for key, value in winTitlesArr {
      if WinActive(value) {
         i++
      }
   }
   return i
}