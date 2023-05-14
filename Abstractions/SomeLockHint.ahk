#Include <Tools\StateBulb>

SomeLockHint(whatLock, stateBulb) {

	newState := !GetKeyState(whatLock, "T")

	newState_Word := newState ? "On" : "Off"
	whatLock := StrTitle(whatLock)

	Set%whatLock%State(newState)

	if newState
		StateBulb[stateBulb].Create()
	else
		StateBulb[stateBulb].Destroy()
}
