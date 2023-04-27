#Include <Extensions\Array>
#Include <Extensions\String>
#Include <Utils\ClipSend>
#Include <Tools\Info>

class Hotstringer {

    static DynamicHotstrings := Map()
    static StaticHotstrings  := Map()
    static EndKeys := "{Esc} "
    static AcceptEndKeys := ["Space"]

    static Initiate() {
        this.ih := InputHook(, this.EndKeys)
        this.ih.Start()
        this.ih.Wait()
        if this.ih.EndReason = "EndKey" && this.ih.EndKey != "Space" {
            Info("exited", 500)
            return
        }
        this.Paste()
    }

    static Paste() {
        if this.DynamicHotstrings.Has(this.ih.Input)
            output := this.DynamicHotstrings[this.ih.Input].Call()
        else
            output := this.StaticHotstrings[this.ih.Input]
        ClipSend(output)
    }


    static _CollectMatchList() {
        hasSingleComma := "(?<!,),(?!,)"
        matchList := ""
        for key, _ in this.DynamicHotstrings {
            if key.RegExMatch(hasSingleComma)
                throw ValueError("Make sure to put two commas for one comma",, -1)
            matchList .= key ","
        }
        for key, _ in this.StaticHotstrings {
            if key.RegExMatch(hasSingleComma)
                throw ValueError("Make sure to put two commas for one comma",, -1)
            matchList .= key ","
        }
        return matchList
    }

}