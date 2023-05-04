#Include <Extensions\Json>
#Include <Abstractions\Text>
#Include <Paths>
#Include <Tools\Info>

RemindDate() {
	static events    := JSON.parse(ReadFile(Paths.Ptf["Events"]))
	static birthdays := JSON.parse(ReadFile(Paths.Ptf["Birthdays"]))

	today := FormatTime(, "yy.MM.dd")
	try Info(events[today])

	today := FormatTime(, "MM.dd")
	try Info(birthdays[today])
}
