#Include <Utils\Unicode>
#Include <Abstractions\Registers>
#Include <Utils\GetInput>

#sc27:: {
    sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
    try key := Registers.ValidateKey(GetInput("L1", "{Esc}").Input, sValidKeys)
    catch UnsetItemError {
        Registers.CancelAction()
        return
    }
    static symbols := Map(

        "f", () => Unicode.Send("fearful"),                     ; 😨
        "d", () => Unicode.Send("smiling imp"),                 ; 😈
        "h", () => Unicode.Send("purple heart"),                ; 💜
        "r", () => Unicode.Send("rolling eyes"),                ; 🙄
        "H", () => Unicode.Send("handshake"),                   ; 🤝
        "s", () => Unicode.Send(
            "shrug", "zwj", "female sign", "varsel16"),         ; 🤷‍♀️
        "n", () => Unicode.Send("nerd"),                        ; 🤓
        "a", () => Unicode.Send("amogus"),                      ; ඞ
        "c", () => Unicode.Send("confetti"),                    ; 🎉
        "y", () => Unicode.Send("pleading"),                    ; 🥺
        "u", () => Unicode.Send("yum"),                         ; 😋
        "i", () => Unicode.Send("exploding head"),              ; 🤯
        "o", () => Unicode.Send("smirk cat"),                   ; 😼
        "p", () => Unicode.Send("sunglasses"),                  ; 😎
        "[", () => Unicode.Send("weary"),                       ; 😩
        "]", () => Unicode.Send("drooling"),                    ; 🤤
        "\", () => Unicode.Send("finger right", "finger left"), ; 👉👈
        "6", () => Unicode.Send("sob"),                         ; 😭
        "7", () => Unicode.Send("face with monocle"),           ; 🧐
        "8", () => Unicode.Send("flushed"),                     ; 😳
        "9", () => Unicode.Send("face with raised eyebrow"),    ; 🤨
        "t", () => Unicode.Send("thinking"),                    ; 🤔
        "-", () => Unicode.Send("long dash", " "),              ; —
        "=", () => Unicode.Send("skull"),                       ; 💀
        "e", () => Unicode.Send("eyes"),                        ; 👀
        "z", () => Unicode.Send("sneezing face"),               ; 🤧
        "g", () => Unicode.Send("grimacing"),                   ; 😬
        "d", () => Unicode.Send("crossed out", "zwj", "dizzy"), ;
        "l", () => Unicode.Send("face with hearts"),            ; 🥰

    )
    if key
        try symbols[key].Call()
}