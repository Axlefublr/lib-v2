#Include <Tools\Info>

Class Timer {

   __New(time, isInMinutes := true, shouldExitapp := false) {

      this.timeWord := time " " (isInMinutes ? "minutes" : "seconds")
      this.endTime := Round(A_TickCount + time * (isInMinutes ? 60000 : 1000))
      
      this.shouldExitapp := shouldExitapp
      
      this.Start()
   }
   
   Stop() => SetTimer(this.foIsItTime, 0)
   
   Start() {
      SetTimer(this.foIsItTime, 500)
      Info("Timer set for " this.timeWord "!")
   }
   
   foIsItTime := this.IsItTime.Bind(this)
   
   IsItTime() {
      if A_TickCount < this.endTime {
         return
      }
      
      this.Alarm()
      this.Stop()
   }
   
   Alarm() {
      infoHwnd := Infos("Your timer for " this.timeWord " is up!").gInfo.Hwnd
      while WinExist(infoHwnd) {
         SoundBeep()
         Sleep(200)
      }
      if this.shouldExitapp {
         ExitApp()
      }
   }
}