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

}