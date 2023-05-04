; No dependencies

class InputExpectedActualError extends Error {
	/**
	 * @param {String} message
	 * @param {String} input The input you give to the test
	 * @param {String} expected The output you expect the test to return
	 * @param {String} actual The output that the test actually returns
	 * @extends {Error}
	 */
	__New(message, input, expected, actual) {
		message := Format("
		(
			{1}
			Input: {2}
			Expected: {3}
			Actual: {4}
		)", message, input, expected, actual,)
		super.__New(message, -1)
	}
}

class InputExpectedActualTypesError extends Error {
	/**
	 * Like InputExpectedActualError, but also shows the types of everything
	 * @param {String} message
	 * @param {String} input The input you give to the test
	 * @param {String} expected The output you expect the test to return
	 * @param {String} actual The output that the test actually returns
	 * @extends {Error}
	 */
	__New(message, input, expected, actual) {
		message := Format("
		(
			{1}
			Input: {2} (Type: {3})
			Expected: {4} (Type: {5})
			Actual: {6} (Type: {7})
		)",
			message,
			input,    Type(input),
			expected, Type(expected),
			actual,   Type(actual)
		)
		super.__New(message, -1)
	}
}
