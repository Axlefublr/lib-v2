#Include <Tools\StateBulb>

class Environment {

    static _vimMode := false
    static VimMode {
        get => this._vimMode
        set {
            this._vimMode := value
            if value
                StateBulb[1].Create()
            else
                StateBulb[1].Destroy()
        }
    }

}