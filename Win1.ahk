;No dependencies

Class Win {

   winTitle  := "A"
   stack     := 1
   exception := ""
   exePath   := unset
   startIn   := ""
   runOpt    := "Max"
   waitTime  := 120
   toClose   := ""
   
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
   
   Class Testing {
      static NoExePath() {
         throw TargetError("Specify a file path", -1)
      }
   }
   
   GetExplorerWintitle() => this.winTitle := this.exePath " ahk_exe explorer.exe"
   
   Close(winTitle := this.winTitle) {
      try PostMessage("0x0010",,,, winTitle)
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

   Run() {
      if WinExist(this.winTitle,, this.exception)
         return false
      if !this.exePath {
         Win.Testing.NoExePath()
      }
      Run(this.exePath, this.startIn, this.runOpt)
      WinWait(this.winTitle,, this.waitTime, this.exception)
      if this.toClose {
         WinWait(this.toClose,, this.waitTime)
         win_Close(this.toClose)
      }
      return true
   }

   RunAct() {
      this.Run()
      this.Activate()
   }

   RunAct_Folders() {
      if !this.runOpt {
         this.runOpt := "Min"
      }
      this.GetExplorerWintitle()
      this.RunAct()
   }

   App() {
      if this.MinMax()
         return
      this.RunAct()
   }

   App_Folders() {
      this.GetExplorerWintitle()
      this.App()
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
