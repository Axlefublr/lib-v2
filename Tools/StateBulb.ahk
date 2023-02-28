; No dependencies

class StateBulb {

    static __Item[stateName] {
        get => StateBulb.Bulbs[stateName]
    }


    __New(position, color) {
        this.XPosition := StateBulb.Positions[position]
        this.Color     := StateBulb.Colors[color]
    }


    static Unit := A_ScreenWidth / 1920

    static Side    := StateBulb.Unit * 20
    static Spacing := (2 * StateBulb.Side)

    static YPosition := StateBulb._GetYPosition()

    static MaxBulbs := A_ScreenWidth / StateBulb.Spacing

    static Positions := [
        StateBulb._GetXPosition(1),
        StateBulb._GetXPosition(2),
        StateBulb._GetXPosition(3),
        StateBulb._GetXPosition(4),
        StateBulb._GetXPosition(5),
        StateBulb._GetXPosition(6),
    ]

    static Colors := Map(
        "magenta", 0xD3869B,
        "red",     0xDE4D37,
        "yellow",  0xD8A657,
        "green",   0xA9B665,
        "cyan",    0x89B482,
        "blue",    0x7DAEA3,
    )

    static Bulbs := [
        StateBulb(1, "magenta"),
        StateBulb(2, "red"),
        StateBulb(3, "yellow"),
        StateBulb(4, "green"),
        StateBulb(5, "cyan"),
        StateBulb(6, "blue")
    ]


    static _GetXPosition(index) => StateBulb.Unit * (A_ScreenWidth - index * StateBulb.Spacing)
    static _GetYPosition() => A_ScreenHeight - StateBulb.Spacing


    XPosition := unset
    Color     := unset
    GuiObj    := unset
    GuiExist  := false


    Toggle() {
        if this.GuiExist
            this.Destroy()
        else
            this.Create()
    }

    Create() {
        this.GuiObj := Gui("AlwaysOnTop -Caption")
        this.GuiObj.BackColor := this.Color
        this.GuiExist := true
        this._Show()
    }

    Destroy() {
        this.GuiObj.Minimize()
        this.GuiObj.Destroy()
        this.GuiExist := false
    }


    _Show() {
        this.GuiObj.Show(Format(
            "NA w{1} h{1} x{2} y{3}",
            StateBulb.Side,
            this.XPosition,
            StateBulb.YPosition
        ))
    }

}