;No dependencies

Class Win {

   ;Defaults
   winTitle        := "A"
   winText         := ""
   excludeTitle    := ""
   excludeText     := ""
   winTitles       := []
   exception       := ""
   exePath         := unset
   startIn         := ""
   runOpt          := "Max"
   waitTime        := 120
   toClose         := ""
   direction       := "left"
   startupWintitle := ""

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

      static WrongType_toClose() {
         throw TypeError(
            "Win.toClose has to either be an array or a string",
            -1,
            this.toClose " : " Type(this.toClose)
         )
      }
   }

   SetExplorerWintitle() => this.winTitle := this.exePath " ahk_exe explorer.exe"

   Close() {
      try PostMessage("0x0010",,,, this.winTitle)
   }

   static Close(winTitle := "A") {
      Win({winTitle: winTitle}).Close()
   }

   RestoreDown() {
      try PostMessage("0x112", "0xF120",,, this.winTitle)
   }

   static RestoreDown(winTitle := "A") {
      Win({winTitle: winTitle}).RestoreDown()
   }

   Maximize() {
      try PostMessage("0x112", "0xF030",,, this.winTitle)
   }

   static Maximize(winTitle := "A") {
      Win({winTitle: winTitle}).Maximize()
   }

   Minimize() {
      try PostMessage("0x112", "0xF020",,, this.winTitle)
   }

   static Minimize(winTitle := "A") {
      Win({winTitle: winTitle}).Minimize()
   }

   Activate() {
      try {
         WinActivate(this.winTitle)
         WinWaitActive(this.winTitle)
         return true
      } catch Any {
         return false
      }
   }

   /**
    * What if there a multiple windows that match the same wintitle?
    * This method is an option to activate the second one if the first one is active, and the other way around
    * Supports as many same windows as you want. The time complexity is O(n)
    * If this concerns you, consider having less windows
    * @returns {Boolean} False if there were less than 2 windows that matched (there could be zero); True if the operation completed successfully
    */
   ActivateAnother() {
      windows := WinGetList(this.winTitle,, this.exception)
      if (windows.Length < 2) {
         return false
      }
      temp := this.winTitle
      id   := WinGetID("A")
      i := -1
      inverseLength := -windows.Length
      while i > inverseLength {
         if windows[i] != id {
            this.winTitle := windows[i]
            break
         }
         i--
      }
      this.Activate()
      this.winTitle := temp
      return true
   }

   MinMax() {
      if !WinExist(this.winTitle,, this.exception)
         return false

      if WinActive(this.winTitle,, this.exception) {
         if !this.ActivateAnother()
            this.Minimize()
      }
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
      WinWait(this.startupWintitle ?? this.winTitle,, this.waitTime, this.exception)
      if this.toClose {
         this.CloseOnceExists()
      }
      return true
   }

   CloseOnceExists() {
      stopWaitingAt := A_TickCount + this.waitTime * 1000
      if Type(this.toClose) = "Array"
         SetTimer(foTryCloseArray, 20)
      else if Type(this.toClose) = "String"
         SetTimer(foTryClose, 20)
      else if !this.toClose
         Win.Testing.WrongType_toClose()
      else
         Win.Testing.WrongType_toClose()

      foTryCloseArray() {
         for key, value in this.toClose {
            if WinExist(value) {
               Win.Close(value)
               SetTimer(, 0)
            }
         }
         if A_TickCount >= stopWaitingAt {
            SetTimer(, 0)
         }
      }
      foTryClose() {
         if WinExist(this.toClose) {
            Win.Close(this.toClose)
            SetTimer(, 0)
         }
         else if A_TickCount >= stopWaitingAt {
            SetTimer(, 0)
         }
      }
   }

   RunAct() {
      this.Run()
      if this.startupWintitle {
         temp := this.winTitle
         this.winTitle := this.startupWintitle
      }
      this.Activate()
      if this.startupWintitle {
         this.winTitle := temp
      }
   }

   RunAct_Folders() {
      this.SetExplorerWintitle()
      this.RunAct()
   }

   App() {
      if this.MinMax()
         return true
      this.RunAct()
      return false
   }

   App_Folders() {
      this.SetExplorerWintitle()
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
