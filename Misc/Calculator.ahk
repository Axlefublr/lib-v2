#Include <Utils\Eval>

Calculator(expression) {
	result := eval(expression)
	if Round(result) = result {
		result := Round(result)
	}
	return result
}
