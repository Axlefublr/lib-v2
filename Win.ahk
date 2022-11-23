;No dependencies

Class Win {

   ;Defaults
   winTitle     := "A"
   winText      := ""
   excludeTitle := ""
   excludeText  := ""
   winTitles    := []
   stack        := 1
   exception    := ""
   exePath      := unset
   startIn      := ""
   runOpt       := "Max"
   waitTime     := 120
   toClose      := ""
   direction    := "left"
   
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
   
   Close() {
      try PostMessage("0x0010",,,, this.winTitle)
   }
   
   static Close(winTitle) {
      Win({winTitle: winTitle}).Close()
   }
   
   RestoreDown() {
      try PostMessage("0x112", "0xF120",,, this.winTitle)
   }
   
   static RestoreDown(winTitle) {
      Win({winTitle: winTitle}).RestoreDown()
   }

   Maximize() {
      try PostMessage("0x112", "0xF030",,, this.winTitle)
   }
   
   static Maximize(winTitle) {
      Win({winTitle: winTitle}).Maximize()
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
         Win.Close(this.toClose)
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

   RestoreLeftRight() {

      _WinMove() {
         static halfScreen := A_ScreenWidth // 2
         Switch this.direction {
            Case "right": this.direction := halfScreen
            Case "left": this.direction := 0
         }
         WinMove(this.direction, 0, halfScreen, A_ScreenHeight, this.winTitle)
      }

      _WinMoveWhenMin() {
         if WinGetMinMax(this.winTitle)
            return
         _WinMove(), SetTimer(, 0)
      }

      if !WinGetMinMax(this.winTitle) {
         _WinMove()
         return
      }

      this.RestoreDown() ;Unmaximize it
      SetTimer(_WinMoveWhenMin, 20)

   }

   ActiveRegex() {
      SetTitleMatchMode("RegEx")
      return WinActive(this.winTitle, this.winText, this.excludeTitle, this.excludeText)
   }
   
   /**
    * Specify an array of winTitles, will return 1 if one of them is active
    * Specify a map if you want to have a "excludeTitle" for one, some, or all of your winTitles
    * @param winTitles *Array/Map*
    * @returns {Integer}
    */
   AreActive() {
      i := 0
      for key, value in this.winTitles {
         if Type(this.winTitles) = "Map" {
            if WinActive(key,, value)
               i++
         } else if Type(this.winTitles) = "Array" {
            if WinActive(value)
               i++
         }
      }
      return i
   }
}
