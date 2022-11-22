#Include <Win>
#Include <Tools\Info>
#Include <Paths>

Class Davinci {

   static winTitle := "DaVinci Resolve ahk_exe Resolve.exe"
   
   static Insert() {
      if !Win({winTitle: this.winTitle}).Activate() {
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
      if !Win({winTitle: this.winTitle}).Activate() {
         Info("No Davinci Resolve window!")
         return 
      }
      Win({winTitle: this.winTitle}).RestoreDown()
      WinMove(-8, 0, 1492, A_ScreenHeight, this.winTitle)
      Win({winTitle: Paths.Pictures}).RunAct_Folders()
      WinMove(1466, 0, 463, A_ScreenHeight)
      Win({winTitle: this.winTitle}).Activate()
   }

}