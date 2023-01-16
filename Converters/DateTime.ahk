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
    * FormatTime requires the YYYYMMDDHH24MISS format to have 14 characters in it.
    * If it doesn't, your time / date will be calculated incorrectly.
    * This method makes sure the format is correct.
    * @returns {Integer} A YYYYMMDDHH24MISS number
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
      timeArr := StrSplit(timeStr, " ")

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

   /**
    * Add a timestamp to a timestamp.
    * Months and years are completely ignored on toAdd, so use base as the number you want to add to
    * and toAdd as the date you're adding to it
    * @param base *YYYYMMDDHH24MISS*
    * @param toAdd *YYYYMMDDHH24MISS*
    * @returns {YYYYMMDDHH24MISS}
    */
   static AddTimestamp(base, toAdd) {
      base := this.AddPaddingForDateNum(base)
      toAddObj := this.ParseTimestamp(toAdd)
      base := DateAdd(base, toAddObj.seconds, "seconds")
      base := DateAdd(base, toAddObj.minutes, "minutes")
      base := DateAdd(base, toAddObj.hours, "hours")
      base := DateAdd(base, toAddObj.days, "days")
      return base
   }

}