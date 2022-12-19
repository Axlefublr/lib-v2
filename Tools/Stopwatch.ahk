#Include <Get>
#Include <Tools\Info>

Stopwatch() {
   static startingTime
   static runs := false
   if !runs {
      startingTime := A_Now
      runs := !runs
      return false
   }
   runs := !runs
   return FormatTime(AddPaddingForDateNum(A_Now - startingTime), "HH:mm:ss")
}