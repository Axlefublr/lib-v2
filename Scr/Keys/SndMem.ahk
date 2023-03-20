#Include <Tools\Info>
#Include <Environment>
#Include <Tools\Counter>
#Include <Tools\HoverScreenshot>

#sc35::Environment.SndMem := !Environment.SndMem
#HotIf Environment.SndMem

Escape::Environment.SndMem := false
q::return
w::HoverScreenshot(Paths.Ptf["welp"]).Show()
e::SoundPlayer.Storage["heheheha"].Play()
r::SoundPlayer.Storage["rizz"].Play()
t::SoundPlayer.Storage["ting"].Play()
y::HoverScreenshot(Paths.Ptf["writing fire"]).Show()
u::HoverScreenshot(Paths.Ptf["urethra"]).Show()
i:: {
    static counter := false
    counter := !counter
    if counter {
        SoundPlayer.Storage["bing chilling 1"].Play()
    } else {
        SoundPlayer.Storage["bing chilling 2"].Play()
    }
}
o::SoundPlayer.Storage["hohoho"].Play()
p::return
sc1A::return
sc1B::return
sc2B::return
a::SoundPlayer.Storage["shutter"].Play()
s::SoundPlayer.Storage["sus"].Play()
d::SoundPlayer.Storage["oh fr on god"].Play()
f::SoundPlayer.Storage["faded than a hoe"].Play()
g::HoverScreenshot(Paths.Ptf["do you have the slightest idea how little that narrows it down"]).Show()
h::SoundPlayer.Storage["shall we"].Play()
j::SoundPlayer.Storage["i just farted"].Play()
k::return
l::return
sc28::return
sc29::return
z::return
x::return
c::SoundPlayer.Storage["cartoon"].Play()
v::SoundPlayer.Storage["vine boom"].Play()
b::SoundPlayer.Storage["bruh sound effect"].Play()
n::HoverScreenshot(Paths.Ptf["how did we get here"]).Show()
m::HoverScreenshot(Paths.Ptf["femboy"]).Show()
sc33::return
sc34::return
sc35::return

#HotIf