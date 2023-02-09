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
        )", message, input, expected, actual)
        super.__New(message, -1)
    }
}
