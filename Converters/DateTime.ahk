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

}