#Include <Utils\Unicode>
#Include <Abstractions\Registers>

#sc27:: {
    sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
    try key := Registers.ValidateKey(KeyChorder(), sValidKeys)
    catch UnsetItemError {
        Registers.CancelAction()
        return
    }
    static symbols := Map(

        "f", () => Unicode.Send("fearful"),      ; 😨
        "d", () => Unicode.Send("smiling imp"),  ; 😈
        "p", () => Unicode.Send("purple heart"), ; 💜
        "r", () => Unicode.Send("rolling eyes"), ; 🙄
        "h", () => Unicode.Send("handshake"),    ; 🤝
        "s", () => Unicode.Send("shrug"),        ; 🤷
        "n", () => Unicode.Send("nerd"),         ; 🤓
        "a", () => Unicode.Send("amogus"),       ; ඞ
        "[", () => Unicode.Send("confetti"),     ; 🎉

    )
    if key
        try symbols[key].Call()
}

#y::Unicode.Send("pleading")                       ; 🥺
#u::Unicode.Send("yum")                            ; 😋
#i::Unicode.Send("exploding head")                 ; 🤯
#o::Unicode.Send("smirk cat")                      ; 😼
#p::Unicode.Send("sunglasses")                     ; 😎
#sc1a::Unicode.Send("weary")                       ; 😩
#sc1b::Unicode.Send("drooling")                    ; 🤤
#sc2b::Unicode.Send("finger right", "finger left") ; 👉👈
#6::Unicode.Send("sob")                            ; 😭
#7::Unicode.Send("face with monocle")              ; 🧐
#8::Unicode.Send("flushed")                        ; 😳
#9::Unicode.Send("face with raised eyebrow")       ; 🤨
#0::Unicode.Send("thinking")                       ; 🤔
#-::Unicode.Send("long dash", " ")                 ; —
#=::Unicode.Send("skull")                          ; 💀