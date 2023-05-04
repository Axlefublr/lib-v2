#Include <Converters\Number>

class CharGenerator {

	static NumberRange    := [48, 57]
	static LowercaseRange := [97, 122]
	static UppercaseRange := [65, 90]

	static Ranges := [
		this.LowercaseRange,
		this.UppercaseRange,
		this.NumberRange
	]

	/**
	 * The higher the number, the more different types of characters will be in the random character(s)
	 * Choose 1 for lowercase characters only
	 * 2 for uppercase also
	 * 3 for numbers as well
	 * @type {Integer}
	 */
	Complexity := unset

	/**
	 * Use this class to generate a random character / a string of random characters
	 * @param complexity *Integer* The higher the number, the more different types of characters will be in the random character(s)
	 * Choose 1 for lowercase characters only
	 * 2 for uppercase also
	 * 3 for numbers as well
	 * @throws {IndexError} if you specify a complexity range that doesn't exist
	 * @example <caption>Generate a random character that could be a lowercase character, an uppercase character, or a number</caption>
	 * character := CharGenerator(3).GenerateCharacter()
	 * @example <caption>Generate a string of 20 random characters</caption>
	 * characters := CharGenerator(3).GenerateCharacters(20)
	 */
	__New(complexity) {
		if complexity < 1 {
			throw IndexError("Please specify a natural positive number", -1, "CharGenerator(" complexity ")")
		} else if complexity > 3 {
			throw IndexError("Currently only three ranges are supported", -1, "CharGenerator(" complexity ")")
		}

		this.Complexity := complexity
	}

	/**
	 * There's an equal chance for a lowercase character, an uppercase character and a number to show up
	 * @returns {String} a random character
	 */
	GenerateCharacter() {
		if this.Complexity > 1 {
			picker := Random(1, this.Complexity)
		}
		picker := picker ?? 1

		minCharNum := CharGenerator.Ranges[picker][1]
		maxCharNum := CharGenerator.Ranges[picker][2]
		charNumber := Random(minCharNum, maxCharNum)

		return Chr(NumberConverter.DecToHex(charNumber))
	}

	/**
	 * Same as GenerateCharacter(), but multiple
	 * @param amount *Integer*
	 * @returns {String}
	 */
	GenerateCharacters(amount) {
		text := ""
		loop amount {
			text .= this.GenerateCharacter()
		}
		return text
	}

}