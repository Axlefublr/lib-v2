; No dependencies

class StateBulb {

    static __Item[stateName] {
        get => StateBulb.Bulbs[stateName]
    }


    __New(position, color) {
        this.Position := position
        this.Color := color
    }


    static Bulbs := Map(
        "CapsLock", StateBulb(1, "green"),
        "VimMode", StateBulb(2, "red")
    )
    static YPosition := A_ScreenHeight / 20 * 19
    static Width     := A_ScreenHeight / 20 * 19
    static Height    := A_ScreenHeight / 20 * 19


    Position {
        get => this._position
        set => this._position := this.Positions[value]
    }
    Color {
        get => this._color
        set => this._color := this.Colors[value]
    }

    Positions := [
        A_ScreenWidth / 20 * 19,
        A_ScreenWidth / 20 * 18
    ]
    Colors := Map(
        "red",   0x443E3C,
        "green", 0xA9B665,
    )


    _guiObj   := unset
    _position := unset
    _color    := unset
    _guiExist := false


    Toggle() {
        if this._guiExist
            this._Destroy()
        else
            this._Create()
    }


    _Create() {
        this._guiObj := Gui("AlwaysOnTop -Caption")
        this._guiObj.BackColor := this.Color
        this._guiExist := true
        this._Show()
    }

    _Destroy() {
        this._guiObj.Minimize()
        this._guiObj.Destroy()
        this._guiExist := false
    }

    _Show() {
        this._guiObj.Show(Format(
            "NA w{1} h{2} x{3} y{4}",
            StateBulb.Width,
            StateBulb.Height,
            this.Position,
            StateBulb.YPosition
        ))
    }

}