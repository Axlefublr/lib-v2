; No dependencies

_ArrayToString(this) {
	str := "[ "
	for index, value in this {
		if index = this.Length {
			str .= value " "
			break
		}
		str .= value ", "
	}
	str .= "]"
	return str
}
Array.Prototype.DefineProp("ToString", { Call: _ArrayToString })

_ArrayHasValue(this, valueToFind) {
	for index, value in this {
		if value = valueToFind
			return true
	}
	return false
}
Array.Prototype.DefineProp("HasValue", { Call: _ArrayHasValue })