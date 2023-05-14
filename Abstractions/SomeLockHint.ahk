#Include <Tools\StateBulb>

SomeLockHint(whatLock, bulbie) {

	newState := !GetKeyState(whatLock, "T")

	newState_Word := newState ? "On" : "Off"

	Set%whatLock%State(newState)

	if newState
		StateBulb[bulbie].Create()
	else
		StateBulb[bulbie].Destroy()
}
