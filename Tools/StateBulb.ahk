#Include <Extensions\Gui>

class StateBulb {

    static __Item[stateName] {
        get => StateBulb.Bulbs[stateName]
    }


    __New(position, color) {
        this.XPosition := StateBulb.Positions[position]
        switch Type(color) {
            case "String":  this.Color := StateBulb.Colors[color]
            case "Integer": this.Color := StateBulb.ColorOrder[color]
            default:        throw StateBulb.ConstructorColorTypeError(color)
        }
    }


    static Unit := A_ScreenDPI / 96

    static Side := StateBulb.Unit * 25

    static Spacing := 2 * StateBulb.Side

    static YPosition := StateBulb._GetYPosition()

    static MaxBulbs := Round(A_ScreenWidth / StateBulb.Spacing)

    static Positions := StateBulb._GeneratePositions()

    static Colors := Map(
        "magenta", 0xD3869B,
        "red",     0xDE4D37,
        "yellow",  0xD8A657,
        "green",   0xA9B665,
        "cyan",    0x89B482,
        "blue",    0x7DAEA3,
    )

    static ColorOrder := [
        StateBulb.Colors["magenta"],
        StateBulb.Colors["red"],
        StateBulb.Colors["yellow"],
        StateBulb.Colors["green"],
        StateBulb.Colors["cyan"],
        StateBulb.Colors["blue"],
    ]

    static Bulbs := StateBulb._GeneratePossibleBulbs()


    static _GetXPosition(index) => A_ScreenWidth  - index * StateBulb.Spacing
    static _GetYPosition()      => A_ScreenHeight - StateBulb.Spacing

    static _GeneratePositions() {
        positions := []
        index := 1
        loop StateBulb.MaxBulbs {
            positions.Push(StateBulb._GetXPosition(index))
            index++
        }
        return positions
    }

    static _GeneratePossibleBulbs() {
        bulbs := []
        index := 1
        colorIndex := 1
        loop StateBulb.MaxBulbs {
            bulbs.Push(StateBulb(index, colorIndex))
            if colorIndex >= StateBulb.ColorOrder.Length
                colorIndex := 1
            index++
            colorIndex++
        }
        return bulbs
    }


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
        if this.GuiExist
            return
        this.GuiObj := Gui("AlwaysOnTop -Caption +ToolWindow")
        this.GuiObj.BackColor := this.Color
        this.GuiExist := true
        this._Show()
    }

    Destroy() {
        if !this.GuiExist
            return
        this.GuiObj.Destroy()
        this.GuiExist := false
    }


    _Show() {
        this.GuiObj.Show(Format(
            "NA w{1} h{1} x{2} y{3}",
            Round(StateBulb.Side),
            Round(this.XPosition),
            Round(StateBulb.YPosition)
        ))
        this.GuiObj.NeverFocusWindow()
        this.GuiObj.MakeClickthrough()
    }

    class ConstructorColorTypeError extends TypeError {
        __New(color) {
            this.Message := Format("
            (
                Wrong type passed for the "color" parameter.
                You're supposed to pass one of the two:
                1) String - the name of the color which exists in the Colors map
                2) Integer - the order of the color in the ColorOrder array
                You passed the value of "{1}" of type {2}
            )", color, Type(color))
        }
    }

}