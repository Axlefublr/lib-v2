#Include <Tools\ToggleInfo>

ToggleModifier(modifierName) {

	static ctrlState  := false
	static shiftState := false
	static altState   := false
	static winState   := false

	__Toggle(key) {
		%key%State := !%key%State
		Send("{" key (%key%State ? "Down" : "Up") "}")
		ToggleObj := ToggleInfo(key " " (%key%State ? "On" : "Off"))
		return ToggleObj
	}

	__Toggle(modifierName)
}
