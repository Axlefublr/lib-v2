#Include <Tools\ToggleInfo>
#Include <Environment>
#Include <Abstractions\Mouse>

#sc33:: {
    Environment.VimMode := !Environment.VimMode
    position := Environment.VimMode ? "On" : "Off"
    ToggleInfo("Vim mode " position)
}

#HotIf Environment.VimMode
h::Mouse.MoveLeft(Mouse.SmallMove)
k::Mouse.MoveUp(Mouse.SmallMove)
j::Mouse.MoveDown(Mouse.SmallMove)
l::Mouse.MoveRight(Mouse.SmallMove)
+h::Mouse.MoveLeft(Mouse.MediumMove)
+k::Mouse.MoveUp(Mouse.MediumMove)
+j::Mouse.MoveDown(Mouse.MediumMove)
+l::Mouse.MoveRight(Mouse.MediumMove)
^h::Mouse.MoveLeft(Mouse.BigMove)
^k::Mouse.MoveUp(Mouse.BigMove)
^j::Mouse.MoveDown(Mouse.BigMove)
^l::Mouse.MoveRight(Mouse.BigMove)
u::Click()
+u::Mouse.HoldIfUp("L")
o::Click("Right")
+o::Mouse.HoldIfUp("R")
i::Click("Middle")
+i::Mouse.HoldIfUp("M")
d::Down
s::Up
a::Left
f::Right
w::Home
e::End
q::PgUp
r::PgDn
z::WheelLeft
x::WheelUp
c::WheelDown
v::WheelRight
#HotIf