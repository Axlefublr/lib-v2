#Include <Tests\Testable>
#Include <Tests\ErrorObjects>
#Include <Converters\Layouts>

class LayoutsTests extends Testable {

	static __New() {
		LayoutsTests().RunAll()
	}

	ConvertToEnglish_NormalCharacters() {

		input    := "фФ"
		expected := "aA"

		actual := Layouts.ConvertToEnglish(input)

		if actual != expected
			throw InputExpectedActualError("ConvertToEnglish_NormalCharacters", input, expected, actual)
	}

	ConvertToEnglish_SpecialCharacters() {

		input    := "хХъЪ\/жЖэЭбБюЮ.,ёЁ"
		expected := "[{]}\|;:'`",<.>/?``~"

		actual := Layouts.ConvertToEnglish(input)

		if actual != expected
			throw InputExpectedActualError("ConvertToEnglish_SpecialCharacters", input, expected, actual)
	}

	ConvertToEnglish_NumberRow() {

		input    := "`"№;:?"
		expected := "@#$^&"

		actual := Layouts.ConvertToEnglish(input)

		if actual != expected
			throw InputExpectedActualError("ConvertToEnglish_NumberRow", input, expected, actual)
	}

	ConvertToRussian_NormalCharacters() {

		input    := "aA"
		expected := "фФ"

		actual := Layouts.ConvertToRussian(input)

		if actual != expected
			throw InputExpectedActualError("ConvertToRussian_NormalCharacters", input, expected, actual)
	}

	ConvertToRussian_SpecialCharacters() {

		input    := "[{]}\|;:'`",<.>/?``~"
		expected := "хХъЪ\/жЖэЭбБюЮ.,ёЁ"

		actual := Layouts.ConvertToRussian(input)

		if actual != expected
			throw InputExpectedActualError("ConvertToRussian_SpecialCharacters", input, expected, actual)
	}

	ConvertToRussian_NumberRow() {

		input    := "@#$^&"
		expected := "`"№;:?"

		actual := Layouts.ConvertToRussian(input)

		if actual != expected
			throw InputExpectedActualError("ConvertToRussian_NumberRow", input, expected, actual)
	}
}
