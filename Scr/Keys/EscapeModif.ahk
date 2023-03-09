#Include <Tools\Info>
#Include <Environment>
#Include <Tools\Counter>
#Include <Tools\HoverScreenshot>

Escape::Escape
Escape & sc29::return
Escape & 1::return
Escape & 2::return
Escape & 3::return
Escape & 4::return
Escape & 5::return
Escape & 6::return
Escape & 7::return
Escape & 8::return
Escape & 9::return
Escape & 0::return
Escape & -::Counter.Decrement().Show()
Escape & =::Counter.Increment().Show()
Escape & q::return
Escape & w::HoverScreenshot(Paths.Ptf["welp"]).Show()
Escape & e::SoundPlayer.Storage["heheheha"].Play()
Escape & r::SoundPlayer.Storage["rizz"].Play()
Escape & t::SoundPlayer.Storage["ting"].Play()
Escape & y::HoverScreenshot(Paths.Ptf["writing fire"]).Show()
Escape & u::HoverScreenshot(Paths.Ptf["urethra"]).Show()
Escape & i:: {
    static counter := false
    counter := !counter
    if counter {
        SoundPlayer.Storage["bing chilling 1"].Play()
    } else {
        SoundPlayer.Storage["bing chilling 2"].Play()
    }
}
Escape & o::SoundPlayer.Storage["hohoho"].Play()
Escape & p::return
Escape & sc1A::Counter.Send()
Escape & sc1B::Counter.Send().Increment()
Escape & sc2B:: {
    if !input := CleanInputBox().WaitForInput() {
        return
    }
    Counter.num := input
    Counter.Show()
}
Escape & a::SoundPlayer.Storage["shutter"].Play()
Escape & s::SoundPlayer.Storage["sus"].Play()
Escape & d::SoundPlayer.Storage["oh fr on god"].Play()
Escape & f::SoundPlayer.Storage["faded than a hoe"].Play()
Escape & g::HoverScreenshot(Paths.Ptf["do you have the slightest idea how little that narrows it down"]).Show()
Escape & h::SoundPlayer.Storage["shall we"].Play()
Escape & j::SoundPlayer.Storage["i just farted"].Play()
Escape & k::return
Escape & l::return
Escape & sc27::Counter.Reset().Show()
Escape & sc28::Counter.Show()
Escape & z::return
Escape & x::return
Escape & c::SoundPlayer.Storage["cartoon"].Play()
Escape & v::SoundPlayer.Storage["vine boom"].Play()
Escape & b::SoundPlayer.Storage["bruh sound effect"].Play()
Escape & n::HoverScreenshot(Paths.Ptf["how did we get here"]).Show()
Escape & m::HoverScreenshot(Paths.Ptf["femboy"]).Show()
Escape & sc33::return
Escape & sc34::return
Escape & sc35::return