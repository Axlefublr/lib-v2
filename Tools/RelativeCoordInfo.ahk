#Include <Extensions\Gui>
#Include <Tools\Point>
#Include <Tools\Info>

class RelativeCoordInfo {

    __New() {
        this.Setup()
    }


    InitX := 0
    InitY := 0
    EndX  := 0
    EndY  := 0

    DiffX {
        get => this.EndX - this.InitX
    }
    DiffY {
        get => this.EndY - this.InitY
    }


    static JustCallThis() {
        static firstTime := true
        static inst
        if firstTime {
            inst := RelativeCoordInfo()
            inst.GetFirstCoords()
            firstTime := false
            return
        }
        inst.GetSecondCoords()
        inst.CalcualteDiff()
        inst.Show()
        firstTime := true
    }

    GetFirstCoords() {
        MouseGetPos(&InitX, &InitY)
        this.InitX := InitX
        this.InitY := InitY
        this.pointInst := Point(this.InitX, this.InitY)
        this.pointInst.Create()
    }

    GetSecondCoords() {
        MouseGetPos(&EndX, &EndY)
        this.EndX := EndX
        this.EndY := EndY
        this.pointInst.Destroy()
    }

    Setup() {
        CoordMode("Mouse", "Screen")
        this._CreateGui()
        this.hwnd := this.gObj.Hwnd
        this._SetupHotkey()
    }

    Show() {
        this._AddXCtrl()
        this._AddYCtrl()
        this.gObj.Show("AutoSize y0 x0")
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

    _CreateGui() {
        this.gObj := Gui(, "Relative Coord Info").DarkMode().MakeFontNicer()
    }

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
        Hotkey("Escape", this.foDestroy, "On")
        this.gObj.OnEvent("Close", this.foDestroy)
    }
}