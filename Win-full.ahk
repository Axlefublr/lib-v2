#Include <Win>

win_RunAct_Folders(folderPath, runOpt?) {
   winTitle := folderPath " ahk_exe explorer.exe"
   win_RunAct(winTitle, folderPath, runOpt ?? "Min")
}

win_App(winTitle, exePath, runOpt?, winTitleAdditional?) {
   if win_MinMax(winTitle)
      return
   win_RunAct(winTitle, exePath, runOpt?, winTitleAdditional?)
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

   win_RestoreDown(winTitle)	;Unmaximize it
   SetTimer(_WinMoveWhenMin, 20)

}