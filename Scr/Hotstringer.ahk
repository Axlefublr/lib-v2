#Include <Tools\CleanInputBox>
#Include <Converters\DateTime>
#Include <Utils\Char>
#Include <Utils\CharGenerator>
#Include <Loaders\Links>
#Include <Utils\ClipSend>

#m:: {
	input := CleanInputBox().WaitForInput()
	if !input {
		return
	}
	static DynamicHotstrings := Map(

		"radnum",    () => Random(1000000, 9999999),
		"date",      () => DateTime.Date,
		"datew",     () => DateTime.WeekDay,
		"time",      () => DateTime.Time,
		"datetime",  () => DateTime.Date " " DateTime.Time,
		"datewtime", () => DateTime.Date " " DateTime.WeekDay " " DateTime.Time,
		"uclanr",    () => GetRandomWord("english") " ",
		"ilandh",    () => GetRandomWord("russian") " ",
		"chrs",      () => CharGenerator(2).GenerateCharacters(15),

	)
	static StaticHotstrings := Map(

		"gh",    Links["gh"],
		"ghm",   Links["ghm"],
		"micha", "Micha-ohne-el",
		"reiwa", "rbstrachan",
		"me",    "Axlefublr",

	)
	try {
		output := DynamicHotstrings[input].Call()
	} catch Any {
		try output := StaticHotstrings[input]
		catch Any {
			return
		}
	}
	ClipSend(output)
}
