; No dependencies

/**
 * Time a function object's execution
 * @param {FuncObj} funcObj
 * @returns {Float} Time in seconds, and 7 digits after the .
 */
MeasureExecutionInSeconds(funcObj) {
	DllCall("GetSystemTimePreciseAsFileTime", "Int64P", &Start := 0)
	funcObj()
	DllCall("GetSystemTimePreciseAsFileTime", "Int64P", &End := 0)
	return Round((End - Start) / 10000000, 7)
}