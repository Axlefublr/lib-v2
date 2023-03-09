#Include <Tools\Info>
#Include <Environment>
#Include <Tools\Counter>
#Include <Tools\HoverScreenshot>

#^F1::return
#^F2::return
#^F3::return
#^F4::return
#^F5::return
#^F6::return
#^F7::return
#^F8::return
#^F9::return
#^F10::return
#^F11::return
#^F12::return
#^sc29::return
#^1::return
#^2::return
#^3::return
#^4::return
#^5::return
#^6::return
#^7::return
#^8::return
#^9::return
#^0::return
#^-::Counter.Decrement().Show()
#^=::Counter.Increment().Show()
#^q::return
#^w::HoverScreenshot(Paths.Ptf["welp"]).Show()
#^e::SoundPlayer.Storage["heheheha"].Play()
#^r::SoundPlayer.Storage["rizz"].Play()
#^t::SoundPlayer.Storage["ting"].Play()
#^y::HoverScreenshot(Paths.Ptf["writing fire"]).Show()
#^u::HoverScreenshot(Paths.Ptf["urethra"]).Show()
#^i:: {
    static counter := false
    counter := !counter
    if counter {
        SoundPlayer.Storage["bing chilling 1"].Play()
    } else {
        SoundPlayer.Storage["bing chilling 2"].Play()
    }
}
#^o::SoundPlayer.Storage["hohoho"].Play()
#^p::return
#^sc1A::Counter.Send()
#^sc1B::Counter.Send().Increment()
#^sc2B:: {
    if !input := CleanInputBox().WaitForInput() {
        return
    }
    Counter.num := input
    Counter.Show()
}
#^a::SoundPlayer.Storage["shutter"].Play()
#^s::SoundPlayer.Storage["sus"].Play()
#^d::SoundPlayer.Storage["oh fr on god"].Play()
#^f::SoundPlayer.Storage["faded than a hoe"].Play()
#^g::HoverScreenshot(Paths.Ptf["do you have the slightest idea how little that narrows it down"]).Show()
#^h::SoundPlayer.Storage["shall we"].Play()
#^j::SoundPlayer.Storage["i just farted"].Play()
#^k::return
#^l::return
#^sc27::Counter.Show()
#^sc28::Counter.Reset().Show()
#^z::return
#^x::return
#^c::SoundPlayer.Storage["cartoon"].Play()
#^v::SoundPlayer.Storage["vine boom"].Play()
#^b::SoundPlayer.Storage["bruh sound effect"].Play()
#^n::HoverScreenshot(Paths.Ptf["how did we get here"]).Show()
#^m::HoverScreenshot(Paths.Ptf["femboy"]).Show()
#^sc33::return
#^sc34::return
#^sc35::return