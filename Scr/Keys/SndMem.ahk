#Include <Tools\Info>
#Include <Environment>
#Include <Tools\Counter>
#Include <Tools\HoverScreenshot>
#Include <Abstractions\Registers>
#Include <Utils\GetInput>

_BingChilling() {
    static counter := false
    counter := !counter
    if counter {
        SoundPlayer.Storage["bing chilling 1"].Play()
    } else {
        SoundPlayer.Storage["bing chilling 2"].Play()
    }
}

#sc35:: {
    sValidKeys := Registers.ValidRegisters "[]\{}|-=_+;:'`",<.>/?"
    try key := Registers.ValidateKey(GetInput("L1", "{Esc}").Input, sValidKeys)
    catch UnsetItemError {
        Registers.CancelAction()
        return
    }
    static sndMems := Map(

        "q", () => 0,
        "w", () => HoverScreenshot(Paths.Ptf["welp"]).Show(),
        "e", () => SoundPlayer.Storage["heheheha"].Play(),
        "r", () => SoundPlayer.Storage["rizz"].Play(),
        "t", () => SoundPlayer.Storage["ting"].Play(),
        "y", () => HoverScreenshot(Paths.Ptf["writing fire"]).Show(),
        "u", () => HoverScreenshot(Paths.Ptf["urethra"]).Show(),
        "i", _BingChilling,
        "o", () => SoundPlayer.Storage["hohoho"].Play(),
        "p", () => 0,
        "[", () => 0,
        "]", () => 0,
        "\", () => 0,
        "a", () => SoundPlayer.Storage["shutter"].Play(),
        "s", () => SoundPlayer.Storage["sus"].Play(),
        "d", () => SoundPlayer.Storage["oh fr on god"].Play(),
        "f", () => SoundPlayer.Storage["faded than a hoe"].Play(),
        "g", () => HoverScreenshot(Paths.Ptf["do you have the slightest idea how little that narrows it down"]).Show(),
        "h", () => SoundPlayer.Storage["shall we"].Play(),
        "j", () => SoundPlayer.Storage["i just farted"].Play(),
        "k", () => SoundPlayer.Storage["was that his cock"].Play(),
        "l", () => SoundPlayer.Storage["cyberpunk"].Play(),
        ";", () => 0,
        "'", () => SoundPlayer.Storage["better call saul"].Play(),
        "z", () => 0,
        "x", () => 0,
        "c", () => SoundPlayer.Storage["cartoon"].Play(),
        "v", () => SoundPlayer.Storage["vine boom"].Play(),
        "b", () => SoundPlayer.Storage["bruh sound effect"].Play(),
        "n", () => HoverScreenshot(Paths.Ptf["how did we get here"]).Show(),
        "m", () => HoverScreenshot(Paths.Ptf["femboy"]).Show(),
        ",", () => 0,
        ".", () => 0,
        "/", () => 0,

    )
    try sndMems[key].Call()
}