#Include <Tools\ToggleInfo>

SomeLockHint(whatLock) {

    newState := !GetKeyState(whatLock, "T")

    newState_Word := newState ? "On" : "Off"
    whatLock := StrTitle(whatLock)

    Set%whatLock%State(newState)

    ToggleInfo(whatLock " " newState_Word)
}
