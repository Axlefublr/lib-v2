#Include <Extensions\Map>

class Layouts {

	/**
	 * @type {Map<String>}
	 */
	static RusToEng := Map(
		"ё", "``",
		"й", "q",
		"ц", "w",
		"у", "e",
		"к", "r",
		"е", "t",
		"н", "y",
		"г", "u",
		"ш", "i",
		"щ", "o",
		"з", "p",
		"х", "[",
		"ъ", "]",
		"ф", "a",
		"ы", "s",
		"в", "d",
		"а", "f",
		"п", "g",
		"р", "h",
		"о", "j",
		"л", "k",
		"д", "l",
		"ж", ";",
		"э", "'",
		"я", "z",
		"ч", "x",
		"с", "c",
		"м", "v",
		"и", "b",
		"т", "n",
		"ь", "m",
		"б", ",",
		"ю", ".",
		".", "/",
		"Ё", "~",
		"`"", "@",
		"№",  "#",
		";",  "$",
		":",  "^",
		"?",  "&",
		"Й", "Q",
		"Ц", "W",
		"У", "E",
		"К", "R",
		"Е", "T",
		"Н", "Y",
		"Г", "U",
		"Ш", "I",
		"Щ", "O",
		"З", "P",
		"Х", "{",
		"Ъ", "}",
		"/", "|",
		"Ф", "A",
		"Ы", "S",
		"В", "D",
		"А", "F",
		"П", "G",
		"Р", "H",
		"О", "J",
		"Л", "K",
		"Д", "L",
		"Ж", ":",
		"Э", '"',
		"Я", "Z",
		"Ч", "X",
		"С", "C",
		"М", "V",
		"И", "B",
		"Т", "N",
		"Ь", "M",
		"Б", "<",
		"Ю", ">",
		",", "?",
	)

	/**
	 * @type {Map<String>}
	 */
	static EngToRus := Layouts.RusToEng.Reverse()

	/**
	 * Convert text written in the russian layout to the same characters, but in the english layout
	 * @param {String} text
	 * @returns {String} туче => text
	 */
	static ConvertToEnglish(text) {
		translatedText := ""
		for index, character in StrSplit(text) {
			if Layouts.RusToEng.Has(character)
				translatedText .= Layouts.RusToEng[character]
			else
				translatedText .= character
		}
		return translatedText
	}

	/**
	 * Convert text written in the english layout to the same characters, but in the russian layout
	 * @param {String} text
	 * @returns {String} text => туче
	 */
	static ConvertToRussian(text) {
		translatedText := ""
		for index, character in StrSplit(text) {
			if Layouts.EngToRus.Has(character)
				translatedText .= Layouts.EngToRus[character]
			else
				translatedText .= character
		}
		return translatedText
	}

}