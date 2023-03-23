#Include <Extensions\Map>
#Include <Tools\StateBulb>

class Language {

    static __New() {
        if this._current = this.LangToCode["Russian"]
            StateBulb[3].Create()
    }


    static _current := this._GetCurrentLanguageCode()

    static Current {
        get => this._current
        set {
            switch Type(value) {
                case "String":  code := this.LangToCode[value]
                case "Integer": code := value
                default:        throw ValueError("Wrong type passed.")
            }
            this._current := code
            this._ChangeLanguage(code)
        }
    }

    static CurrentWord {
        get => this.CodeToLang[this._current]
    }

    static CodeToLang := Map(
        "0x4090409", "English",
        "0x4190419", "Russian"
    )

    static LangToCode := this.CodeToLang.Reverse()


    static ToRussian() {
        this.Current := "Russian"
        StateBulb[3].Create()
    }
    static ToEnglish() {
        this.Current := "English"
        StateBulb[3].Destroy()
    }

    static Toggle() {
        switch this.CurrentWord {
            case "Russian": this.ToEnglish()
            case "English": this.ToRussian()
        }
    }


    static _GetCurrentLanguageCode() => "0x" Format("{:x}", dllCall("GetKeyboardLayout", "int", 0))

    static _ChangeLanguage(languageCode) {
        try PostMessage(0x0050,, languageCode,, "A")
    }

}