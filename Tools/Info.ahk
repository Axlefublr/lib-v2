#Include <Extensions\Array>
#Include <Extensions\Gui>
#Include <Extensions\String>

class Infos {

    /**
     * To use Info, you just need to create an instance of it, no need to call any method after
     * @param text *String*
     * @param autoCloseTimeout *Integer* in milliseconds. Doesn't close automatically
     */
    __New(text, autoCloseTimeout := 0) {
        this.autoCloseTimeout := autoCloseTimeout
        this.text := text
        this._CreateGui()
        this.hwnd := this.gInfo.hwnd
        if !this._GetAvailableSpace() {
            this._StopDueToNoSpace()
            return
        }
        this._SetupHotkeysAndEvents()
        this._SetupAutoclose()
        this._Show()
    }


    static fontSize     := 20
    static distance     := 3
    static unit         := A_ScreenDPI / 96
    static guiWidth     := Infos.fontSize * Infos.unit * Infos.distance
    static maximumInfos := Floor(A_ScreenHeight / Infos.guiWidth)
    static spots        := Infos._GeneratePlacesArray()
    static foDestroyAll := (*) => Infos.DestroyAll()
    static maxNumberedHotkeys := 12
    static maxWidthInChars := 104


    static DestroyAll() {
        for index, infoObj in Infos.spots {
            if !infoObj
                continue
            infoObj.Destroy()
        }
    }


    static _GeneratePlacesArray() {
        availablePlaces := []
        loop Infos.maximumInfos {
            availablePlaces.Push(false)
        }
        return availablePlaces
    }


    autoCloseTimeout := 0
    bfDestroy := this.Destroy.Bind(this)


    /**
     * Will replace the text in the Info
     * If the window is destoyed, just creates a new Info. Otherwise:
     * If the text is the same length, will just replace the text without recreating the gui.
     * If the text is of different length, will recreate the gui in the same place
     * (once again, only if the window is not destroyed)
     * @param newText *String*
     * @returns {Infos} the class object
     */
    ReplaceText(newText) {

        try WinExist(this.gInfo)
        catch
            return Infos(newText, this.autoCloseTimeout)

        if StrLen(newText) = StrLen(this.gcText.Text) {
            this.gcText.Text := newText
            this._SetupAutoclose()
            return this
        }

        Infos.spots[this.spaceIndex] := false
        return Infos(newText, this.autoCloseTimeout)
    }

    Destroy(*) {
        try HotIfWinExist("ahk_id " this.gInfo.Hwnd)
        catch Any {
            return false
        }
        Hotkey("Escape", "Off")
        Hotkey("^Escape", "Off")
        if this.spaceIndex <= Infos.maxNumberedHotkeys
            Hotkey("F" this.spaceIndex, "Off")
        this.gInfo.Destroy()
        Infos.spots[this.spaceIndex] := false
        return true
    }


    _CreateGui() {
        this.gInfo  := Gui("AlwaysOnTop -Caption +ToolWindow").DarkMode().MakeFontNicer(Infos.fontSize).NeverFocusWindow()
        this.gcText := this.gInfo.AddText(, this._FormatText())
    }

    _FormatText() {
        text := String(this.text)
        lines := text.Split("`n")
        if lines.Length > 1 {
            text := this._FormatByLine(lines)
        }
        else {
            text := this._LimitWidth(text)
        }
        return text.Replace("&", "&&")
    }

    _FormatByLine(lines) {
        newLines := []
        for index, line in lines {
            newLines.Push(this._LimitWidth(line))
        }
        text := ""
        for index, line in newLines {
            if index = newLines.Length {
                text .= line
                break
            }
            text .= line "`n"
        }
        return text
    }

    _LimitWidth(text) {
        if StrLen(text) < Infos.maxWidthInChars {
            return text
        }
        insertions := 0
        while (insertions + 1) * Infos.maxWidthInChars + insertions < StrLen(text) {
            insertions++
            text := text.Insert("`n", insertions * Infos.maxWidthInChars + insertions)
        }
        return text
    }

    _GetAvailableSpace() {
        spaceIndex := unset
        for index, isOccupied in Infos.spots {
            if isOccupied
                continue
            spaceIndex := index
            Infos.spots[spaceIndex] := this
            break
        }
        if !IsSet(spaceIndex)
            return false
        this.spaceIndex := spaceIndex
        return true
    }

    _CalculateYCoord() => Round(this.spaceIndex * Infos.guiWidth - Infos.guiWidth)

    _StopDueToNoSpace() => this.gInfo.Destroy()

    _SetupHotkeysAndEvents() {
        HotIfWinExist("ahk_id " this.gInfo.Hwnd)
        Hotkey("Escape", this.bfDestroy, "On")
        Hotkey("^Escape", Infos.foDestroyAll, "On")
        if this.spaceIndex <= Infos.maxNumberedHotkeys
            Hotkey("F" this.spaceIndex, this.bfDestroy, "On")
        this.gcText.OnEvent("Click", this.bfDestroy)
        this.gInfo.OnEvent("Close", this.bfDestroy)
    }

    _SetupAutoclose() {
        if this.autoCloseTimeout {
            SetTimer(this.bfDestroy, -this.autoCloseTimeout)
        }
    }

    _Show() => this.gInfo.Show("AutoSize NA x0 y" this._CalculateYCoord())

}

Info(text, timeout?) => Infos(text, timeout ?? 2000)