#Include <Tools\ToggleInfo>
#Include <Environment>

#sc28:: {
    Environment.VimMode := !Environment.VimMode
    position := Environment.VimMode ? "On" : "Off"
    ToggleInfo("Vim mode " position)
}

#HotIf Environment.VimMode
j::Down
k::Up
h::Left
l::Right
u::Home
i::End
y::PgUp
o::PgDn
m::WheelLeft
sc33::WheelUp
sc34::WheelDown
sc35::WheelRight
#HotIf