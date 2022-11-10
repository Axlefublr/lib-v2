#Include <Info>

Class Timer {

   __New(time, isInMinutes := true, shouldExitapp := false) {

      this.timeWord := time " " (isInMinutes ? "minutes" : "seconds")
      this.endTime := Round(A_TickCount + time * (isInMinutes ? 60000 : 1000))
      
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
      infoHwnd := Info("Your timer for " this.timeWord " is up!").Hwnd
      while WinExist(infoHwnd) {
         SoundBeep()
         Sleep(200)
      }
   }
}