; No dependencies

Autoclicker() {
	static state := false
	state := !state
	SetTimer(Click, state ? 1 : 0)
}