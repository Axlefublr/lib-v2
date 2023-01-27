#Include <Utils\KeyChorder>
#Include <App\Browser>
#Include <Loaders\Links>

#n:: {
	key := KeyChorder()
	static actions := Map(

		"m", () => Browser.RunLink(Links["gmail"]),
		"n", () => Browser.MonkeyType.winObj.App(),
		"g", () => Browser.RunLink(Links["ghm"]),
		"f", () => Browser.RunLink(Links["skill factory"]),
		"p", () => Browser.RunLink(Links["gpt"]),
		"r", () => Browser.RunLink(Links["regex"]),
		"w", () => Browser.RunLink(Links["wb"]),

	)
	try actions[key].Call()
}