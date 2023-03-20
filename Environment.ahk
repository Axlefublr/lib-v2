#Include <Tools\StateBulb>

class Environment {

    static VimMode := false

    static _sndMem := false
    static SndMem {
        get => this._sndMem
        set {
            if value
                StateBulb[5].Create()
            else
                StateBulb[5].Destroy()
            this._sndMem := value
        }
    }

    static _numlock := false
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