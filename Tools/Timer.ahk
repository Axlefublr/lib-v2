#Include <Tools\Info>

Class Timer {

   /**
    * You start the timer when you create an object of the class
    * @param time *Integer* 1 hour 20 minutes would be 80, and not 120
    * @param isInMinutes *Boolean* Specify false if you want to create a timer in seconds instead of minutes
    * @param shouldExitapp *Boolean* Should the timer exit the script once it finishes
    * @param shouldRing *Boolean* Should the timer beep with an Infos or just stop your music once it finishes
    */
   __New(time, isInMinutes := true, shouldExitapp := false, shouldRing := true) {

      this.shouldRing := shouldRing
      
      this.timeWord := time " " (isInMinutes ? "minutes" : "seconds")
      this.endTime := Round(A_TickCount + time * (isInMinutes ? 60000 : 1000))

      this.shouldExitapp := shouldExitapp

      this.Start()
   }

   /**
    * Stop the timer preemtively, doesn't stop the alarm if it's already ringing
    * @private
    */
   Stop() => SetTimer(this.foIsItTime, 0)

   /**
    * Starts the timer. Is automatically called from the constructor
    * @private
    */
   Start() {
      SetTimer(this.foIsItTime, 500)
      Info("Timer set for " this.timeWord "!")
   }

   /**
    * Bound function needed for the timer's time checker
    * @private
    */
   foIsItTime := this.IsItTime.Bind(this)

   /**
    * Continues to check whether the time has run out
    * Once it has, disables the timer calling this method
    * And either starts ringing, or stops your music, depending on what you set this.shouldRing in the constructor
    * @private
    */
   IsItTime() {
      if A_TickCount < this.endTime {
         return
      }

      if this.shouldRing
         this.Alarm()
      else 
         this.StopSound()
      this.Stop()
   }

   /**
    * The ringer. Will show you an Infos that displays the time you set that timer for
    * Will continue to beep intermittently until you close the info (press escape or click on the info)
    * @private
    */
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
   
   /**
    * An alternative to the usual beeping ringer, that will instead just disable your music
    * You can get this behavior if you set the "shouldRing" parameter in the constructor to false
    * @private
    */
   StopSound() => Send("{Media_Stop}")
}