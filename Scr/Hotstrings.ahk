#Include <Utils\Hotstringer>
#Include <Tools\CleanInputBox>
#Include <Converters\DateTime>
#Include <Environment>
#Include <Utils\ClipSend>

#sc34:: {
	static DynamicHotstrings := Map(

		"radnum", () => Random(1000000, 9999999),
		"date",   () => DateTime.Date,
		"week",   () => DateTime.WeekDay,
		"time",   () => DateTime.Time,
		"dt",     () => DateTime.Date " " DateTime.Time,
		"dw",     () => DateTime.Date " " DateTime.WeekDay,
		"dwt",    () => DateTime.Date " " DateTime.WeekDay " " DateTime.Time,

	)
	static StaticHotstrings := Map(

		;; Words

		"imm",  "immediately ", ; it's a hard word okay!
		"thu",  "thumbnail ",
		"imp",  "implement ",
		"uni",  "uninterest ",
		"abb",  "abbreviation",
		"unf",  "unfavorite ",
		"aba",  "abbrev-alias ",
		"cata", "cataclysmic ",

		;; Nicknames

		"micha",    "Micha-ohne-el",
		"reiwa",    "rbstrachan",
		"anon",     "anonymous1184",
		"geekdude", "G33kDude",
		"me",       "Axlefublr",
		"wew",      "710902092457312266",

		;; Command line

		"C",     "C# en-us",
		"vimap", "vim.keymap.set()",
		"gh",    "https://github.com/",

	)
	Hotstringer.DynamicHotstrings := DynamicHotstrings
	Hotstringer.StaticHotstrings := StaticHotstrings
	Hotstringer.EndKeys .= "{Enter}{Tab} "
	Hotstringer.Initiate()
}
