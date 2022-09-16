GetDateAndTime() => FormatTime(, "yy.MM.dd HH:mm")

GetTimeAndSec() => FormatTime(, "HH:mm:ss")

GetHtml(link) {
   HTTP := ComObject("WinHttp.WinHttpRequest.5.1")
   HTTP.Open("GET", link, true)
   HTTP.Send()
   try HTTP.WaitForResponse()
   catch Any {
      return ""
   }
   return HTTP.ResponseText
}

GetWeather() {
   if !weather_html := GetHtml(Links["weather"])
      return "null"

   RegExMatch(weather_html, "Текущая температура (-?\d+.)", &temp_match)
   temp := temp_match[1]

   RegExMatch(weather_html, "Влажность: (\d+%)", &wetness_match)
   wetness := wetness_match[1]

   RegExMatch(weather_html, "(?i)Ясно|Пасмурно|Облачно|Дождь", &atmosphere_match)
   if atmosphere_match
      atmosphere := StrTitle(atmosphere_match[])
   else
      atmosphere := "Непонятно"

   if InStr(weather_html, "Штиль")
      wind := "Штиль"
   else {
      RegExMatch(weather_html, "Ветер: (\d+(\.\d+)?)", &wind_match)
      wind := wind_match[1] "м/с"
   }

   return temp " " wind " " wetness " " atmosphere
}

/**
* Converts a decimal integer into its hex / unicode / 16-base counterpart
* @param num
* @returns int
*/
TransfToHex(num) => Format("0x{:x}", num)

/**
 * In decimals, the unicode characters for numbers are 48-57, 65-90 for uppercase characters and 97-122 for lowercase characters.
 * @returns an integer that fits at least one of those ranges
 */
GetWordDigitInt() {
   num := 0
   loop {
      num := Random(48, 122)
   } until (num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)
   return num
}

GetWeekDay(day) {
   static ONE_MONTH := 100000000
   if StrLen(day) = 1
      day := "0" day	;We need the leading zero in the YYYYMMDDHH24MISS format if it's a single digit
   date := A_YYYY A_MM day "112233"	;Everything after the day doesn't matter, since we're getting the weekday, 112233 for easy visibility
   if A_DD > day
      date += ONE_MONTH	;Because I don't need to know what *was* the weekday of a passed day, I'll almost always want to know of the day yet to come
   return FormatTime(date, "dddd")
}

;Pass a weekday (string) to get its date (string). Shows the day with no month in an Info(). Both Mon and Monday work. If you input a non-existant weekday, will stop executing after checking the next 7 days, and will say there's an error in an Info()
GetDayFromWeekDay(weekDay) {
   date := A_Now
   i := 0
   Loop {
      i++
      date := DateAdd(date, 1, "Day")
      if i > 7 {
         Info("No such weekday!")
         return
      }
      if FormatTime(date, "dddd") = weekDay
         || FormatTime(date, "ddd") = weekDay
         break
   }
   return FormatTime(date, "d")
}

RadNum() => Random(1000000, 9999999)
