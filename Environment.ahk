#Include <Tools\StateBulb>

class Environment {

    static VimMode := false

    static _numlock := 0
    static NumLock {
        get => this._numlock
        set {
            StateBulb[value + 7].Create()
            SetTimer(() => StateBulb[value + 7].Destroy(), -200)
            this._numlock := value
        }
    }

}