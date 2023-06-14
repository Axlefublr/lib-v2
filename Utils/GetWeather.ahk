#Include <Links>
#Include <System\Web>

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
