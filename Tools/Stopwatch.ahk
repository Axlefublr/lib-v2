; No dependencies

/**
 * A stopwatch, accurate to the seconds
 * Time calculation only happens once you get CurrTime,
 * so there's no Stop method
 * There's also no need because you do a restart via using Start()
 * There's a static way to use this class, since you will most likely 
 * have hotkeys for starting the stopwatch and getting its current time,
 * and storing a class object can be annoying when you don't plan on
 * having multiple stopwatches at the same time
 */
class Stopwatch {

   /**
    * The time your stopwatch started at
    * In YYYYMMDDHH24MISS format
    * @type {Integer}
    */
   startingTime := unset

   /**
    * Start the stopwatch
    * @returns {Integer} The startingTime property
    */
   Start() => this.startingTime := A_Now

   /**
    * The time passed after the start of the stopwatch
    * @type {String} time in format HH:mm:ss
    */
   CurrTime {
      get => FormatTime(Stopwatch.__AddPaddingForDateNum(A_Now - this.startingTime), "HH:mm:ss")
   }

   /**
    * FormatTime requires the YYYYMMDDHH24MISS format to format a number into a string
    * It has to have the leading zeros as well, this function adds them
    * @private
    * @returns {Integer} A valid YYYYMMDDHH24MISS number
    */
   static __AddPaddingForDateNum(num) {
      while StrLen(num) < 14 {
         num := 0 num
      }
      return num
   }

   /**
    * The time your stopwatch started at
    * In YYYYMMDDHH24MISS format
    * @type {Integer}
    */
   static startingTime := 0

   /**
    * Start the stopwatch by setting the startingTime property
    * @returns {Integer} The startingTime property
    */
   static Start() => this.startingTime := A_Now

   /**
    * The time passed after the start of the stopwatch
    * @type {String} time in format HH:mm:ss
    */
   static CurrTime {
      get => FormatTime(this.__AddPaddingForDateNum(A_Now - this.startingTime), "HH:mm:ss")
   }
}