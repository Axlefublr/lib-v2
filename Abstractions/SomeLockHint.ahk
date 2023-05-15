#Include <Tools\StateBulb>

SomeLockHint(whatLock, bulbie) {

	newState := !GetKeyState(whatLock, "T")

	Set%whatLock%State(newState)

	if newState
		StateBulb[bulbie].Create()
	else
		StateBulb[bulbie].Destroy()
}
