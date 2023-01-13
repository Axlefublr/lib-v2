; No dependencies

class DateTime {

   static Date {
      get => FormatTime(, "yy.MM.dd")
   }

   static Time {
      get => FormatTime(, "HH:mm")
   }

   static WeekDay {
      get => FormatTime(, "dddd")
   }

   /**
    * FormatTime requires the YYYYMMDDHH24MISS format to format a number into a string
    * It has to have the leading zeros as well, this function adds them
    * @returns {Integer} A valid YYYYMMDDHH24MISS number
    */
   static AddPaddingForDateNum(num) {
      while StrLen(num) < 14 {
         num := 0 num
      }
      return num
   }

   /**
    * The YYYYMMDDHH24MISS timestamp is really annoying to work with,
    * use this method to convert it to an object.
    * The time in properties will have leading zeros if necessary.
    * @param timeStamp *YYYYMMDDHH24MISS* timestamp.
    * Accepts an incomplete one, where "10000" would mean 1 hour:
    * the leading zeros required for a correct timestamp are added automatically.
    * @returns {Object} Available properties: years, months, days, hours, minutes, seconds.
    */
   static ParseTimestamp(timeStamp := A_Now) {
      timeStamp := this.AddPaddingForDateNum(timeStamp) ;if there are no leading zeros in the timestamp, "10000" would be considered "the year 1000" rather than "1 hour"

      timeStr := FormatTime(timeStamp, "yyyy MM dd HH mm ss")
      timeArr := timeStr.Split(" ")

      years   := timeArr[1]
      months  := timeArr[2]
      days    := timeArr[3]
      hours   := timeArr[4]
      minutes := timeArr[5]
      seconds := timeArr[6]

      return {
         years:   years,
         months:  months,
         days:    days,
         hours:   hours,
         minutes: minutes,
         seconds: seconds
      }
   }

   /**
    * Convert a YYYYMMDDHH24MISS timestamp into the amount of seconds it is.
    * Years and months are ignored because months are of different lengths.
    * This is useful for specifying the amount of time to pass in the format of the timestamp, rather than having to do math.
    * @param timeStamp *YYYYMMDDHH24MISS*
    * @returns {Integer}
    */
   static ConvertToSeconds(timeStamp) {
      timeObj := this.ParseTimestamp(timeStamp)

      daysMs    := timeObj.days * 86400
      hoursMs   := timeObj.hours * 3600
      minutesMs := timeObj.minutes * 60

      return daysMs + hoursMs + minutesMs + timeObj.seconds
   }

}