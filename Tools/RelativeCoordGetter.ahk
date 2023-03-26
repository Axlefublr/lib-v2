#Include <Extensions\Gui>
#Include <Tools\Point>
#Include <Tools\Info>

class RelativeCoordInfo {

    __New() {
        CoordMode("Mouse", "Screen")
        this._CreateGui()
        this.hwnd := this.gObj.Hwnd
        this._AddXCtrl()
        this._AddYCtrl()
        this._SetupHotkey()
    }


    InitX := 0
    InitY := 0
    EndX  := 0
    EndY  := 0
    DiffX := 0
    DiffY := 0


    GetFirstCoords() {
        MouseGetPos(&this.InitX, &this.InitY)
        this.pointInst := Point(this.InitX, this.InitY)
    }

    GetSecondCoords() {
        MouseGetPos(&this.EndX, &this.EndY)
        this.pointInst.Destroy()
    }

    foDestroy := (*) => this.Destroy()
    Destroy() {
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("Escape", "Off")
        Hotkey("1", "Off")
        Hotkey("2", "Off")
        this.gObj.Minimize()
        this.gObj.Destroy()
    }

    CalcualteDiff() {
        this.DiffX := this.EndX - this.InitX
        this.DiffY := this.EndY - this.InitY
    }


    _CreateGui() {
        this.gObj := Gui(, "Relative Coord Info").DarkMode().MakeFontNicer()
    }

    _Show() => this.gObj.Show("AutoSize y0 x0")

    _ToClip := (text, *) => (A_Clipboard := text, Info(text " copied!"))

    _AddXCtrl() {
        foToClip := this._ToClip.Bind(this.DiffX)
        this.gObj.Add("Text", , "Relative X: " this.DiffX)
            .OnEvent("Click", foToClip)
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("1", foToClip, "On")
    }

    _AddYCtrl() {
        foToClip := this._ToClip.Bind(this.DiffY)
        this.gObj.Add("Text", , "Relative Y: " this.DiffY)
            .OnEvent("Click", foToClip)
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("2", foToClip, "On")
    }

    _SetupHotkey() {
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("Escape", foDestroy, "On")
        this.gObj.OnEvent("Close", foDestroy)
    }
}
