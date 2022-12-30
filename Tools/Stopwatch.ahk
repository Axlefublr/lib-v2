#Include <Get>
#Include <Tools\Info>

/**
 * A stopwatch, accurate to the seconds
 * Time calculation only happens once you get CurrTime,
 * so there's no Stop method
 */
class Stopwatch {

   /**
    * The time your stopwatch started at
    * In YYYYMMDDHH24MISS format
    * @type {Integer}
    */
   startingTime := 0

   /**
    * Start the timer
    * @returns {Integer} The startingTime property
    */
   Start() => this.startingTime := A_Now

   /**
    * The time passed after the start of the timer
    * @type {String} time in format HH:mm:ss
    */
   CurrTime {
      get => FormatTime(this.__AddPaddingForDateNum(A_Now - this.startingTime), "HH:mm:ss")
   }

   /**
    * FormatTime requires the YYYYMMDDHH24MISS format to format a number into a string
    * It has to have the leading zeros as well, this function adds them
    * @private
    * @returns {Integer} A valid YYYYMMDDHH24MISS number
    */
   __AddPaddingForDateNum(num) {
      while StrLen(num) < 14 {
         num := 0 num
      }
      return num
   }
}