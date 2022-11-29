#Include <String>

Class Alarm {
   
   shouldExitApp := false
   
   __New(hhmm?, shouldExitApp?) {
      
      startTime := A_Now
      
      if IsSet(hhmm) {
         this.hhmm := hhmm
      } else {
         this.hhmm := CleanInputBox().WaitForInput()
      }
      match := this.hhmm.RegexMatch("(\d\d):(\d\d)")
      try {
         hours := match[1]
         minutes := match[2]
      } catch Any {
         throw TypeError("Specify the end time as hh:mm", -1, this.hhmm)
      }
      
      if IsSet(shouldExitApp) {
         this.shouldExitApp := shouldExitApp
      }
      
      this.endTime := DateAdd(startTime, hours, "Hours")
      this.endTime := DateAdd(this.endTime, minutes, "Minutes")
      
      SetTimer(this.bfCheckTime, 30000)
      Info("Alarm set to " this.hhmm)
   }
   
   Stop() => SetTimer(this.bfCheckTime, 0)
   
   bfCheckTime := this.CheckTime.Bind(this)
   CheckTime() {
      if A_Now < this.endTime {
         return
      }
      this.Ring()
      this.Stop()
   }
   
   Ring() {
      gInfo := Infos("Your timer for " this.hhmm " is up!")
      while WinExist(gInfo) {
         SoundBeep()
         Sleep(200)
      }
      if this.shouldExitapp {
         ExitApp()
      }
   }
}