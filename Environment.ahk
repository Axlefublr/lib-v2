#Include <Tools\StateBulb>

class Environment {

    static VimMode := false

    static _numlock := 0
    static NumLock {
        get => this._numlock
        set {
            if value
                StateBulb[3].Create()
            else
                StateBulb[3].Destroy()
            this._numlock := value
        }
    }

}