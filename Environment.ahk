#Include <Tools\StateBulb>

class Environment {

    static _vimMode := false
    static VimMode {
        get => this._vimMode
        set {
            this._vimMode := value
            if value
                StateBulb[1].Create()
            else {
                StateBulb[1].Destroy()
                this.WindowManagerMode := value
            }
        }
    }

    static _windowManagerMode := false
    static WindowManagerMode {
        get => this._windowManagerMode
        set {
            this._windowManagerMode := value
            if value
                StateBulb[5].Create()
            else
                StateBulb[5].Destroy()
        }
    }

}