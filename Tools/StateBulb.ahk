; No dependencies

class StateBulb {

    static __Item[stateName] {
        get => StateBulb.Bulbs[stateName]
    }


    __New(position, color) {
        this.Position := position
        this.Color := color
        this._Create()
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
        "red",   0x123,
        "green", 0x456,
    )


    _position := unset
    _color := unset


    TurnOn() {

    }

    TurnOff() {

    }

    Toggle() {

    }


    _Create() {

    }

    _Destroy() {

    }

}