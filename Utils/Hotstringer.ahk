#Include <Extensions\String>
#Include <Utils\ClipSend>

class Hotstringer {

    static DynamicHotstrings := Map()
    static StaticHotstrings  := Map()
    static MatchList := this._CollectMatchList()
    static EndKeys := "{Esc}"

    static Initiate() {
        this.ih := InputHook("v", this.EndKeys, this.MatchList)
        this.ih.Start()
        this.ih.Wait()
        this._BackspaceHotstring()
    }


    static _BackspaceHotstring() => Send(Format("{Bs {1}}", this.ih.Input.Length))

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