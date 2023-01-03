#Include <Tools\Info>
#Include <Links>
#Include <String>

GetCurrDate()     => FormatTime(, "yy.MM.dd")
GetCurrTime()     => FormatTime(, "HH:mm")
GetCurrWeekDay()  => FormatTime(, "dddd")
GetDateTime()     => GetCurrDate() " " GetCurrTime()
GetDateWeek()     => GetCurrDate() " " GetCurrWeekDay()
GetDateWeekTime() => GetDateWeek() " " GetCurrTime()

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
* @returns {Integer}
*/
TransfToHex(num, hexPrefix := true) => Format((hexPrefix ? "0x" : "") "{:x}", num)

TransfToDecimal(num) => Format("{:u}", num)

RadNum() => Random(1000000, 9999999)

ConvertToRegex(input) {
   scawySymbows := ["\", ".", "(", ")", "{", "}", "[", "]", "/", "?", "+", "*"]
   for key, value in scawySymbows {
      input := StrReplace(input, value, "\" value)
   }
   return input
}