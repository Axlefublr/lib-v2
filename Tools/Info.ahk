#Include <Extensions\Gui>

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
        this._DoOnce()
        if !this._GetAvailableSpace() {
            this._StopDueToNoSpace()
            return
        }
        this._SetupHotkeysAndEvents()
        this._SetupAutoclose()
        this._Show()
    }

    static fontSize         := 20
    static ranOnce          := false
    static guiWidthModifier := 5

    static guiWidth        := unset
    static maximumInfos    := unset
    static AvailablePlaces := []


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

        ; If the gui doesn't exist
        try WinExist(this.gInfo) ; Not an if because we can't access the gui object once it's destroyed
        catch
            return Infos(newText, this.autoCloseTimeout)

        ; If the text provided is the same length as in the existing gui's window
        if StrLen(newText) = StrLen(this.gcText.Text) {
            this.gcText.Text := newText
            this._SetupAutoclose()
            return this
        }

        ; If the text length is different, but the window exists (it's a refresh)
        Infos.AvailablePlaces[this.spaceIndex] := false
        return Infos(newText, this.autoCloseTimeout)
    }

    Destroy(*) {
        try HotIfWinExist("ahk_id " this.gInfo.Hwnd)
        catch Any {
            return false
        }
        Hotkey("Escape", "Off")
        this.gInfo.Destroy()
        Infos.AvailablePlaces[this.spaceIndex] := false
        return true
    }


    _CreateGui() {
        this.gInfo  := Gui("AlwaysOnTop -Caption +ToolWindow").DarkMode().MakeFontNicer(Infos.fontSize)
        this.gcText := this.gInfo.AddText(, this.text)
    }

    _DoOnce() {
        if Infos.ranOnce {
            return
        }

        Infos.guiWidth     := this.gInfo.MarginY * Infos.guiWidthModifier
        Infos.maximumInfos := Floor(A_ScreenHeight / Infos.guiWidth)

        loop Infos.maximumInfos {
            Infos.AvailablePlaces.Push(false)
        }
        Infos.ranOnce := true
    }

    _GetAvailableSpace() {
        spaceIndex := unset
        for index, isOccupied in Infos.AvailablePlaces {
            if isOccupied
                continue
            spaceIndex := index
            Infos.AvailablePlaces[spaceIndex] := true
            break
        }
        if !IsSet(spaceIndex)
            return false
        this.spaceIndex := spaceIndex
        return true
    }

    _CalculateYCoord() => this.spaceIndex * Infos.guiWidth - Infos.guiWidth

    _StopDueToNoSpace() => this.gInfo.Destroy()

    _SetupHotkeysAndEvents() {
        HotIfWinExist("ahk_id " this.gInfo.Hwnd)
        Hotkey("Escape", this.bfDestroy, "On")
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