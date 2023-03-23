#Include <Extensions\Map>
#Include <Tools\StateBulb>

class Language {

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
        set {
            switch Type(value) {
                case "String": code := this.LangToCode[value]
                default:       throw ValueError("Wrong type passed.")
            }
            this._current := code
            this._ChangeLanguage(code)
        }
    }

    static CodeToLang := Map(
        "0x4090409", "English",
        "0x4190419", "Russian"
    )

    static LangToCode := this.CodeToLang.Reverse()

    static _current := this.LangToCode["English"]


    static ToRussian() {
        this.CurrentWord := "Russian"
        StateBulb[3].Create()
    }
    static ToEnglish() {
        this.CurrentWord := "English"
        StateBulb[3].Destroy()
    }

    static Toggle() {
        switch this.CurrentWord {
            case "Russian": this.ToEnglish()
            case "English": this.ToRussian()
        }
        return this
    }


    static _GetCurrentLanguageCode() => "0x" Format("{:x}", dllCall("GetKeyboardLayout", "int", 0))

    static _ChangeLanguage(languageCode) {
        try PostMessage(0x0050,, languageCode,, "A")
    }

}