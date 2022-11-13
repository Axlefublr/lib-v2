#Include <Win>
#Include <Tools\Info>
#Include <Paths>

Class Davinci {

   static winTitle := "DaVinci Resolve ahk_exe Resolve.exe"
   
   static Insert() {
      if !win_Activate(this.winTitle) {
         Info("Window could not be activated")
         return
      }
      ControlClick("X79 Y151", this.winTitle, , "R")
      Send("{Down 2}{Enter}")
      if !WinWaitActive("New Timeline Properties",, 3)
         return
      Send("{Enter}")
   }

   static Setup() {
      if !win_Activate(this.winTitle) {
         Info("No Davinci Resolve window!")
         return 
      }
      win_RestoreDown(this.winTitle)
      WinMove(-8, 0, 1492, A_ScreenHeight, this.winTitle)
      win_RunAct_Folders(Paths.Pictures)
      WinMove(1466, 0, 463, A_ScreenHeight)
      win_Activate(this.winTitle)
   }

}