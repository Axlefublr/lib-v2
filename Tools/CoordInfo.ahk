#Include <Extensions\Gui>
#Include <Tools\Info>

class CoordInfo {

    __New() {
        this._CreateGui()
        this.hwnd := this.gObj.Hwnd
        this._AddScreenCtrls()
        this._AddWindowCtrls()
        this._AddClientCtrls()
        this._AddPixelCtrl()
        this._AddCtrlClickCtrl()
        this._Show()
        this._SetHotkey()
    }


    static PreferredQuotes := '"'


    static GetScreenCoords() {
        CoordMode("Mouse", "Screen")
        MouseGetPos(&X, &Y)
        return {x: X, y: Y}
    }

    static GetWindowCoords() {
        CoordMode("Mouse", "Window")
        MouseGetPos(&X, &Y)
        return {x: X, y: Y}
    }

    static GetClientCoords() {
        CoordMode("Mouse", "Client")
        MouseGetPos(&X, &Y)
        return {x: X, y: Y}
    }

    static GetScreenColor() {
        coords := CoordInfo.GetScreenCoords()
        CoordMode("Pixel", "Screen")
        return PixelGetColor(coords.x, coords.y, "Alt Slow")
    }


    foDestroy := (*) => this.Destroy()
    Destroy() {
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("Escape", "Off")
        Hotkey("1", "Off")
        Hotkey("2", "Off")
        Hotkey("3", "Off")
        Hotkey("4", "Off")
        Hotkey("5", "Off")
        this.gObj.Minimize()
        this.gObj.Destroy()
    }


    _CreateGui() => this.gObj := Gui(, "Coord Getter").DarkMode().MakeFontNicer(30)

    _Show() => this.gObj.Show("AutoSize y0 x0")

    _ToClip := (text, *) => (A_Clipboard := text, Info(text " copied!"))

    _AddScreenCtrls() {
        crds := CoordInfo.GetScreenCoords()
        this.gObj.Add("Text",     , "Screen: "    ).OnEvent("Click", this._ToClip.Bind(crds.X " " crds.Y))
        this.gObj.Add("Text", "x+", "x" crds.X " ").OnEvent("Click", this._ToClip.Bind(crds.X))
        this.gObj.Add("Text", "x+", "y" crds.Y " ").OnEvent("Click", this._ToClip.Bind(crds.Y))
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("1", this._ToClip.Bind(crds.X " " crds.Y), "On")
    }

    _AddWindowCtrls() {
        crds := CoordInfo.GetWindowCoords()
        this.gObj.Add("Text", "xm", "Window: "    ).OnEvent("Click", this._ToClip.Bind(crds.X " " crds.Y))
        this.gObj.Add("Text", "x+", "x" crds.X " ").OnEvent("Click", this._ToClip.Bind(crds.X))
        this.gObj.Add("Text", "x+", "y" crds.Y " ").OnEvent("Click", this._ToClip.Bind(crds.Y))
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("2", this._ToClip.Bind(crds.X " " crds.Y), "On")
    }

    _AddClientCtrls() {
        crds := CoordInfo.GetWindowCoords()
        this.gObj.Add("Text", "xm", "Client: "  ).OnEvent("Click", this._ToClip.Bind(crds.X " " crds.Y))
        this.gObj.Add("Text", "x+", "x" crds.X " ").OnEvent("Click", this._ToClip.Bind(crds.X))
        this.gObj.Add("Text", "x+", "y" crds.Y " ").OnEvent("Click", this._ToClip.Bind(crds.Y))
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("3", this._ToClip.Bind(crds.X " " crds.Y), "On")
    }

    _AddPixelCtrl() {
        pixel := CoordInfo.GetScreenColor()
        this.gObj.Add("Text", "xm", "Pixel: " pixel)
            .OnEvent("Click", this._ToClip.Bind(pixel))
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("4", this._ToClip.Bind(pixel), "On")
    }

    _AddCtrlClickCtrl() {
        crds := CoordInfo.GetClientCoords()
        ctrlClickString := CoordInfo.PreferredQuotes "x" crds.X " y" crds.Y CoordInfo.PreferredQuotes
        this.gObj.Add("Text", "xm", "CtrlClick Format")
            .OnEvent("Click", this._ToClip.Bind(ctrlClickString))
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("5", this._ToClip.Bind(ctrlClickString), "On")
    }

    _SetHotkey() {
        HotIfWinActive("ahk_id " this.hwnd)
        Hotkey("Escape", this.foDestroy, "On")
        this.gObj.OnEvent("Close", this.foDestroy)
    }

}
