#Include <Tools\StateBulb>

SomeLockHint(whatLock) {

    newState := !GetKeyState(whatLock, "T")

    newState_Word := newState ? "On" : "Off"
    whatLock := StrTitle(whatLock)

    Set%whatLock%State(newState)

    if newState
        StateBulb[2].Create()
    else
        StateBulb[2].Destroy()
}
