#Include <Tools\ToggleInfo>
#Include <Environment>
#Include <Abstractions\Mouse>

ToggleVimMode() {
    Environment.VimMode := !Environment.VimMode
    position := Environment.VimMode ? "On" : "Off"
    ToggleInfo("Vim mode " position)
}
#sc33::ToggleVimMode()

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

*u::Click()
*o::Click("Right")
*i::Click("Middle")
#u::Mouse.HoldIfUp("L")
#o::Mouse.HoldIfUp("R")
#i::Mouse.HoldIfUp("M")

1::MouseMove(Mouse.FarLeftX,        Mouse.MiddleY)
2::MouseMove(Mouse.LowLeftX,        Mouse.MiddleY)
3::MouseMove(Mouse.MiddleLeftX,     Mouse.MiddleY)
4::MouseMove(Mouse.HighLeftX,       Mouse.MiddleY)
5::MouseMove(Mouse.LessThanMiddleX, Mouse.MiddleY)
6::MouseMove(Mouse.MoreThanMiddleX, Mouse.MiddleY)
7::MouseMove(Mouse.LowRightX,       Mouse.MiddleY)
8::MouseMove(Mouse.MiddleRightX,    Mouse.MiddleY)
9::MouseMove(Mouse.HighRightX,      Mouse.MiddleY)
0::MouseMove(Mouse.FarRightX,       Mouse.MiddleY)

+1::MouseMove(Mouse.FarLeftX,        Mouse.TopY)
+2::MouseMove(Mouse.LowLeftX,        Mouse.TopY)
+3::MouseMove(Mouse.MiddleLeftX,     Mouse.TopY)
+4::MouseMove(Mouse.HighLeftX,       Mouse.TopY)
+5::MouseMove(Mouse.LessThanMiddleX, Mouse.TopY)
+6::MouseMove(Mouse.MoreThanMiddleX, Mouse.TopY)
+7::MouseMove(Mouse.LowRightX,       Mouse.TopY)
+8::MouseMove(Mouse.MiddleRightX,    Mouse.TopY)
+9::MouseMove(Mouse.HighRightX,      Mouse.TopY)
+0::MouseMove(Mouse.FarRightX,       Mouse.TopY)

^1::MouseMove(Mouse.FarLeftX,        Mouse.BottomY)
^2::MouseMove(Mouse.LowLeftX,        Mouse.BottomY)
^3::MouseMove(Mouse.MiddleLeftX,     Mouse.BottomY)
^4::MouseMove(Mouse.HighLeftX,       Mouse.BottomY)
^5::MouseMove(Mouse.LessThanMiddleX, Mouse.BottomY)
^6::MouseMove(Mouse.MoreThanMiddleX, Mouse.BottomY)
^7::MouseMove(Mouse.LowRightX,       Mouse.BottomY)
^8::MouseMove(Mouse.MiddleRightX,    Mouse.BottomY)
^9::MouseMove(Mouse.HighRightX,      Mouse.BottomY)
^0::MouseMove(Mouse.FarRightX,       Mouse.BottomY)

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