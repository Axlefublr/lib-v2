#Include <Extensions\Gui>

class Point {

    __New(x, y, size?, color?) {
        this.x := x
        this.y := y
        if IsSet(color)
            this.Color := color
        if IsSet(size)
            this.Size := size
    }


    Size {
        get => this.unit * this.multiplier
        set => this.multiplier := value
    }

    Color := 0xDE4D37
    unit := A_ScreenDPI / 96
    multiplier := 50
    guiExist := false


    Create() {
        this.GuiObj := Gui("AlwaysOnTop -Caption +ToolWindow")
    }

    Destroy() {

    }


    _Show() {

    }

    ; _Show() {
    ;     this.GuiObj.Show(Format(
    ;         "NA w{1} h{1} x{2} y{3}",
    ;         Round(StateBulb.Side),
    ;         Round(this.XPosition),
    ;         Round(StateBulb.YPosition)
    ;     ))
    ;     this.GuiObj.NeverFocusWindow()
    ;     this.GuiObj.MakeClickthrough()
    ; }

}