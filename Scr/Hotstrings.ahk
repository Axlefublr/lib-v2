#Include <Utils\Hotstringer>
#Include <Tools\CleanInputBox>
#Include <Converters\DateTime>
#Include <Utils\LangDict>
#Include <Utils\CharGenerator>
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
		"uclanr", () => GetRandomWord("english") " ",
		"ilandh", () => GetRandomWord("russian") " ",
		"chrs",   () => CharGenerator(2).GenerateCharacters(15),

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

		"h",     "--help",
		"hl",    "--help | less",
		"l",     "| less",
		"proj",  "--project ",
		"vers",  "--version",
		"color", "--color=always",
		"sta",   "--staged ",
		"C",     "C# en-us",
		"en",    "en-us",
		"vimap", "vim.keymap.set()",

	)
	Hotstringer.DynamicHotstrings := DynamicHotstrings
	Hotstringer.StaticHotstrings := StaticHotstrings
	Hotstringer.EndKeys .= "{Enter}{Tab} "
	Hotstringer.Initiate()
}
