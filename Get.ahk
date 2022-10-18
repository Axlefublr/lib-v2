#Include <Info>

GetDate() => FormatTime(, "yy.MM.dd")
GetTime() => FormatTime(, "HH:mm")
GetDateAndTime() => GetDate() " " GetTime()

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
TransfToHex(num) => Format("0x{:x}", num)

TransfToDecimal(num) => Format("{:u}", num)

/**
 * Returns a random character. Number / lowercase english character / uppercase english character
 * @returns {String}
 */
GetRandomCharacter() {
   picker := Random(1, 3)
   static CharClasses := [
      Random.Bind(48, 57), ;Decimal range for numbers
      Random.Bind(65, 90), ;Decimal range for lowercase characters
      Random.Bind(97, 122) ;Decimal range for uppercase characters
   ]

   ProperCharNum := CharClasses[picker].Call()

   return Chr(TransfToHex(ProperCharNum)) ;Chr() expects a 16 base number, so we're converting a decimal to hex
}

/**
 * Get a string of random characters: numbers, lowercase and uppercase english characters
 * @param chars *Integer* The length of the string you want
 * @returns {String}
 */
GetStringOfRandChars(chars) {
   randString := ""
   Loop chars {
      randString .= GetRandomCharacter()
   }
   return randString
}

RadNum() => Random(1000000, 9999999)

ConvertToRegex(input) {
   scawySymbows := ["\", ".", "(", ")", "{", "}", "[", "]", "/", "?", "+", "*"]
   for key, value in scawySymbows {
      input := StrReplace(input, value, "\" value)
   }
   return input
}