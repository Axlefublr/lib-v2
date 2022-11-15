;No dependencies

Class Win {

   winTitle := "A"
   stack := 1
   exception := ""
   
   __New(paramsObject?) {
      if !IsSet(paramsObject) {
         return
      }
      if Type(paramsObject) != "Object" {
         throw TypeError("Specify an object.`nYou specified: " Type(paramsObject), -1, "paramsObject in __New() of the Win class")
      }
      for key, value in paramsObject.OwnProps() {
         this.%key% := value
      }
   }
   
   Close() {
      try PostMessage("0x0010",,,, this.winTitle)
   }
   
   RestoreDown() {
      try PostMessage("0x112", "0xF120",,, this.winTitle)
   }

   Maximize() {
      try PostMessage("0x112", "0xF030",,, this.winTitle)
   }

   Minimize() {
      try PostMessage("0x112", "0xF020",,, this.winTitle)
   }

   Activate() {
      winTitle := WinGetList(this.winTitle,, this.exception)[this.stack]
      WinActivate(winTitle)
      WinWaitActive(winTitle)
   }

   MinMax() {
      if !WinExist(this.winTitle,, this.exception)
         return false

      if WinActive(this.winTitle,, this.exception)
         this.Minimize()
      else
         this.Activate()
      return true
   }

   win_Run(winTitle, exePath, runOpt?, winTitleAdditional?, startIn?, exception?) {
      if WinExist(this.winTitle)
         return false
      Run(exePath, startIn ?? "", runOpt ?? "Max")
      WinWait(this.winTitle, , 120, exception ?? "")
      if winTitleAdditional ?? false {
         WinWait(winTitleAdditional, , 120)
         win_Close(winTitleAdditional)
      }
      return true
   }

   win_RunAct(winTitle, exePath, runOpt?, winTitleAdditional?, startIn?, exception?) {
      win_Run(this.winTitle, exePath, runOpt?, winTitleAdditional?, startIn?, exception?)
      win_Activate(this.winTitle, exception?)
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

   /**
    * Specify an array of winTitles, will return 1 if one of them is active
    * Specify a map if you want to have a "excludeTitle" for one, some, or all of your winTitles
    * @param winTitles *Array/Map*
    * @returns {Integer}
    */
   win_IsActive(winTitles?) {
      i := 0
      for key, value in winTitles {
         if Type(winTitles) = "Map" {
            if WinActive(key,, value)
               i++
         } else if Type(winTitles) = "Array" {
            if WinActive(value) 
               i++
         }
      }
      return i
   }
}
