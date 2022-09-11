;No dependencies

win_Close(winTitle := "A") {
   try PostMessage("0x0010", , , , winTitle)
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

win_Activate(winTitle, exception?) => (WinActivate(winTitle,, exception ?? ""), WinWaitActive(winTitle,, exception ?? ""))

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
