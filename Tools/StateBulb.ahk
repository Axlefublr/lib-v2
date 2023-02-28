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
    static HorizontalSeparator := 30
    static Side := A_ScreenHeight / 30 * 1

    static Positions := [
        A_ScreenWidth / StateBulb.HorizontalSeparator * 19,
        A_ScreenWidth / StateBulb.HorizontalSeparator * 18
    ]
    static Colors := Map(
        "red",   0x443E3C,
        "green", 0xA9B665,
    )


    Position {
        get => this._position
        set => this._position := StateBulb.Positions[value]
    }
    Color {
        get => this._color
        set => this._color := StateBulb.Colors[value]
    }


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
            StateBulb.Side,
            StateBulb.Side,
            this.Position,
            StateBulb.YPosition
        ))
    }

}