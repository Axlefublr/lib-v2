#Include <Converters\Number>
#Include <Tools\CleanInputBox>
#Include <Extensions\String>
#Include <App\Browser>

class InternetSearch extends CleanInputBox {

	__New(searchEngine) {
		super.__New()
		this.SelectedSearchEngine := this.AvailableSearchEngines[searchEngine]
	}

	FeedQuery(input) {
		restOfLink := this.SanitizeQuery(input)
		Browser.RunLink(this.SelectedSearchEngine restOfLink)
	}

	DynamicallyReselectEngine(input) {
		for key, value in this.SearchEngineNicknames {
			if input.RegExMatch("^" key " ") {
				this.SelectedSearchEngine := value
				input := input[3, -1]
				break
			}
		}
		return input
	}

	TriggerSearch() {
		if !input := super.WaitForInput() {
			return false
		}
		query := this.DynamicallyReselectEngine(input)
		this.FeedQuery(query)
	}

	AvailableSearchEngines := Map(
		"Google",  "https://www.google.com/search?q=",
		"Youtube", "https://www.youtube.com/results?search_query=",
		"Emoji",   "https://emojipedia.org/search/?q=",
		"Yandex",  "https://yandex.ru/search/?text=",
		"Movies",  "https://watchmovieshd.ru/search?keyword=",
		"Phind",   "https://www.phind.com/search?q=",
	)

	SearchEngineNicknames := Map(
		"g",  this.AvailableSearchEngines["Google"],
		"y",  this.AvailableSearchEngines["Youtube"],
		"e",  this.AvailableSearchEngines["Emoji"],
		"ya", this.AvailableSearchEngines["Yandex"],
		"m",  this.AvailableSearchEngines["Movies"],
		"p",  this.AvailableSearchEngines["Phind"],
	)

	;Rename suggestion by @Micha-ohne-el, used to be ConvertToLink()
	SanitizeQuery(query) {
		SpecialCharacters := '%$&+,/:;=?@ "<>#{}|\^~[]``'.Split()
		for key, value in SpecialCharacters {
			query := query.Replace(value, "%" NumberConverter.DecToHex(Ord(value), false))
		}
		return query
	}
}
